CREATE OR REPLACE FUNCTION dir.ft_empresa_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Empresas
 FUNCION: 		dir.ft_empresa_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'dir.tempresa'
 AUTOR: 		 (admin)
 FECHA:	        20-06-2013 13:33:33
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_empresa	integer;
    v_id_lugar				integer;
			    
BEGIN

    v_nombre_funcion = 'dir.ft_empresa_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DIR_EMPR_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-06-2013 13:33:33
	***********************************/

	if(p_transaccion='DIR_EMPR_INS')then
					
        begin
        
        	select id_lugar	into v_id_lugar
            from param.tlugar 
            where nombre=v_parametros.lugar;	
        
        	--Sentencia de la insercion
        	insert into dir.tempresa(
			estado_reg,
			nombre,
			domicilio,
			id_lugar,
			actividad,
			id_actividad,
			nit,
			email,
			matricula,
			telefono,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.nombre,
			v_parametros.domicilio,
			v_id_lugar,
			v_parametros.actividad,
			v_parametros.id_actividad_esp,
			v_parametros.nit,
			v_parametros.email,
			v_parametros.matricula,
			v_parametros.telefono,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_empresa into v_id_empresa;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Empresas almacenado(a) con exito (id_empresa'||v_id_empresa||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_empresa',v_id_empresa::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'DIR_EMPR_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-06-2013 13:33:33
	***********************************/

	elsif(p_transaccion='DIR_EMPR_MOD')then

		begin
        	select id_lugar	into v_id_lugar
            from param.tlugar 
            where nombre=v_parametros.lugar;
            
			--Sentencia de la modificacion
			update dir.tempresa set
			nombre = v_parametros.nombre,
			domicilio = v_parametros.domicilio,
			id_lugar = v_id_lugar,
			actividad = v_parametros.actividad,
			id_actividad = v_parametros.id_actividad_esp,
			nit = v_parametros.nit,
			email = v_parametros.email,
			matricula = v_parametros.matricula,
			telefono = v_parametros.telefono,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_empresa=v_parametros.id_empresa;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Empresas modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_empresa',v_parametros.id_empresa::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'DIR_EMPR_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-06-2013 13:33:33
	***********************************/

	elsif(p_transaccion='DIR_EMPR_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from dir.tempresa
            where id_empresa=v_parametros.id_empresa;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Empresas eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_empresa',v_parametros.id_empresa::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

	end if;

EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
				        
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;