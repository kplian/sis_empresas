CREATE OR REPLACE FUNCTION dir.ft_actividad_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Empresas
 FUNCION: 		dir.ft_actividad_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'dir.tactividad'
 AUTOR: 		 (admin)
 FECHA:	        20-06-2013 19:53:50
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
	v_id_actividad	integer;	
    v_codigo_largo			varchar;
			    
BEGIN

    v_nombre_funcion = 'dir.ft_actividad_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DIR_ACT_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-06-2013 19:53:50
	***********************************/

	if(p_transaccion='DIR_ACT_INS')then
					
        begin
        
        	--obtiene codigo recursivamente
            IF v_parametros.id_actividad_fk is null THEN
               v_codigo_largo = v_parametros.codigo;
            ELSE
            
             WITH RECURSIVE t(id,id_fk,cod,n) AS (
               SELECT a.id_actividad,a.id_actividad_fk, a.codigo,1 
               FROM dir.tactividad a 
               WHERE a.id_actividad = v_parametros.id_actividad_fk
              UNION ALL
               SELECT a.id_actividad,a.id_actividad_fk, a.codigo , n+1
               FROM dir.tactividad a, t
               WHERE a.id_actividad = t.id_fk
            )
            SELECT pxp.textcat_all(b.cod||'.')
             into  
             v_codigo_largo
            FROM (SELECT  cod
                  FROM t 
                 order by n desc)  b;
                 
                 
               v_codigo_largo = v_codigo_largo||v_parametros.codigo;
            END IF;
            
            
        	--Sentencia de la insercion
        	insert into dir.tactividad(
			estado_reg,
			codigo,
			codigo_largo,
			id_actividad_fk,
			nombre,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.codigo,
			v_codigo_largo,
			v_parametros.id_actividad_fk,
			v_parametros.nombre,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_actividad into v_id_actividad;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Rubro almacenado(a) con exito (id_actividad'||v_id_actividad||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_actividad',v_id_actividad::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'DIR_ACT_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-06-2013 19:53:50
	***********************************/

	elsif(p_transaccion='DIR_ACT_MOD')then

		begin
			
			--obtiene codigo recursivamente
            IF v_parametros.id_actividad_fk is null THEN
               v_codigo_largo = v_parametros.codigo;
            ELSE
            
             WITH RECURSIVE t(id,id_fk,cod,n) AS (
               SELECT a.id_actividad,a.id_actividad_fk, a.codigo,1 
               FROM dir.tactividad a 
               WHERE a.id_actividad = v_parametros.id_actividad_fk
              UNION ALL
               SELECT a.id_actividad,a.id_actividad_fk, a.codigo , n+1
               FROM dir.tactividad a, t
               WHERE a.id_actividad = t.id_fk
            )
            SELECT pxp.textcat_all(a.cod||'.')
             into  
             v_codigo_largo
            FROM (SELECT  cod
                  FROM t 
                 order by n desc)  a;
                 
                 
               v_codigo_largo = v_codigo_largo||v_parametros.codigo;
            END IF;
            
			--Sentencia de la modificacion
			update dir.tactividad set
			codigo = v_parametros.codigo,
			codigo_largo = v_codigo_largo,
			id_actividad_fk = v_parametros.id_actividad_fk,
			nombre = v_parametros.nombre,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_actividad=v_parametros.id_actividad;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Rubro modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_actividad',v_parametros.id_actividad::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'DIR_ACT_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-06-2013 19:53:50
	***********************************/

	elsif(p_transaccion='DIR_ACT_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from dir.tactividad
            where id_actividad=v_parametros.id_actividad;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Rubro eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_actividad',v_parametros.id_actividad::varchar);
              
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