CREATE OR REPLACE FUNCTION dir.ft_publicidad_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Empresas
 FUNCION: 		dir.ft_publicidad_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'dir.tpublicidad'
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
    v_resultado			record;
    v_actividad			integer;
			    
BEGIN

	v_nombre_funcion = 'dir.ft_publicidad_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DIR_CAMP_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		25-06-2013 21:50:18
	***********************************/

	if(p_transaccion='DIR_CAMP_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						camp.id_publicidad,
						camp.estado_reg,
						camp.tiempo,
						camp.hora_envio,
                        camp.id_lugar,
						lug.nombre as lugar,
						camp.estado,
						camp.id_actividad,
                        act.nombre as actividad,
						camp.correos_exitos,
                    	camp.correos_fallidos,
						camp.cantidad_publicidad,
						camp.id_plantilla_correo,
                        plt.codigo as plantilla_correo,
						camp.fecha_reg,
						camp.id_usuario_reg,
						camp.fecha_mod,
						camp.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from dir.tpublicidad camp
						inner join segu.tusuario usu1 on usu1.id_usuario = camp.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = camp.id_usuario_mod
				        left join param.tlugar lug on lug.id_lugar = camp.id_lugar
                        left join dir.tactividad act on act.id_actividad=camp.id_actividad
                        inner join dir.tplantilla_correo plt on plt.id_plantilla_correo=camp.id_plantilla_correo
                        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
	
    /*********************************    
 	#TRANSACCION:  'DIR_CAMPELE_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		26-06-2013 21:50:18
	***********************************/
    
    elsif(p_transaccion='DIR_CAMPELE_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						camp.tiempo,
						camp.hora_envio,
                        camp.id_lugar,
						lug.nombre as lugar,
						camp.id_actividad,
                        act.nombre as actividad,
						camp.puntero_publicidad,
						camp.cantidad_publicidad,
						camp.id_plantilla_correo,
                        plt.codigo as plantilla_correo,
                        plt.body,                        
                        plt.remitente_nombre,
                        plt.remitente_email,
                        plt.asunto,
                        camp.fecha_ult_envio
						from dir.tpublicidad camp
						left join param.tlugar lug on lug.id_lugar = camp.id_lugar
                        left join dir.tactividad act on act.id_actividad=camp.id_actividad
                        inner join dir.tplantilla_correo plt on plt.id_plantilla_correo=camp.id_plantilla_correo
                        where camp.id_publicidad='||v_parametros.id_publicidad||' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
    
    /*********************************    
 	#TRANSACCION:  'DIR_CORCAMP_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		26-06-2013 21:50:18
	***********************************/
    
    elsif(p_transaccion='DIR_CORCAMP_SEL')then
     				
    	begin
        
        	select id_actividad into v_actividad
            from dir.tpublicidad
            where id_publicidad=v_parametros.id_publicidad;
                        
            create temp table empresas(
                  email varchar,
                  nombre varchar
                ) on commit drop;
        	
            if v_actividad is not null then                
                  
                INSERT INTO empresas(
                WITH RECURSIVE actividades(id_actividad, email, nombre) 
                as(
                    select act.id_actividad, emp.email, emp.nombre
                    from dir.tactividad act
                    left join dir.tempresa emp on emp.id_actividad=act.id_actividad 
                    where act.id_actividad=v_actividad
                UNION ALL
                    select act.id_actividad, emp.email, emp.nombre
                    from dir.tactividad act
                    inner join actividades otro on otro.id_actividad=act.id_actividad_fk
                    left join dir.tempresa emp on emp.id_actividad=act.id_actividad
                )select email, nombre
                 from actividades
                 where email like '%@%');
                 
            end if;
              
            --Sentencia de la consulta
            v_consulta:='select * from empresas where ';
            
            --Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
            									
			--Devuelve la respuesta
			return v_consulta;
						
		end;
        
	/*********************************    
 	#TRANSACCION:  'DIR_CAMP_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		25-06-2013 21:50:18
	***********************************/

	elsif(p_transaccion='DIR_CAMP_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_publicidad)
					    from dir.tpublicidad camp
					    inner join segu.tusuario usu1 on usu1.id_usuario = camp.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = camp.id_usuario_mod
				        left join param.tlugar lug on lug.id_lugar = camp.id_lugar
                        left join dir.tactividad act on act.id_actividad=camp.id_actividad
                        inner join dir.tplantilla_correo plt on plt.id_plantilla_correo=camp.id_plantilla_correo
                        where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
	
    /*********************************    
 	#TRANSACCION:  'DIR_CAMPELE_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		26-06-2013 21:50:18
	***********************************/

	elsif(p_transaccion='DIR_CAMPELE_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_publicidad)
					    from dir.tpublicidad camp
					    inner join segu.tusuario usu1 on usu1.id_usuario = camp.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = camp.id_usuario_mod
				        left join param.tlugar lug on lug.id_lugar = camp.id_lugar
                        left join dir.tactividad act on act.id_actividad=camp.id_actividad
                        inner join dir.tplantilla_correo plt on plt.id_plantilla_correo=camp.id_plantilla_correo
                        where camp.id_publicidad='||v_parametros.id_publicidad||' and ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
	    				
	else
					     
		raise exception 'Transaccion inexistente';
					         
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