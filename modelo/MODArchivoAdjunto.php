<?php
/**
*@package pXP
*@file MODArchivoAdjunto.php
*@author  Gonzalo Sarmiento
*@date 25-06-2013 01:10:51
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODArchivoAdjunto extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarArchivoAdjunto(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='dir.ft_archivo_adjunto_sel';
		$this->transaccion='DIR_ARCADJ_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->setParametro('id_plantilla_correo','id_plantilla_correo','int4');
		$this->captura('id_archivo_adjunto','int4');
		$this->captura('id_plantilla_correo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('archivo', 'bytea', 'nombre_archivo', 'extension_archivo', 'archivo', '../../../sis_empresas/archivos/');
		$this->captura('extension_archivo','varchar');
		$this->captura('nombre_archivo','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarArchivoAdjunto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.ft_archivo_adjunto_ime';
		$this->transaccion='DIR_ARCADJ_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_plantilla_correo','id_plantilla_correo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('archivo','archivo','bytea');
		$this->setParametro('extension_archivo','extension_archivo','varchar');
		$this->setParametro('nombre_archivo','nombre_archivo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarArchivoAdjunto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.ft_archivo_adjunto_ime';
		$this->transaccion='DIR_ARCADJ_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_archivo_adjunto','id_archivo_adjunto','int4');
		$this->setParametro('id_plantilla_correo','id_plantilla_correo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('archivo','archivo','bytea');
		$this->setParametro('extension_archivo','extension_archivo','varchar');
		$this->setParametro('nombre_archivo','nombre_archivo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarArchivoAdjunto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.ft_archivo_adjunto_ime';
		$this->transaccion='DIR_ARCADJ_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_archivo_adjunto','id_archivo_adjunto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function subirArchivoAdjunto() {
		  //Definicion de variables para ejecucion del procedimiento
			 $this->procedimiento = 'dir.ft_archivo_adjunto_ime';
			 $this->transaccion = 'DIR_UPARCH_INS';
			 $this->tipo_procedimiento = 'IME';
			
			 $ext = pathinfo($this->arregloFiles['archivo']['name']);
			 $this->arreglo['extension'] = $ext['extension'];
				$this->arreglo['filename'] = $ext['filename'];
						 
			 $this->setParametro('filename', 'filename', 'varchar');
			 $this->setParametro('extension', 'extension', 'varchar');
			 $this->setParametro('id_plantilla_correo','id_plantilla_correo','int4');
			 $this->setParametro('archivo', 'archivo', 'bytea', false, '', false, array('doc', 'pdf', 'docx', 'jpg', 'png', 'bmp', 'xls', 'xlsx'));
			
			 //Ejecuta la instruccion
			 $this->armarConsulta();			
			 $this->ejecutarConsulta();
				
				//Devuelve la respuesta
			 return $this->respuesta;
 }
	
	function listarArchivoAdjuntoCampania(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='dir.ft_archivo_adjunto_sel';
		$this->transaccion='DIR_CAMPAR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->setCount(false);
				
		//Definicion de la lista del resultado del query
		$this->setParametro('id_publicidad','id_publicidad','int4');
		$this->captura('archivo', 'bytea', 'nombre_archivo', 'extension_archivo', 'archivo', '../../../sis_empresas/archivos/');
		$this->captura('extension_archivo','varchar');
		$this->captura('nombre_archivo','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>