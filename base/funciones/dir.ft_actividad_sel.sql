CREATE OR REPLACE FUNCTION dir.ft_actividad_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Empresas
 FUNCION: 		dir.ft_actividad_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'dir.tactividad'
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;	
    v_where 			varchar;
    v_join 				varchar;
			    
BEGIN

	v_nombre_funcion = 'dir.ft_actividad_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DIR_ACT_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		20-06-2013 19:53:50
	***********************************/

	if(p_transaccion='DIR_ACT_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						act.id_actividad,
						act.estado_reg,
						act.codigo,
						act.codigo_largo,
						act.id_actividad_fk,
						act.nombre,
						act.fecha_reg,
						act.id_usuario_reg,
						act.fecha_mod,
						act.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from dir.tactividad act
						inner join segu.tusuario usu1 on usu1.id_usuario = act.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = act.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	 /*********************************    
 	#TRANSACCION:  'DIR_ACT_ARB_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Gonzalo Sarmiento
 	#FECHA:		19-06-2013 09:19:28
	***********************************/

	elseif(p_transaccion='DIR_ACT_ARB_SEL')then
     				
    	begin
        
              if(v_parametros.id_padre = '%') then
                v_where := ' act.id_actividad_fk is NULL';
                 v_join:= 'LEFT';      
                      
              else
                v_where := ' act.id_actividad_fk = '||v_parametros.id_padre;
                v_join := 'INNER';
              end if;
        
        
    		--Sentencia de la consulta
			v_consulta:='select
						act.id_actividad,
						act.codigo,
						act.estado_reg,
						act.id_actividad_fk,
						act.nombre,
						act.fecha_reg,
						act.id_usuario_reg,
						act.fecha_mod,
						act.id_usuario_mod,
						usu1.cuenta as usr_reg,
                        case
                          when (act.id_actividad_fk is null )then
                               ''raiz''::varchar
                          ELSE
                              ''hijo''::varchar
                          END as tipo_nodo,
                         codigo_largo
						from dir.tactividad act
						inner join segu.tusuario usu1 
                        on usu1.id_usuario = act.id_usuario_reg
					    where  '||v_where|| '  
                        ORDER BY act.id_actividad';
			
			
			--Devuelve la respuesta
			return v_consulta;
						
		end;
        
    /*********************************    
 	#TRANSACCION:  'DIR_ACTGRAL_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Gonzalo Sarmiento
 	#FECHA:		19-06-2013 09:19:28
	***********************************/
        
    elsif(p_transaccion='DIR_ACTGRAL_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						act.id_actividad,
						act.estado_reg,
						act.codigo,
						act.codigo_largo,
						act.id_actividad_fk,
						act.nombre,
						act.fecha_reg,
						act.id_usuario_reg,
						act.fecha_mod,
						act.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from dir.tactividad act
						inner join segu.tusuario usu1 on usu1.id_usuario = act.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = act.id_usuario_mod
				        where act.id_actividad_fk is null and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;   

	/*********************************    
 	#TRANSACCION:  'DIR_ACTPRIM_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Gonzalo Sarmiento
 	#FECHA:		19-06-2013 09:19:28
	***********************************/
        
    elsif(p_transaccion='DIR_ACTPRIM_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						act.id_actividad,
						act.estado_reg,
						act.codigo,
						act.codigo_largo,
						act.id_actividad_fk,
						act.nombre,
						act.fecha_reg,
						act.id_usuario_reg,
						act.fecha_mod,
						act.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from dir.tactividad act
						inner join segu.tusuario usu1 on usu1.id_usuario = act.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = act.id_usuario_mod
				        where act.id_actividad_fk='||v_parametros.id_actividad_gral||' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
        
    /*********************************    
 	#TRANSACCION:  'DIR_ACTESP_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Gonzalo Sarmiento
 	#FECHA:		19-06-2013 09:19:28
	***********************************/
        
    elsif(p_transaccion='DIR_ACTESP_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						act.id_actividad,
						act.estado_reg,
						act.codigo,
						act.codigo_largo,
						act.id_actividad_fk,
						act.nombre,
						act.fecha_reg,
						act.id_usuario_reg,
						act.fecha_mod,
						act.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from dir.tactividad act
						inner join segu.tusuario usu1 on usu1.id_usuario = act.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = act.id_usuario_mod
				        where act.id_actividad_fk='||v_parametros.id_actividad_prim||' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;   

	/*********************************    
 	#TRANSACCION:  'DIR_ACT_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		20-06-2013 19:53:50
	***********************************/

	elsif(p_transaccion='DIR_ACT_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_actividad)
					    from dir.tactividad act
					    inner join segu.tusuario usu1 on usu1.id_usuario = act.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = act.id_usuario_mod
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
    
    /*********************************    
 	#TRANSACCION:  'DIR_ACTGRAL_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		20-06-2013 19:53:50
	***********************************/

	elsif(p_transaccion='DIR_ACTGRAL_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_actividad)
					    from dir.tactividad act
					    inner join segu.tusuario usu1 on usu1.id_usuario = act.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = act.id_usuario_mod
					    where act.id_actividad_fk is null and ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
	
    /*********************************    
 	#TRANSACCION:  'DIR_ACTPRIM_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		20-06-2013 19:53:50
	***********************************/

	elsif(p_transaccion='DIR_ACTPRIM_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_actividad)
					    from dir.tactividad act
					    inner join segu.tusuario usu1 on usu1.id_usuario = act.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = act.id_usuario_mod
					    where act.id_actividad_fk='||v_parametros.id_actividad_gral||' and ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
        
	/*********************************    
 	#TRANSACCION:  'DIR_ACTESP_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		20-06-2013 19:53:50
	***********************************/

	elsif(p_transaccion='DIR_ACTESP_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_actividad)
					    from dir.tactividad act
					    inner join segu.tusuario usu1 on usu1.id_usuario = act.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = act.id_usuario_mod
					    where act.id_actividad_fk='||v_parametros.id_actividad_prim||' and ';
			
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