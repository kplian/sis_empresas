/***********************************I-DAT-GSS-DIR-0-19/06/2013*****************************************/

/*
*	Author: GSS
*	Date: 09/06/2013
*	Description: Build the menu definition and the composition
*/


/*

Para  definir la la metadata, menus, roles, etc

1) sincronize ls funciones y procedimientos del sistema
2)  verifique que la primera linea de los datos sea la insercion del sistema correspondiente
3)  exporte los datos a archivo SQL (desde la interface de sistema en sis_seguridad), 
    verifique que la codificacion  se mantenga en UTF8 para no distorcionar los caracteres especiales
4)  remplaze los sectores correspondientes en este archivo en su totalidad:  (el orden es importante)  
                             menu, 
                             funciones, 
                             procedimietnos

*/


INSERT INTO segu.tsubsistema ( codigo, nombre, fecha_reg, prefijo, estado_reg, nombre_carpeta, id_subsis_orig)
VALUES ('DIR', 'Sistema de Empresas', '2013-06-19', 'DIR', 'activo', 'empresas', NULL);

select pxp.f_insert_tgui ('Directorio', '', 'DIR', 'si', NULL, '', 1, '', '', 'DIR');


select pxp.f_insert_testructura_gui ('DIR', 'SISTEMA');

/***********************************F-DAT-GSS-DIR-0-19/06/2013*****************************************/


/***********************************I-DAT-GSS-DIR-0-20/06/2013*****************************************/

select pxp.f_insert_tgui ('Parametros', 'parametrso', 'EMPPAR', 'si', 1, '', 2, '', '', 'DIR');
select pxp.f_insert_tgui ('Rubro', 'actividad', 'EMPACT', 'si', 1, 'sis_empresas/vista/actividad/Actividad.php', 3, '', 'Actividad', 'DIR');
select pxp.f_delete_tgui ('EMPPR');
select pxp.f_insert_tgui ('Procesos', 'procesos', 'EMPPR', 'si', 2, '', 2, '', '', 'DIR');
select pxp.f_insert_tgui ('Empresa', 'empresas', 'EMPR', 'si', 1, 'sis_empresas/vista/empresa/Empresa.php', 3, '', 'Empresa', 'DIR');

select pxp.f_insert_testructura_gui ('EMPPAR', 'DIR');
select pxp.f_insert_testructura_gui ('EMPACT', 'EMPPAR');
select pxp.f_delete_testructura_gui ('EMPPR', 'EMPPAR');
select pxp.f_insert_testructura_gui ('EMPPR', 'DIR');
select pxp.f_insert_testructura_gui ('EMPR', 'EMPPR');



select pxp.f_insert_tfuncion ('dir.ft_actividad_sel', 'Funcion para tabla     ', 'DIR');
select pxp.f_insert_tfuncion ('dir.ft_empresa_sel', 'Funcion para tabla     ', 'DIR');
select pxp.f_insert_tfuncion ('dir.ft_actividad_ime', 'Funcion para tabla     ', 'DIR');
select pxp.f_insert_tfuncion ('dir.ft_empresa_ime', 'Funcion para tabla     ', 'DIR');


select pxp.f_insert_tprocedimiento ('DIR_ACT_SEL', 'Consulta de datos', 'si', '', '', 'dir.ft_actividad_sel');
select pxp.f_insert_tprocedimiento ('DIR_ACT_ARB_SEL', 'Consulta de datos', 'si', '', '', 'dir.ft_actividad_sel');
select pxp.f_insert_tprocedimiento ('DIR_ACTGRAL_SEL', 'Consulta de datos', 'si', '', '', 'dir.ft_actividad_sel');
select pxp.f_insert_tprocedimiento ('DIR_ACTPRIM_SEL', 'Consulta de datos', 'si', '', '', 'dir.ft_actividad_sel');
select pxp.f_insert_tprocedimiento ('DIR_ACTESP_SEL', 'Consulta de datos', 'si', '', '', 'dir.ft_actividad_sel');
select pxp.f_insert_tprocedimiento ('DIR_ACT_CONT', 'Conteo de registros', 'si', '', '', 'dir.ft_actividad_sel');
select pxp.f_insert_tprocedimiento ('DIR_ACTGRAL_CONT', 'Conteo de registros', 'si', '', '', 'dir.ft_actividad_sel');
select pxp.f_insert_tprocedimiento ('DIR_ACTPRIM_CONT', 'Conteo de registros', 'si', '', '', 'dir.ft_actividad_sel');
select pxp.f_insert_tprocedimiento ('DIR_ACTESP_CONT', 'Conteo de registros', 'si', '', '', 'dir.ft_actividad_sel');
select pxp.f_insert_tprocedimiento ('DIR_EMPR_SEL', 'Consulta de datos', 'si', '', '', 'dir.ft_empresa_sel');
select pxp.f_insert_tprocedimiento ('DIR_EMPR_CONT', 'Conteo de registros', 'si', '', '', 'dir.ft_empresa_sel');
select pxp.f_insert_tprocedimiento ('DIR_ACT_INS', 'Insercion de registros', 'si', '', '', 'dir.ft_actividad_ime');
select pxp.f_insert_tprocedimiento ('DIR_ACT_MOD', 'Modificacion de registros', 'si', '', '', 'dir.ft_actividad_ime');
select pxp.f_insert_tprocedimiento ('DIR_ACT_ELI', 'Eliminacion de registros', 'si', '', '', 'dir.ft_actividad_ime');
select pxp.f_insert_tprocedimiento ('DIR_EMPR_INS', 'Insercion de registros', 'si', '', '', 'dir.ft_empresa_ime');
select pxp.f_insert_tprocedimiento ('DIR_EMPR_MOD', 'Modificacion de registros', 'si', '', '', 'dir.ft_empresa_ime');
select pxp.f_insert_tprocedimiento ('DIR_EMPR_ELI', 'Eliminacion de registros', 'si', '', '', 'dir.ft_empresa_ime');


