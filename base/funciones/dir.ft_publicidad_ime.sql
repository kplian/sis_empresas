--------------- SQL ---------------

CREATE OR REPLACE FUNCTION dir.ft_publicidad_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Empresas
 FUNCION: 		dir.ft_publicidad_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'dir.tpublicidad'
 AUTOR: 		 (admin)
 FECHA:	        25-06-2013 21:50:18
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
	v_id_publicidad	integer;
    v_id_lugar				integer;
    v_cantidad_inc			integer;
			    
BEGIN

    v_nombre_funcion = 'dir.ft_publicidad_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DIR_CAMP_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		25-06-2013 21:50:18
	***********************************/

	if(p_transaccion='DIR_CAMP_INS')then
					
        begin
        	select id_lugar	into v_id_lugar
            from param.tlugar 
            where nombre=v_parametros.lugar;
            
        	--Sentencia de la insercion
        	insert into dir.tpublicidad(
			estado_reg,
			tiempo,
			hora_envio,
			id_lugar,
			--estado,
			id_actividad,
			--puntero_publicidad,
			cantidad_publicidad,
			id_plantilla_correo,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.tiempo,
			v_parametros.hora_envio,
			v_id_lugar,
			--v_parametros.estado,
			v_parametros.id_actividad,
			--v_parametros.puntero_publicidad,
			v_parametros.cantidad_publicidad,
			v_parametros.id_plantilla_correo,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_publicidad into v_id_publicidad;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Campaña almacenado(a) con exito (id_publicidad'||v_id_publicidad||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_publicidad',v_id_publicidad::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'DIR_CAMP_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		25-06-2013 21:50:18
	***********************************/

	elsif(p_transaccion='DIR_CAMP_MOD')then

		begin
        	select id_lugar	into v_id_lugar
            from param.tlugar 
            where nombre=v_parametros.lugar;
        
			--Sentencia de la modificacion
			update dir.tpublicidad set
			tiempo = v_parametros.tiempo,
			hora_envio = v_parametros.hora_envio,
			id_lugar = v_id_lugar,
			--estado = v_parametros.estado,
			id_actividad = v_parametros.id_actividad,
			--puntero_publicidad = v_parametros.puntero_publicidad,
			cantidad_publicidad = v_parametros.cantidad_publicidad,
			id_plantilla_correo = v_parametros.id_plantilla_correo,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_publicidad=v_parametros.id_publicidad;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Campaña modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_publicidad',v_parametros.id_publicidad::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;
	
    /*********************************    
 	#TRANSACCION:  'DIR_AVACAMP_MOD'
 	#DESCRIPCION:	Avanza puntero
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		25-06-2013 21:50:18
	***********************************/

	elsif(p_transaccion='DIR_AVACAMP_MOD')then

		begin
        	/*select cantidad_publicidad into v_cantidad_inc
            from dir.tpublicidad 
            where id_publicidad=v_parametros.id_publicidad;*/
        
			--Sentencia de la modificacion
			update dir.tpublicidad set
			estado = 'en proceso',
			puntero_publicidad = puntero_publicidad+v_parametros.puntero_mail,
			fecha_ult_envio = now(),
            correos_exitos = correos_exitos+v_parametros.correos_exitos,
            correos_fallidos = correos_fallidos+v_parametros.correos_fallidos
			where id_publicidad=v_parametros.id_publicidad;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Campaña modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_publicidad',v_parametros.id_publicidad::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;
    
	/*********************************    
 	#TRANSACCION:  'DIR_CAMP_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		25-06-2013 21:50:18
	***********************************/

	elsif(p_transaccion='DIR_CAMP_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from dir.tpublicidad
            where id_publicidad=v_parametros.id_publicidad;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Campaña eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_publicidad',v_parametros.id_publicidad::varchar);
              
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