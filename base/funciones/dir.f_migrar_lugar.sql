CREATE OR REPLACE FUNCTION dir.f_migrar_lugar (
)
RETURNS varchar AS
$body$
DECLARE
v_respuesta 		varchar;
v_empresas		 	record;
v_departamento		text[];
v_codigo			varchar;
v_id_lugar			integer;
BEGIN
    
      insert into param.tlugar(
      nombre, codigo, tipo, sw_municipio,
      sw_impuesto, id_lugar_fk, codigo_largo,
      id_usuario_reg, fecha_reg
      )VALUES(
      'Bolivia', 'BOL', 'pais', 'no',
      'no', NULL, 'BOL',
      1, now()
      )RETURNING id_lugar into v_id_lugar;
      
        
	FOR v_empresas IN(
      SELECT * from
      dblink('dbname=dbweb_adqui_boa',
      'SELECT DISTINCT departamento FROM dir.tempresa where departamento!=''Por Verificar''')
      as emp(departamento varchar(100)))LOOP
            
      v_departamento = regexp_split_to_array(v_empresas.departamento,E'\\s+');
      
      if(array_length(v_departamento,1)=1)then      
	    v_codigo =  upper(substr(v_empresas.departamento,1,2));       
      else     	
    	v_codigo =  upper(substr(v_departamento[1],1,1) || substr(v_departamento[2],1,1)); 
      end if;
      
      insert into param.tlugar(
      nombre, codigo, tipo, sw_municipio,
      sw_impuesto, id_lugar_fk, codigo_largo,
      id_usuario_reg, fecha_reg      
      )VALUES(
      v_empresas.departamento, v_codigo, 'departamento', 'no',
      'no', v_id_lugar, 'BOL.'||v_codigo, 
      1,now() 
      );
      
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