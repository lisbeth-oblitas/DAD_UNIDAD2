package pe.edu.upeu.milkminder.services;


import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pe.edu.upeu.milkminder.exceptions.AppException;

import pe.edu.upeu.milkminder.exceptions.ResourceNotFoundException;

import pe.edu.upeu.milkminder.models.ControlVaca;
import pe.edu.upeu.milkminder.repositories.ControlVacaRepository;


@RequiredArgsConstructor
@Service
@Transactional
public class ControlVacaServiceImp implements ControlVacaService{

    @Autowired
    private ControlVacaRepository controlVacaRepo;


    
    @Override
    public ControlVaca save(ControlVaca controlVaca) {
        
        try {
            return controlVacaRepo.save(controlVaca);
        } catch (Exception e) {
            throw new AppException("Error-"+e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public List<ControlVaca> findAll() {
        try {
            return controlVacaRepo.findAll();
        } catch (Exception e) {
            throw new AppException("Error-"+e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public Map<String, Boolean> delete(Long id) {
        ControlVaca controlVacax = controlVacaRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Actividad not exist with id :" + id));

        controlVacaRepo.delete(controlVacax);
        Map<String, Boolean> response = new HashMap<>();
        response.put("deleted", true);

        return response;        
    }

    @Override
    public ControlVaca getControlVacaById(Long id) {
        ControlVaca findControlVaca = controlVacaRepo.findById(id).orElseThrow(() -> new ResourceNotFoundException("Activiad not exist with id :" + id));
        return findControlVaca;        
    }

    @Override
    public ControlVaca update(ControlVaca controlVaca , Long id) {
        ControlVaca controlVacax = controlVacaRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Periodo not exist with id :" + id));
        controlVacax.setEtapaDetalle(controlVaca.getEtapaDetalle());
        
        return controlVacaRepo.save(controlVacax);        
    }
    
}
