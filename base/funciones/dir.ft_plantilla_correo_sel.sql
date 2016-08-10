CREATE OR REPLACE FUNCTION dir.ft_plantilla_correo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Empresas
 FUNCION: 		dir.ft_plantilla_correo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'dir.tplantilla_correo'
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'dir.ft_plantilla_correo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DIR_PLCR_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		24-06-2013 21:08:35
	***********************************/

	if(p_transaccion='DIR_PLCR_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						plcr.id_plantilla_correo,
						plcr.estado_reg,
						plcr.body,
						plcr.codigo,
                        plcr.remitente_nombre,
                        plcr.remitente_email,
                        plcr.asunto,
                        plcr.fecha_reg,
						plcr.id_usuario_reg,
						plcr.id_usuario_mod,
						plcr.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from dir.tplantilla_correo plcr
						inner join segu.tusuario usu1 on usu1.id_usuario = plcr.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = plcr.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'DIR_PLCR_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		24-06-2013 21:08:35
	***********************************/

	elsif(p_transaccion='DIR_PLCR_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_plantilla_correo)
					    from dir.tplantilla_correo plcr
					    inner join segu.tusuario usu1 on usu1.id_usuario = plcr.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = plcr.id_usuario_mod
					    where ';
			
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