<?php
/**
*@package pXP
*@file ACTArchivoAdjunto.php
*@author  Gonzalo Sarmiento
*@date 25-06-2013 01:10:51
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTArchivoAdjunto extends ACTbase{    
			
	function listarArchivoAdjunto(){
		$this->objParam->defecto('ordenacion','id_archivo_adjunto');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODArchivoAdjunto','listarArchivoAdjunto');
		} else{
			$this->objFunc=$this->create('MODArchivoAdjunto');
			
			$this->res=$this->objFunc->listarArchivoAdjunto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarArchivoAdjunto(){
		$this->objFunc=$this->create('MODArchivoAdjunto');	
		if($this->objParam->insertar('id_archivo_adjunto')){
			$this->res=$this->objFunc->insertarArchivoAdjunto($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarArchivoAdjunto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarArchivoAdjunto(){
			$this->objFunc=$this->create('MODArchivoAdjunto');	
		$this->res=$this->objFunc->eliminarArchivoAdjunto($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function subirArchivo() {
		 
   $this->objFunc = $this->create('MODArchivoAdjunto');
   $this->res = $this->objFunc->subirArchivoAdjunto();
   $this->res->imprimirRespuesta($this->res->generarJson());
 }
			
}

?>