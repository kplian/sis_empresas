CREATE OR REPLACE FUNCTION dir.f_migrar_actividades (
)
RETURNS varchar AS
$body$
DECLARE
v_respuesta 		varchar;
v_actividades_gral 	record;
v_actividades_prim	record;
v_actividades_esp	record;
v_id_actividad_gral	integer;
v_aux				varchar;
v_codigo			varchar;
v_nombre			varchar;
v_codigo_largo		varchar;
v_codigo_padre		varchar;
v_id_actividad_fk 	integer;
BEGIN
    
	FOR v_actividades_gral IN(
      SELECT * from
      dblink('dbname=dbweb_adqui_boa',
      'SELECT distinct actividad_gral FROM dir.tempresa where actividad_gral!=''Información no registrada''')
      as emp(nombre varchar(255)))LOOP
      
      --se inserta actividades_generales
      
      insert into dir.tactividad(nombre,id_usuario_reg,fecha_reg)
      values(v_actividades_gral.nombre,1,now())
      RETURNING id_actividad into v_id_actividad_gral; 
      
      FOR v_actividades_prim IN(
      	SELECT * from
		dblink('dbname=dbweb_adqui_boa',
        'SELECT distinct actividad_prim FROM dir.tempresa where actividad_gral='''||v_actividades_gral.nombre||'''')
        as emp(nombre varchar(255)))LOOP
        
        --se inserta actividades prim, si aun no se insertaron
      	
        v_aux = replace(v_actividades_prim.nombre,'-','');
        v_codigo = substring(v_aux,1,2);
        v_nombre = substr(v_aux,3);
        
        IF NOT EXISTS(select 1 from dir.tactividad where codigo=v_codigo)THEN
			INSERT INTO dir.tactividad(
            nombre, codigo, id_usuario_reg, fecha_reg, id_actividad_fk, codigo_largo
            )VALUES(v_nombre, v_codigo, 1, now(), v_id_actividad_gral, v_codigo
            );
        END IF;
        
        FOR v_actividades_esp IN(
          SELECT * from
          dblink('dbname=dbweb_adqui_boa',
          'SELECT distinct actividad_esp FROM dir.tempresa where actividad_prim='''||v_actividades_prim.nombre||'''')
          as emp(nombre varchar(255)))LOOP
                    
          --se insertan actividades especificas si aun no se insertaron
          
          v_aux = replace(v_actividades_esp.nombre,'-','');
          v_codigo_padre = substr(v_aux,1,2);
          v_codigo = substring(v_aux,1,4);
          v_nombre = substr(v_aux,5);
          
          IF NOT EXISTS(select 1 from dir.tactividad where codigo=v_codigo)THEN
          
          	select id_actividad into v_id_actividad_fk 
            from dir.tactividad 
            where codigo=v_codigo_padre;

          	WITH RECURSIVE t(id,id_fk,cod,n) AS (
               SELECT a.id_actividad,a.id_actividad_fk, a.codigo,1 
               FROM dir.tactividad a 
               WHERE a.id_actividad = v_id_actividad_fk
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
                 
            v_codigo_largo = v_codigo_largo||v_codigo;
          	          	
			INSERT INTO dir.tactividad(
            nombre, codigo, id_usuario_reg, fecha_reg, id_actividad_fk, codigo_largo
            )VALUES(v_nombre, v_codigo, 1, now(), v_id_actividad_fk, v_codigo_largo
            );
	      END IF;
          
        END LOOP;        
        
      END LOOP;
      
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