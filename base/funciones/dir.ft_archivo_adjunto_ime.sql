CREATE OR REPLACE FUNCTION dir.ft_archivo_adjunto_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Empresas
 FUNCION: 		dir.ft_archivo_adjunto_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'dir.tarchivo_adjunto'
 AUTOR: 		 (admin)
 FECHA:	        25-06-2013 01:10:51
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
	v_id_archivo_adjunto	integer;
			    
BEGIN

    v_nombre_funcion = 'dir.ft_archivo_adjunto_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DIR_ARCADJ_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		25-06-2013 01:10:51
	***********************************/

	if(p_transaccion='DIR_ARCADJ_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into dir.tarchivo_adjunto(
			id_plantilla_correo,
			estado_reg,
			archivo,
			extension_archivo,
			nombre_archivo,
			fecha_reg,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_plantilla_correo,
			'activo',
			v_parametros.archivo,
			v_parametros.extension_archivo,
			v_parametros.nombre_archivo,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_archivo_adjunto into v_id_archivo_adjunto;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivo Adjunto almacenado(a) con exito (id_archivo_adjunto'||v_id_archivo_adjunto||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_archivo_adjunto',v_id_archivo_adjunto::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'DIR_ARCADJ_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		25-06-2013 01:10:51
	***********************************/

	elsif(p_transaccion='DIR_ARCADJ_MOD')then

		begin
			--Sentencia de la modificacion
			update dir.tarchivo_adjunto set
			id_plantilla_correo = v_parametros.id_plantilla_correo,
			archivo = v_parametros.archivo,
			extension_archivo = v_parametros.extension_archivo,
			nombre_archivo = v_parametros.nombre_archivo,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_archivo_adjunto=v_parametros.id_archivo_adjunto;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivo Adjunto modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_archivo_adjunto',v_parametros.id_archivo_adjunto::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'DIR_ARCADJ_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		25-06-2013 01:10:51
	***********************************/

	elsif(p_transaccion='DIR_ARCADJ_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from dir.tarchivo_adjunto
            where id_archivo_adjunto=v_parametros.id_archivo_adjunto;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivo Adjunto eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_archivo_adjunto',v_parametros.id_archivo_adjunto::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
        
     /*********************************    
 	#TRANSACCION:  'DIR_UPARCH_INS'
 	#DESCRIPCION:	Upload de archivo
 	#AUTOR:			Gonzalo Sarmiento Sejas
 	#FECHA:			25-06-2013
	***********************************/
    elsif(p_transaccion='DIR_UPARCH_INS')then
     	begin
        	insert into dir.tarchivo_adjunto (
            id_plantilla_correo,
            extension_archivo,
            nombre_archivo,
            archivo,
            fecha_reg,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod)
            values (
            v_parametros.id_plantilla_correo,
            v_parametros.extension,
            v_parametros.filename,
            v_parametros.archivo,
            now(),
            p_id_usuario,
            NULL,
            NULL)
            RETURNING id_archivo_adjunto into v_id_archivo_adjunto;

            --Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivo Adjunto almacenado(a) con exito (id_archivo_adjunto'||v_id_archivo_adjunto||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_archivo_adjunto',v_id_archivo_adjunto::varchar);

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