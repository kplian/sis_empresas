<?php
/**
*@package pXP
*@file ACTPlantillaCorreo.php
*@author  Gonzalo Sarmiento Sejas
*@date 24-06-2013 21:08:35
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTPlantillaCorreo extends ACTbase{    
			
	function listarPlantillaCorreo(){
		$this->objParam->defecto('ordenacion','id_plantilla_correo');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPlantillaCorreo','listarPlantillaCorreo');
		} else{
			$this->objFunc=$this->create('MODPlantillaCorreo');
			
			$this->res=$this->objFunc->listarPlantillaCorreo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPlantillaCorreo(){
		$this->objFunc=$this->create('MODPlantillaCorreo');	
		if($this->objParam->insertar('id_plantilla_correo')){
			$this->res=$this->objFunc->insertarPlantillaCorreo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPlantillaCorreo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPlantillaCorreo(){
			$this->objFunc=$this->create('MODPlantillaCorreo');	
		$this->res=$this->objFunc->eliminarPlantillaCorreo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>