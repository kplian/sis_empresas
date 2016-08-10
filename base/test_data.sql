------------
--- GSSS ---
------------

---ACTIVIDAD

/* Data for the 'dir.tactividad' table  (Records 1 - 6) */

INSERT INTO dir.tactividad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_actividad", "id_actividad_fk", "codigo", "nombre", "codigo_largo")
VALUES (1, NULL, E'2013-06-25 18:19:37.862', NULL, E'activo', 1, NULL, E'dfg', E'dfg', E'dfg');

INSERT INTO dir.tactividad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_actividad", "id_actividad_fk", "codigo", "nombre", "codigo_largo")
VALUES (1, NULL, E'2013-06-25 18:19:43.206', NULL, E'activo', 2, 1, E'hjk', E'hjk', E'dfg.hjk');

INSERT INTO dir.tactividad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_actividad", "id_actividad_fk", "codigo", "nombre", "codigo_largo")
VALUES (1, NULL, E'2013-06-25 18:19:48.738', NULL, E'activo', 3, 2, E'iop', E'iop', E'dfg.hjk.iop');

INSERT INTO dir.tactividad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_actividad", "id_actividad_fk", "codigo", "nombre", "codigo_largo")
VALUES (1, NULL, E'2013-06-25 18:20:03.112', NULL, E'activo', 4, NULL, E'dos', E'dos', E'dos');

INSERT INTO dir.tactividad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_actividad", "id_actividad_fk", "codigo", "nombre", "codigo_largo")
VALUES (1, NULL, E'2013-06-25 18:20:11.777', NULL, E'activo', 5, 4, E'tres', E'tres', E'dos.tres');

INSERT INTO dir.tactividad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_actividad", "id_actividad_fk", "codigo", "nombre", "codigo_largo")
VALUES (1, NULL, E'2013-06-25 18:20:20.395', NULL, E'activo', 6, 5, E'cuatro', E'cuatro', E'dos.tres.cuatro');

--PLANTILLA

/* Data for the 'dir.tplantilla_correo' table  (Records 1 - 1) */

INSERT INTO dir.tplantilla_correo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla_correo", "codigo", "body", "remitente_nombre", "remitente_email", "asunto")
VALUES (1, 1, E'2013-06-25 16:24:06.167', E'2013-06-28 11:21:45.757', E'activo', 1, E'CORREOMASIVO', E'hola<br>este es mi correo de prueba<br>visita:<br><a href=\"http://www.google.com\">www.google.com</a><br><br>pd correo​ esto esta bien ?<br><br><img class=\"decoded\" alt=\"http://ns2.elhacker.net/timofonica/fotos/animales/fotos-divertidas-animales.jpg\" src=\"http://ns2.elhacker.net/timofonica/fotos/animales/fotos-divertidas-animales.jpg\" height=\"104\" width=\"106\"><br>', E'Kplian', E'admin@kplian.com', E'Email de prueba');

--EMPRESA

/* Data for the 'dir.tempresa' table  (Records 1 - 4) */

INSERT INTO dir.tempresa ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_empresa", "matricula", "nombre", "email", "domicilio", "actividad", "id_lugar", "id_actividad", "telefono", "nit")
VALUES (1, NULL, E'2013-06-26 12:17:05.875', NULL, E'activo', 3, 334645, E'MANACO', E'gonzalo@kplian.com', E'', E'', 2, 6, E'', E'');

INSERT INTO dir.tempresa ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_empresa", "matricula", "nombre", "email", "domicilio", "actividad", "id_lugar", "id_actividad", "telefono", "nit")
VALUES (1, 1, E'2013-06-26 10:45:55.862', E'2013-06-27 10:23:32.440', E'activo', 1, 12435, E'KPLIAN', E'magnojosegonzalo@hotmail.com', E'ante', E'sdfdsf', 3, 3, E'547888', E'3546');

INSERT INTO dir.tempresa ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_empresa", "matricula", "nombre", "email", "domicilio", "actividad", "id_lugar", "id_actividad", "telefono", "nit")
VALUES (1, 1, E'2013-06-26 12:13:10.271', E'2013-06-27 16:27:41.024', E'activo', 2, 12345345, E'UMSS', E'magno_gonzalo@hotmail.com', E'', E'', 3, 3, E'', E'');

INSERT INTO dir.tempresa ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_empresa", "matricula", "nombre", "email", "domicilio", "actividad", "id_lugar", "id_actividad", "telefono", "nit")
VALUES (1, 1, E'2013-06-26 12:17:47.416', E'2013-06-27 19:10:34.896', E'activo', 4, 345456, E'WILSTERMAN', E'magno.gonzalo@gmail.com', E'', E'', 3, 3, E'', E'');

