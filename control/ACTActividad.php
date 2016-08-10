<?php
/**
*@package pXP
*@file gen-ACTActividad.php
*@author  (admin)
*@date 20-06-2013 19:53:50
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTActividad extends ACTbase{    
			
	function listarActividad(){
		$this->objParam->defecto('ordenacion','id_actividad');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODActividad','listarActividad');
		} else{
			$this->objFunc=$this->create('MODActividad');
			
			$this->res=$this->objFunc->listarActividad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarActividad(){
		$this->objFunc=$this->create('MODActividad');	
		if($this->objParam->insertar('id_actividad')){
			$this->res=$this->objFunc->insertarActividad($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarActividad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarActividad(){
			$this->objFunc=$this->create('MODActividad');	
		$this->res=$this->objFunc->eliminarActividad($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

 function listarActividadArb() {
      	
		//obtiene el parametro nodo enviado por la vista
		$node=$this->objParam->getParametro('node');
		$id_actividad=$this->objParam->getParametro('id_actividad');
		
		
		if($node=='id'){
			$this->objParam->addParametro('id_padre','%');
		}
		else {
			$this->objParam->addParametro('id_padre',$id_actividad);
		}	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunc=$this->create('MODActividad');		
	
		//$this->objParam->addParametro('id_subsistema',$id_subsistema);
		$this->res=$this->objFunc->listarActividadArb();
		
		$this->res->setTipoRespuestaArbol();
		
		$arreglo=array();
		
		array_push($arreglo,array('nombre'=>'id','valor'=>'id_actividad'));
		array_push($arreglo,array('nombre'=>'id_p','valor'=>'id_actividad_fk'));
		
		array_push($arreglo,array('nombre'=>'text','valor'=>'nombre'));
		array_push($arreglo,array('nombre'=>'cls','valor'=>'descripcion'));
		array_push($arreglo,array('nombre'=>'qtip','valores'=>'<b> #codigo_largo#</b><br> #nombre#'));
		
			
		/*se ande un nivel al arbol incluyendo con tido de nivel carpeta con su arreglo de equivalencias
		  es importante que entre los resultados devueltos por la base exista la variable\
		  tipo_dato que tenga el valor en texto = 'carpeta' */
	
		$this->res->addNivelArbol('tipo_nodo','raiz',array('leaf'=>false,
														'allowDelete'=>true,
														'allowEdit'=>true,
		 												'cls'=>'folder',
		 												'tipo_nodo'=>'raiz',
		 												'icon'=>'../../../lib/imagenes/a_form.png'),
		 												$arreglo);
		 
		
		
		/*se ande un nivel al arbol incluyendo con tido de nivel carpeta con su arreglo de equivalencias
		  es importante que entre los resultados devueltos por la base exista la variable\
		  tipo_dato que tenga el valor en texto = 'hoja' */
		 														

		 $this->res->addNivelArbol('tipo_nodo','hijo',array(
														'leaf'=>false,
														'allowDelete'=>true,
														'allowEdit'=>true,
		 												'tipo_nodo'=>'hijo',
		 												'icon'=>'../../../lib/imagenes/a_form.png'),
		 												$arreglo);
			

		//Se imprime el arbol en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
	
	function listarActividadGral(){
		$this->objParam->defecto('ordenacion','id_actividad');

		$this->objParam->defecto('dir_ordenacion','asc');
		$this->objFunc=$this->create('MODActividad');
		$this->res=$this->objFunc->listarActividadGral($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarActividadPrim(){
		$this->objParam->defecto('ordenacion','id_actividad');

		$this->objParam->defecto('dir_ordenacion','asc');
		$this->objFunc=$this->create('MODActividad');
		$this->res=$this->objFunc->listarActividadPrim($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarActividadEsp(){
		$this->objParam->defecto('ordenacion','id_actividad');

		$this->objParam->defecto('dir_ordenacion','asc');
		$this->objFunc=$this->create('MODActividad');
		$this->res=$this->objFunc->listarActividadEsp($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
}

?>