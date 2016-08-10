<?php
/**
*@package pXP
*@file gen-ACTPublicidad.php  
*@author  (admin)
*@date 25-06-2013 21:50:18
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/
require dirname(__FILE__).'/../../lib/PHPMailer/PHPMailerAutoload.php';
require_once("email_verify_source.php");

class ACTPublicidad extends ACTbase{
	
	private $correosExitos;
	private $correosFallidos;
	    			
	function listarPublicidad(){
		$this->objParam->defecto('ordenacion','id_publicidad');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPublicidad','listarPublicidad');
		} else{
			$this->objFunc=$this->create('MODPublicidad');
			
			$this->res=$this->objFunc->listarPublicidad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPublicidad(){
		$this->objFunc=$this->create('MODPublicidad');	
		if($this->objParam->insertar('id_publicidad')){
			$this->res=$this->objFunc->insertarPublicidad($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPublicidad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPublicidad(){
			$this->objFunc=$this->create('MODPublicidad');	
		$this->res=$this->objFunc->eliminarPublicidad($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function iniciarCampania(){
		$this->correosExitos=0;
		$this->correosFallidos=0;
		
		$mail = new PHPMailer();
		$mail->IsSMTP();
		$mail->Host       = $_SESSION['_MAIL_SERVIDOR'];
		$mail->Port       = $_SESSION['_MAIL_PUERTO'];
		$mail->SMTPAuth   = $_SESSION['_MAIL_AUTENTIFICACION'];
		$mail->SMTPSecure = $_SESSION['_SMTPSecure'];
		$mail->Username   = $_SESSION['_MAIL_USUARIO'];
		$mail->Password   = $_SESSION['_MAIL_PASSWORD']; 
		
		$this->objParam->addParametroConsulta('ordenacion','id_publicidad');
        $this->objParam->addParametroConsulta('dir_ordenacion','ASC');
        $this->objParam->addParametroConsulta('cantidad',1);
        $this->objParam->addParametroConsulta('puntero',0);
		
		//recupero los datos de la campaña y de la plantilla
		$this->objFunc=$this->create('MODPublicidad');	
		$this->res=$this->objFunc->listarPublicidadElegida($this->objParam);		
		$publicidad=$this->res->getDatos();
		
		
		
		
		
		//añado remitente
		$mail->SetFrom($publicidad[0]['remitente_email'], $publicidad[0]['remitente_nombre']);
		//añado asunto
		$mail->Subject = $publicidad[0]['asunto'];
		
		//verifico si paso el intervalo de periodo entre envio de correos
		$tiempo = $publicidad[0]['tiempo'];
		$start = strtotime($publicidad[0]['fecha_ult_envio']);		
		$date=new DateTime();
		$end = strtotime($date->format('Y-m-d H:i:s.u'));		
		$interval = ($end - $start)/3600;		
		
		if($interval>$tiempo){
		             $fpp = fopen('log_correo.txt',"a+");
                     $dt = new DateTime();
                     $time = $dt->format('Y-m-d H:i:s');
                     fwrite($fpp, "\n Inicio: ".$time);
                     fclose($fpp);
		            
		        
		    
					//parametrizo cuantos registros voy a recuperar y desde donde		
					$this->objParam->addParametroConsulta('ordenacion','nombre');
					$this->objParam->addParametroConsulta('cantidad',$publicidad[0]['cantidad_publicidad']);		
					$this->objParam->addParametroConsulta('puntero',$publicidad[0]['puntero_publicidad']);
					//recupero los correos de destino
					$this->objFunc=$this->create('MODPublicidad');		
					$this->res=$this->objFunc->listarCorreosPublicidad($this->objParam);
					$listaCorreos = $this->res;
					
					if(count($this->res->getDatos()!=0)){												
								$this->objParam->addParametroConsulta('ordenacion','id_publicidad');
							    $this->objParam->addParametroConsulta('cantidad',1000);
				 			    $this->objParam->addParametroConsulta('puntero',0);
								//recupero los archivos adjuntos
								$this->objFunc=$this->create('MODArchivoAdjunto');
								$this->res=$this->objFunc->listarArchivoAdjuntoCampania($this->objParam);
								
								foreach ($this->res->getDatos() as $adjuntos) {
										//añado los archivos adjuntos
										$mail->AddAttachment(dirname(__FILE__).'/../archivos/'.$adjuntos['archivo']);
								}
								$puntero = 0;
								$fpp = fopen('log_correo.txt',"a+");
                                 $dt = new DateTime();
                                 $time = $dt->format('Y-m-d H:i:s');
                                 fwrite($fpp, "\n consulta: ".$time);
                                 fclose($fpp);
								foreach ($listaCorreos->getDatos() as $destino) {
								       
									    $log='';
										//verifico si el email existe o no
										/*
										$error = validateEmail($destino['email'], true, true, 'admin@kplian.com', 'kplian.com', true);
    								    if ($error) {
    								    				$this->correosFallidos++;
    								        $log.="Esta direccion de correo no existe\n";
    													   //continue;
    								    } else {								    	
    										 $this->correosExitos++;
    								         $log.= "Esta direccion de correo existe\n";																
    								    }
    								    */
										//añado email de destino
										$firma = ' </br></br><img src="http://www.kplian.com/firma.php?email='.urlencode($destino['email']).'" />';
        
										$html = $publicidad[0]['body'].$firma;
                                        //añado el cuerpo del email
                                        $mail->MsgHTML($html);																	
									    $mail->AddAddress($destino['email'], $destino['nombre']);	
										
										if(!$mail->Send()) {						
											$log.= "Mailer Error: " . $mail->ErrorInfo."\n";
										}
										else {
											 
										}
									     $mail->ClearAddresses();
									      $log.= "Correos enviados! ".$destino['email'];
									     
									     $fpp = fopen('log_correo.txt',"a+");
									     $dt = new DateTime();
                                         $time = $dt->format('Y-m-d H:i:s');
                                        
                                         fwrite($fpp, "\n Nombre: $log"." ".$time);
                                         fclose($fpp);
										 $this->correosExitos=0;
										 $this->correosFallidos=0;	
										 $mail->SmtpClose();
										 $puntero=$puntero+1;;		
								}	
								
								
								//hago que avance el puntero                                     
                                $this->objParam->addParametro('correos_exitos',$this->correosExitos);
                                $this->objParam->addParametro('correos_fallidos',$this->correosFallidos);
                                $this->objParam->addParametro('puntero_mail',$puntero);
                                $this->objFunc=$this->create('MODPublicidad');                                          
                                $this->res=$this->objFunc->avanzarPuntero($this->objParam);
                               
					 }
					$this->res->imprimirRespuesta($this->res->generarJson());
			}
			else{
			    $mensaje = new Mensaje();
                $mensaje->setMensaje('ADVERTENCIA','ACTPublicidad.php','No transcurrio el periodo de envio de correos electronicos',
                                      'No paso el intervalo necesario para volver a enviar correos','control');
                $this->res = $mensaje;
                $this->res->imprimirRespuesta($this->res->generarJson());
			}
	}		
}

?>