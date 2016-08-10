CREATE OR REPLACE FUNCTION dir.f_migrar_empresas (
)
RETURNS varchar AS
$body$
DECLARE
v_respuesta 		varchar;
v_empresas		 	record;
v_aux				integer;
v_id_actividad	 	integer;
v_contador			integer;
v_id_lugar			integer;
BEGIN
	v_contador=0;
    
	FOR v_empresas IN(
      SELECT * from
      dblink('dbname=dbweb_adqui_boa',
      'SELECT matricula, nombre, mail, domicilio, actividad,
       actividad_esp, departamento, telefono, nit FROM dir.tempresa')
      as emp(matricula bigint, nombre varchar(500), mail varchar(255),
      domicilio text, actividad text, actividad_esp varchar(255), departamento varchar(100),
      telefono varchar(500), nit varchar(200) ))LOOP
      
      --se recupera el id_actividad            
      select id_actividad into v_id_actividad
      from dir.tactividad 
      where codigo=substr(v_empresas.actividad_esp,1,4);
      
      --se recupera el id_lugar
      select id_lugar into v_id_lugar
      from param.tlugar
      where nombre=v_empresas.departamento;
            
      insert into dir.tempresa(
      nombre, matricula, email, domicilio,
      actividad, id_lugar, id_actividad, telefono, nit, id_usuario_reg, fecha_reg      
      )VALUES(
      v_empresas.nombre, v_empresas.matricula, v_empresas.mail, v_empresas.domicilio,
      v_empresas.actividad, v_id_lugar, v_id_actividad, v_empresas.telefono, v_empresas.nit,
      1,now() 
      )RETURNING id_empresa into v_aux;
      
    END LOOP;
	
    return 'true';
	
EXCEPTION
    WHEN others THEN		
     v_respuesta=SQLERRM;
                 
     RETURN v_respuesta;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;