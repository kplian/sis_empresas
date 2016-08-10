<?php
/**
*@package pXP
*@file gen-MODPublicidad.php
*@author  (admin)
*@date 25-06-2013 21:50:18
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODPublicidad extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarPublicidad(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='dir.ft_publicidad_sel';
		$this->transaccion='DIR_CAMP_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_publicidad','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('tiempo','int4');
		$this->captura('hora_envio','time');
		$this->captura('id_lugar','int4');
		$this->captura('lugar','varchar');
		$this->captura('estado','varchar');
		$this->captura('id_actividad','int4');
		$this->captura('actividad','varchar');
		$this->captura('correos_exitos','int4');
		$this->captura('correos_fallidos','int4');
		$this->captura('cantidad_publicidad','int4');
		$this->captura('id_plantilla_correo','int4');
		$this->captura('plantilla_correo','varchar');
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
			
	function insertarPublicidad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.ft_publicidad_ime';
		$this->transaccion='DIR_CAMP_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tiempo','tiempo','int4');
		$this->setParametro('hora_envio','hora_envio','time');
		$this->setParametro('lugar','lugar','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('id_actividad','id_actividad','int4');
		$this->setParametro('puntero_publicidad','puntero_publicidad','int4');
		$this->setParametro('cantidad_publicidad','cantidad_publicidad','int4');
		$this->setParametro('id_plantilla_correo','id_plantilla_correo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPublicidad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.ft_publicidad_ime';
		$this->transaccion='DIR_CAMP_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_publicidad','id_publicidad','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tiempo','tiempo','int4');
		$this->setParametro('hora_envio','hora_envio','time');
		$this->setParametro('lugar','lugar','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('id_actividad','id_actividad','int4');
		$this->setParametro('puntero_publicidad','puntero_publicidad','int4');
		$this->setParametro('cantidad_publicidad','cantidad_publicidad','int4');
		$this->setParametro('id_plantilla_correo','id_plantilla_correo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPublicidad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.ft_publicidad_ime';
		$this->transaccion='DIR_CAMP_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_publicidad','id_publicidad','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function listarPublicidadElegida(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='dir.ft_publicidad_sel';
		$this->transaccion='DIR_CAMPELE_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->setParametro('id_publicidad','id_publicidad','int4');
		
		$this->captura('tiempo','int4');
		$this->captura('hora_envio','time');
		$this->captura('id_lugar','int4');
		$this->captura('lugar','varchar');
		$this->captura('id_actividad','int4');
		$this->captura('actividad','varchar');
		$this->captura('puntero_publicidad','int4');
		$this->captura('cantidad_publicidad','int4');
		$this->captura('id_plantilla_correo','int4');
		$this->captura('plantilla_correo','varchar');
		$this->captura('body','text');
		$this->captura('remitente_nombre','varchar');
		$this->captura('remitente_email','varchar');
		$this->captura('asunto','varchar');
		$this->captura('fecha_ult_envio','timestamp');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function listarCorreosPublicidad(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='dir.ft_publicidad_sel';
		$this->transaccion='DIR_CORCAMP_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->setCount(false);
				
		//Definicion de la lista del resultado del query
		$this->setParametro('id_publicidad','id_publicidad','int4');
		
		$this->captura('email','varchar');
		$this->captura('nombre','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function avanzarPuntero(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.ft_publicidad_ime';
		$this->transaccion='DIR_AVACAMP_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_publicidad','id_publicidad','int4');
		$this->setParametro('correos_exitos','correos_exitos','int4');
		$this->setParametro('correos_fallidos','correos_fallidos','int4');
		$this->setParametro('puntero_mail','puntero_mail','int4');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>