select pxp.f_insert_tprocedimiento_gui ('DIR_ACT_INS', 'EMPACT', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_ACT_MOD', 'EMPACT', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_ACT_ELI', 'EMPACT', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_ACT_ARB_SEL', 'EMPACT', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_ACTGRAL_SEL', 'EMPR', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_ACTPRIM_SEL', 'EMPR', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_ACTESP_SEL', 'EMPR', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_EMPR_INS', 'EMPR', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_EMPR_MOD', 'EMPR', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_EMPR_ELI', 'EMPR', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_EMPR_SEL', 'EMPR', 'no');

/***********************************F-DAT-GSS-DIR-0-20/06/2013*****************************************/

/***********************************I-DAT-GSS-DIR-5-24/06/2013*****************************************/

select pxp.f_insert_tgui ('Plantilla Correo', 'plantilla de correo', 'PLTCOR', 'si', 2, 'sis_empresas/vista/plantilla_correo/PlantillaCorreo.php', 3, '', 'PlantillaCorreo', 'DIR');
select pxp.f_insert_testructura_gui ('PLTCOR', 'EMPPAR');

select pxp.f_insert_tfuncion ('dir.ft_plantilla_correo_sel', 'Funcion para tabla     ', 'DIR');
select pxp.f_insert_tfuncion ('dir.ft_plantilla_correo_ime', 'Funcion para tabla     ', 'DIR');
select pxp.f_insert_tprocedimiento ('DIR_PLTCOR_SEL', 'Consulta de datos', 'si', '', '', 'dir.ft_plantilla_correo_sel');
select pxp.f_insert_tprocedimiento ('DIR_PLTCOR_CONT', 'Conteo de registros', 'si', '', '', 'dir.ft_plantilla_correo_sel');
select pxp.f_insert_tprocedimiento ('DIR_PLTCOR_INS', 'Insercion de registros', 'si', '', '', 'dir.ft_plantilla_correo_ime');
select pxp.f_insert_tprocedimiento ('DIR_PLTCOR_MOD', 'Modificacion de registros', 'si', '', '', 'dir.ft_plantilla_correo_ime');
select pxp.f_insert_tprocedimiento ('DIR_PLTCOR_ELI', 'Eliminacion de registros', 'si', '', '', 'dir.ft_plantilla_correo_ime');

