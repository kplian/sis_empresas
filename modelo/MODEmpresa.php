<?php
/**
*@package pXP
*@file gen-MODEmpresa.php
*@author  (admin)
*@date 20-06-2013 13:33:33
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODEmpresa extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarEmpresa(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='dir.ft_empresa_sel';
		$this->transaccion='DIR_EMPR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_empresa','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre','varchar');
		$this->captura('domicilio','text');
		$this->captura('lugar','varchar');
		$this->captura('actividad','text');
		$this->captura('actividad_gral','varchar');
		$this->captura('actividad_prim','varchar');
		$this->captura('actividad_esp','varchar');
		$this->captura('nit','varchar');
		$this->captura('email','varchar');
		$this->captura('matricula','int8');
		$this->captura('telefono','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarEmpresa(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.ft_empresa_ime';
		$this->transaccion='DIR_EMPR_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('domicilio','domicilio','text');
		$this->setParametro('lugar','lugar','varchar');
		$this->setParametro('actividad','actividad','text');
		$this->setParametro('id_actividad_esp','id_actividad_esp','int4');
		$this->setParametro('nit','nit','varchar');
		$this->setParametro('email','email','varchar');
		$this->setParametro('matricula','matricula','int8');
		$this->setParametro('telefono','telefono','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarEmpresa(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.ft_empresa_ime';
		$this->transaccion='DIR_EMPR_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_empresa','id_empresa','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('domicilio','domicilio','text');
		$this->setParametro('lugar','lugar','varchar');
		$this->setParametro('actividad','actividad','text');
		$this->setParametro('id_actividad_esp','id_actividad_esp','int4');
		$this->setParametro('nit','nit','varchar');
		$this->setParametro('email','email','varchar');
		$this->setParametro('matricula','matricula','int8');
		$this->setParametro('telefono','telefono','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarEmpresa(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.ft_empresa_ime';
		$this->transaccion='DIR_EMPR_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_empresa','id_empresa','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>