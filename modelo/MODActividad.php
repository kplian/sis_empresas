<?php
/**
*@package pXP
*@file gen-MODActividad.php
*@author  (admin)
*@date 20-06-2013 19:53:50
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODActividad extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarActividad(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='dir.ft_actividad_sel';
		$this->transaccion='DIR_ACT_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_actividad','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('codigo','varchar');
		$this->captura('codigo_largo','varchar');
		$this->captura('id_actividad_fk','int4');
		$this->captura('nombre','varchar');
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
			
	function insertarActividad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.ft_actividad_ime';
		$this->transaccion='DIR_ACT_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('codigo_largo','codigo_largo','varchar');
		$this->setParametro('id_actividad_fk','id_actividad_fk','int4');
		$this->setParametro('nombre','nombre','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarActividad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.ft_actividad_ime';
		$this->transaccion='DIR_ACT_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_actividad','id_actividad','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('codigo_largo','codigo_largo','varchar');
		$this->setParametro('id_actividad_fk','id_actividad_fk','int4');
		$this->setParametro('nombre','nombre','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarActividad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.ft_actividad_ime';
		$this->transaccion='DIR_ACT_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_actividad','id_actividad','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function listarActividadArb(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='dir.ft_actividad_sel';
		$this-> setCount(false);
		$this->transaccion='DIR_ACT_ARB_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('id_padre','id_padre','varchar');		
		//$this->setParametro('id_subsistema','id_subsistema','integer');
				
		//Definicion de la lista del resultado del query
		$this->captura('id_actividad','int4');
		$this->captura('codigo','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_actividad_fk','int4');
		$this->captura('nombre','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('tipo_nodo','varchar');
		$this->captura('codigo_largo','varchar');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}

	function listarActividadGral(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='dir.ft_actividad_sel';
		$this->transaccion='DIR_ACTGRAL_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_actividad','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('codigo','varchar');
		$this->captura('codigo_largo','varchar');
		$this->captura('id_actividad_fk','int4');
		$this->captura('nombre','varchar');
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
	
	function listarActividadPrim(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='dir.ft_actividad_sel';
		$this->transaccion='DIR_ACTPRIM_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
				
		$this->setParametro('id_actividad_gral','id_actividad_gral','int4');
		//Definicion de la lista del resultado del query
		$this->captura('id_actividad','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('codigo','varchar');
		$this->captura('codigo_largo','varchar');		
		$this->captura('id_actividad_fk','int4');
		$this->captura('nombre','varchar');
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
	
	function listarActividadEsp(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='dir.ft_actividad_sel';
		$this->transaccion='DIR_ACTESP_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
				
		$this->setParametro('id_actividad_prim','id_actividad_prim','int4');
		//Definicion de la lista del resultado del query
		$this->captura('id_actividad','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('codigo','varchar');
		$this->captura('codigo_largo','varchar');		
		$this->captura('id_actividad_fk','int4');
		$this->captura('nombre','varchar');
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
			
}
?>