CREATE OR REPLACE FUNCTION dir.ft_archivo_adjunto_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Empresas
 FUNCION: 		dir.ft_archivo_adjunto_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'dir.tarchivo_adjunto'
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'dir.ft_archivo_adjunto_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DIR_ARCADJ_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		25-06-2013 01:10:51
	***********************************/

	if(p_transaccion='DIR_ARCADJ_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						arcadj.id_archivo_adjunto,
						arcadj.id_plantilla_correo,
						arcadj.estado_reg,
						arcadj.archivo,
						arcadj.extension_archivo,
						arcadj.nombre_archivo,
						arcadj.fecha_reg,
						arcadj.id_usuario_reg,
						arcadj.id_usuario_mod,
						arcadj.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from dir.tarchivo_adjunto arcadj
						inner join segu.tusuario usu1 on usu1.id_usuario = arcadj.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = arcadj.id_usuario_mod
				        where id_plantilla_correo='||v_parametros.id_plantilla_correo||' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
        
	/*********************************    
 	#TRANSACCION:  'DIR_CAMPAR_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		26-06-2013 01:10:51
	***********************************/
    
	elsif(p_transaccion='DIR_CAMPAR_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						arcadj.archivo,
						arcadj.extension_archivo,
						arcadj.nombre_archivo
						from dir.tarchivo_adjunto arcadj
						inner join dir.tpublicidad camp on camp.id_plantilla_correo=arcadj.id_plantilla_correo
						where camp.id_publicidad='||v_parametros.id_publicidad||'';
			
			--Devuelve la respuesta
			return v_consulta;
						
		end;
    
	/*********************************    
 	#TRANSACCION:  'DIR_ARCADJ_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		25-06-2013 01:10:51
	***********************************/

	elsif(p_transaccion='DIR_ARCADJ_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_archivo_adjunto)
					    from dir.tarchivo_adjunto arcadj
					    inner join segu.tusuario usu1 on usu1.id_usuario = arcadj.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = arcadj.id_usuario_mod
					    where id_plantilla_correo='||v_parametros.id_plantilla_correo||' and ';
			
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