select pxp.f_insert_tprocedimiento_gui ('DIR_PLTCOR_INS', 'PLTCOR', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_PLTCOR_MOD', 'PLTCOR', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_PLTCOR_ELI', 'PLTCOR', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_PLTCOR_SEL', 'PLTCOR', 'no');

/***********************************F-DAT-GSS-DIR-5-24/06/2013*****************************************/

/***********************************I-DAT-GSS-DIR-6-27/06/2013*****************************************/

select pxp.f_insert_tgui ('Campaña', 'campañas', 'CAMP', 'si', 2, 'sis_empresas/vista/publicidad/Publicidad.php', 3, '', 'Publicidad', 'DIR');
select pxp.f_insert_tgui ('Subir Archivo', 'Subir Archivo', 'PLTCOR.1', 'no', 0, 'sis_empresas/vista/archivo_adjunto/SubirArchivo.php', 4, '', 'SubirArchivo', 'DIR');
select pxp.f_insert_tgui ('Archivos Adjuntados', 'Archivos Adjuntados', 'PLTCOR.2', 'no', 0, 'sis_empresas/vista/archivo_adjunto/ArchivoAdjunto.php', 4, '', '50%', 'DIR');

select pxp.f_insert_testructura_gui ('CAMP', 'EMPPR');
select pxp.f_insert_testructura_gui ('PLTCOR.1', 'PLTCOR');
select pxp.f_insert_testructura_gui ('PLTCOR.2', 'PLTCOR');

select pxp.f_insert_tfuncion ('dir.ft_archivo_adjunto_ime', 'Funcion para tabla     ', 'DIR');
select pxp.f_insert_tfuncion ('dir.ft_archivo_adjunto_sel', 'Funcion para tabla     ', 'DIR');
select pxp.f_insert_tfuncion ('dir.ft_publicidad_sel', 'Funcion para tabla     ', 'DIR');
select pxp.f_insert_tfuncion ('dir.ft_publicidad_ime', 'Funcion para tabla     ', 'DIR');

select pxp.f_insert_tprocedimiento ('DIR_ARCADJ_INS', 'Insercion de registros', 'si', '', '', 'dir.ft_archivo_adjunto_ime');
select pxp.f_insert_tprocedimiento ('DIR_ARCADJ_MOD', 'Modificacion de registros', 'si', '', '', 'dir.ft_archivo_adjunto_ime');
select pxp.f_insert_tprocedimiento ('DIR_ARCADJ_ELI', 'Eliminacion de registros', 'si', '', '', 'dir.ft_archivo_adjunto_ime');
select pxp.f_insert_tprocedimiento ('DIR_UPARCH_INS', 'Upload de archivo', 'si', '', '', 'dir.ft_archivo_adjunto_ime');
select pxp.f_insert_tprocedimiento ('DIR_ARCADJ_SEL', 'Consulta de datos', 'si', '', '', 'dir.ft_archivo_adjunto_sel');
select pxp.f_insert_tprocedimiento ('DIR_CAMPAR_SEL', 'Consulta de datos', 'si', '', '', 'dir.ft_archivo_adjunto_sel');
select pxp.f_insert_tprocedimiento ('DIR_ARCADJ_CONT', 'Conteo de registros', 'si', '', '', 'dir.ft_archivo_adjunto_sel');
select pxp.f_insert_tprocedimiento ('DIR_PLCR_INS', 'Insercion de registros', 'si', '', '', 'dir.ft_plantilla_correo_ime');
select pxp.f_insert_tprocedimiento ('DIR_PLCR_MOD', 'Modificacion de registros', 'si', '', '', 'dir.ft_plantilla_correo_ime');
select pxp.f_insert_tprocedimiento ('DIR_PLCR_ELI', 'Eliminacion de registros', 'si', '', '', 'dir.ft_plantilla_correo_ime');
select pxp.f_insert_tprocedimiento ('DIR_PLCR_SEL', 'Consulta de datos', 'si', '', '', 'dir.ft_plantilla_correo_sel');
select pxp.f_insert_tprocedimiento ('DIR_PLCR_CONT', 'Conteo de registros', 'si', '', '', 'dir.ft_plantilla_correo_sel');
select pxp.f_insert_tprocedimiento ('DIR_CAMP_SEL', 'Consulta de datos', 'si', '', '', 'dir.ft_publicidad_sel');
select pxp.f_insert_tprocedimiento ('DIR_CAMPELE_SEL', 'Consulta de datos', 'si', '', '', 'dir.ft_publicidad_sel');
select pxp.f_insert_tprocedimiento ('DIR_CORCAMP_SEL', 'Consulta de datos', 'si', '', '', 'dir.ft_publicidad_sel');
select pxp.f_insert_tprocedimiento ('DIR_CAMP_CONT', 'Conteo de registros', 'si', '', '', 'dir.ft_publicidad_sel');
select pxp.f_insert_tprocedimiento ('DIR_CAMPELE_CONT', 'Conteo de registros', 'si', '', '', 'dir.ft_publicidad_sel');
select pxp.f_insert_tprocedimiento ('DIR_CAMP_INS', 'Insercion de registros', 'si', '', '', 'dir.ft_publicidad_ime');
select pxp.f_insert_tprocedimiento ('DIR_CAMP_MOD', 'Modificacion de registros', 'si', '', '', 'dir.ft_publicidad_ime');
select pxp.f_insert_tprocedimiento ('DIR_AVACAMP_MOD', 'Modificacion de registros', 'si', '', '', 'dir.ft_publicidad_ime');
select pxp.f_insert_tprocedimiento ('DIR_CAMP_ELI', 'Eliminacion de registros', 'si', '', '', 'dir.ft_publicidad_ime');

select pxp.f_insert_tprocedimiento_gui ('DIR_PLCR_INS', 'PLTCOR', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_PLCR_MOD', 'PLTCOR', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_PLCR_ELI', 'PLTCOR', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_PLCR_SEL', 'PLTCOR', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_UPARCH_INS', 'PLTCOR.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_ARCADJ_INS', 'PLTCOR.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_ARCADJ_MOD', 'PLTCOR.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_ARCADJ_ELI', 'PLTCOR.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_ARCADJ_SEL', 'PLTCOR.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_CAMPAR_SEL', 'PLTCOR.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_CAMPELE_SEL', 'CAMP', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_CORCAMP_SEL', 'CAMP', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_CAMPAR_SEL', 'CAMP', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_AVACAMP_MOD', 'CAMP', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_PLCR_SEL', 'CAMP', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_ACT_SEL', 'CAMP', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_ACT_ARB_SEL', 'CAMP', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_ACTGRAL_SEL', 'CAMP', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_ACTPRIM_SEL', 'CAMP', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_ACTESP_SEL', 'CAMP', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_CAMP_INS', 'CAMP', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_CAMP_MOD', 'CAMP', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_CAMP_ELI', 'CAMP', 'no');
select pxp.f_insert_tprocedimiento_gui ('DIR_CAMP_SEL', 'CAMP', 'no');

/***********************************F-DAT-GSS-DIR-6-27/06/2013*****************************************/