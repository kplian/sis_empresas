/********************************************I-DEP-GSS-DIR-0-19/06/2013********************************************/

ALTER TABLE dir.tempresa
  ADD CONSTRAINT fk_tempresa__id_lugar FOREIGN KEY (id_lugar)
    REFERENCES param.tlugar(id_lugar)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE dir.tempresa
  ADD CONSTRAINT fk_tempresa__id_actividad FOREIGN KEY (id_actividad)
    REFERENCES dir.tactividad(id_actividad)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE dir.tpublicidad
  ADD CONSTRAINT fk_tpublicidad__id_lugar FOREIGN KEY (id_lugar)
    REFERENCES param.tlugar(id_lugar)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE dir.tactividad
  ADD CONSTRAINT fk_tactividad__id_actividad_fk FOREIGN KEY (id_actividad_fk)
    REFERENCES dir.tactividad(id_actividad)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
/********************************************F-DEP-GSS-DIR-0-19/06/2013********************************************/

/********************************************I-DEP-GSS-DIR-5-24/06/2013********************************************/

ALTER TABLE dir.tarchivo_adjunto
  ADD CONSTRAINT fk_tarchivo_adjunto__id_plantilla_correo FOREIGN KEY (id_plantilla_correo)
    REFERENCES dir.tplantilla_correo(id_plantilla_correo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
/********************************************F-DEP-GSS-DIR-5-24/06/2013********************************************/

/********************************************I-DEP-GSS-DIR-6-27/06/2013********************************************/

ALTER TABLE dir.tpublicidad
  ADD CONSTRAINT fk_tpublicidad__id_actividad FOREIGN KEY (id_actividad)
    REFERENCES dir.tactividad(id_actividad)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE dir.tpublicidad
  ADD CONSTRAINT fk_tpublicidad__id_plantilla_correo FOREIGN KEY (id_plantilla_correo)
    REFERENCES dir.tplantilla_correo(id_plantilla_correo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

/********************************************F-DEP-GSS-DIR-6-27/06/2013********************************************/