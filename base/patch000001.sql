/***********************************I-SCP-GSS-DIR-0-19/06/2013****************************************/
/*
*	Author: GSS
*	Date: 06/2013
*	Description: Build the menu definition and composition
*/

CREATE TABLE dir.tempresa (
  id_empresa SERIAL NOT NULL, 
  matricula BIGINT, 
  nombre VARCHAR(500), 
  email VARCHAR(500), 
  domicilio TEXT, 
  actividad TEXT, 
  id_lugar INTEGER, 
  id_actividad INTEGER, 
  telefono VARCHAR(500), 
  nit VARCHAR(200), 
  CONSTRAINT pk_tempresa__id_empresa PRIMARY KEY(id_empresa)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

CREATE TABLE dir.tpublicidad (
  id_publicidad SERIAL NOT NULL, 
  cantidad_publicidad INTEGER, 
  tiempo INTEGER, 
  puntero_publicidad INTEGER DEFAULT 0, 
  hora_envio TIME WITHOUT TIME ZONE, 
  estado VARCHAR DEFAULT 'registrado'::character varying, 
  id_lugar INTEGER, 
  id_actividad INTEGER, 
  id_plantilla_correo INTEGER NOT NULL, 
  correos_exitos INTEGER DEFAULT 0, 
  correos_fallidos INTEGER DEFAULT 0,
  fecha_ult_envio TIMESTAMP WITHOUT TIME ZONE DEFAULT '1970-01-01 00:00:00'::timestamp without time zone, 
  CONSTRAINT pk_tpublicidad__id_publicidad PRIMARY KEY(id_publicidad)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

CREATE TABLE dir.tactividad (
  id_actividad SERIAL NOT NULL, 
  id_actividad_fk INTEGER, 
  codigo VARCHAR(25), 
  nombre VARCHAR(500), 
  codigo_largo VARCHAR(255), 
  CONSTRAINT pk_tactividad__id_actividad PRIMARY KEY(id_actividad)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

/***********************************F-SCP-GSS-DIR-0-19/06/2013****************************************/

/***********************************I-SCP-GSS-DIR-5-25/06/2013****************************************/

CREATE TABLE dir.tplantilla_correo (
  id_plantilla_correo SERIAL NOT NULL, 
  codigo VARCHAR(20) NOT NULL, 
  body TEXT, 
  CONSTRAINT pk_tplantilla_correo__id_plantilla_correo PRIMARY KEY(id_plantilla_correo)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

CREATE TABLE dir.tarchivo_adjunto (
  id_archivo_adjunto SERIAL NOT NULL, 
  id_plantilla_correo INTEGER, 
  archivo BYTEA, 
  nombre_archivo VARCHAR(50), 
  extension_archivo VARCHAR(10), 
  CONSTRAINT pk_tarchivo_adjunto__id_archivo_adjunto PRIMARY KEY(id_archivo_adjunto)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

/***********************************F-SCP-GSS-DIR-5-25/06/2013****************************************/

/***********************************I-SCP-GSS-DIR-6-28/06/2013****************************************/

ALTER TABLE dir.tplantilla_correo
  ADD COLUMN remitente_nombre VARCHAR(100);
  
ALTER TABLE dir.tplantilla_correo
  ADD COLUMN remitente_email VARCHAR(100);
  
ALTER TABLE dir.tplantilla_correo
  ADD COLUMN asunto VARCHAR(250);
  
/***********************************F-SCP-GSS-DIR-6-28/06/2013****************************************/