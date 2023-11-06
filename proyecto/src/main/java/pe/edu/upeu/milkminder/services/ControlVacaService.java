package pe.edu.upeu.milkminder.services;

import java.util.List;
import java.util.Map;

import pe.edu.upeu.milkminder.models.ControlVaca;


public interface ControlVacaService {
     ControlVaca save(ControlVaca controlVaca);

    List<ControlVaca> findAll();

    Map<String, Boolean> delete(Long id);

    ControlVaca getControlVacaById(Long id);

    ControlVaca update(ControlVaca controlVaca, Long id);   
}