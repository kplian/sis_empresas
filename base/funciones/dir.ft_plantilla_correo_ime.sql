CREATE OR REPLACE FUNCTION dir.ft_plantilla_correo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Empresas
 FUNCION: 		dir.ft_plantilla_correo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'dir.tplantilla_correo'
 AUTOR: 		 (admin)
 FECHA:	        24-06-2013 21:08:35
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
	v_id_plantilla_correo	integer;
			    
BEGIN

    v_nombre_funcion = 'dir.ft_plantilla_correo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DIR_PLCR_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		24-06-2013 21:08:35
	***********************************/

	if(p_transaccion='DIR_PLCR_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into dir.tplantilla_correo(
			estado_reg,
			body,
			codigo,
            remitente_nombre,
            remitente_email,
            asunto,
			fecha_reg,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.body,
			v_parametros.codigo,
            v_parametros.remitente_nombre,
            v_parametros.remitente_email,
            v_parametros.asunto,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_plantilla_correo into v_id_plantilla_correo;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plantilla Correo almacenado(a) con exito (id_plantilla_correo'||v_id_plantilla_correo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_plantilla_correo',v_id_plantilla_correo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'DIR_PLCR_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		24-06-2013 21:08:35
	***********************************/

	elsif(p_transaccion='DIR_PLCR_MOD')then

		begin
			--Sentencia de la modificacion
			update dir.tplantilla_correo set
			body = v_parametros.body,
			codigo = v_parametros.codigo,
            remitente_nombre = v_parametros.remitente_nombre,
			remitente_email = v_parametros.remitente_email,
            asunto = v_parametros.asunto,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_plantilla_correo=v_parametros.id_plantilla_correo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plantilla Correo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_plantilla_correo',v_parametros.id_plantilla_correo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'DIR_PLCR_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		24-06-2013 21:08:35
	***********************************/

	elsif(p_transaccion='DIR_PLCR_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from dir.tplantilla_correo
            where id_plantilla_correo=v_parametros.id_plantilla_correo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plantilla Correo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_plantilla_correo',v_parametros.id_plantilla_correo::varchar);
              
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