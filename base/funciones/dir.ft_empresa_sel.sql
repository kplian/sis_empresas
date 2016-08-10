CREATE OR REPLACE FUNCTION dir.ft_empresa_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Empresas
 FUNCION: 		dir.ft_empresa_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'dir.tempresa'
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'dir.ft_empresa_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DIR_EMPR_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		20-06-2013 13:33:33
	***********************************/

	if(p_transaccion='DIR_EMPR_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						empr.id_empresa,
						empr.estado_reg,
						empr.nombre,
						empr.domicilio,
						lug.nombre as lugar,
						empr.actividad,
						gral.nombre as actividad_gral,
                        prim.nombre as actividad_prim,
						esp.nombre as actividad_esp,
						empr.nit,
						empr.email,
						empr.matricula,
						empr.telefono,
						empr.fecha_reg,
						empr.id_usuario_reg,
						empr.fecha_mod,
						empr.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from dir.tempresa empr
						inner join segu.tusuario usu1 on usu1.id_usuario = empr.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = empr.id_usuario_mod
				        inner join param.tlugar lug on lug.id_lugar = empr.id_lugar
                        inner join dir.tactividad esp on esp.id_actividad=empr.id_actividad
						inner join dir.tactividad prim on prim.id_actividad=esp.id_actividad_fk
                        inner join dir.tactividad gral on gral.id_actividad=prim.id_actividad_fk
                        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'DIR_EMPR_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		20-06-2013 13:33:33
	***********************************/

	elsif(p_transaccion='DIR_EMPR_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_empresa)
					    from dir.tempresa empr
					    inner join segu.tusuario usu1 on usu1.id_usuario = empr.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = empr.id_usuario_mod
					    inner join param.tlugar lug on lug.id_lugar = empr.id_lugar
                        inner join dir.tactividad esp on esp.id_actividad=empr.id_actividad
						inner join dir.tactividad prim on prim.id_actividad=esp.id_actividad_fk
                        inner join dir.tactividad gral on gral.id_actividad=prim.id_actividad_fk
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