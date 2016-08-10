<?php
/**
*@package pXP
*@file MODPlantillaCorreo.php
*@author  Gonzalo Sarmiento
*@date 24-06-2013 21:08:35
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODPlantillaCorreo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarPlantillaCorreo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='dir.ft_plantilla_correo_sel';
		$this->transaccion='DIR_PLCR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_plantilla_correo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('body','text');
		$this->captura('codigo','varchar');
		$this->captura('remitente_nombre','varchar');
		$this->captura('remitente_email','varchar');
		$this->captura('asunto','varchar');
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
			
	function insertarPlantillaCorreo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.ft_plantilla_correo_ime';
		$this->transaccion='DIR_PLCR_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('body','body','codigo_html');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('remitente_nombre','remitente_nombre','varchar');
		$this->setParametro('remitente_email','remitente_email','varchar');
		$this->setParametro('asunto','asunto','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPlantillaCorreo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.ft_plantilla_correo_ime';
		$this->transaccion='DIR_PLCR_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_plantilla_correo','id_plantilla_correo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('body','body','codigo_html');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('remitente_nombre','remitente_nombre','varchar');
		$this->setParametro('remitente_email','remitente_email','varchar');
		$this->setParametro('asunto','asunto','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPlantillaCorreo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.ft_plantilla_correo_ime';
		$this->transaccion='DIR_PLCR_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_plantilla_correo','id_plantilla_correo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>