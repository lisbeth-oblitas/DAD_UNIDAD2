package pe.edu.upeu.milkminder.controllers;

import com.google.gson.Gson;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import pe.edu.upeu.milkminder.models.ControlVaca;
import pe.edu.upeu.milkminder.services.ControlVacaService;


@RestController
@RequestMapping("/finca/cvaca")
public class ControlVacaController {
    
    @Autowired
    private ControlVacaService controlVacaService;
    
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ResponseEntity<List<ControlVaca>> listRaza() {
        List<ControlVaca> actDto = controlVacaService.findAll();
        
        //Gson gson = new Gson();
        //String jsonCartList = gson.toJson(actDto);
        //System.out.println("Ver Aqui: "+jsonCartList);
        return ResponseEntity.ok(actDto);
        //return new ResponseEntity<>(actDto, HttpStatus.OK);
    }
    
    @PostMapping("/crear")
    public ResponseEntity<ControlVaca> createControlVaca(@RequestBody ControlVaca controlVaca) {
        ControlVaca data = controlVacaService.save(controlVaca);
        return ResponseEntity.ok(data);
    }
    
    @GetMapping("/buscar/{id}")
    public ResponseEntity<ControlVaca> getControlVacaById(@PathVariable Long id) {
        ControlVaca controlVaca = controlVacaService.getControlVacaById(id);
        return ResponseEntity.ok(controlVaca);
    }
    
    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<Map<String, Boolean>> deleteControlVaca(@PathVariable Long id) {
        ControlVaca controlVaca = controlVacaService.getControlVacaById(id);
        return ResponseEntity.ok(controlVacaService.delete(controlVaca.getId()));
    }
    
    @PutMapping("/editar/{id}")
    public ResponseEntity<ControlVaca> updateControlVaca(@PathVariable Long id, @RequestBody ControlVaca controlVacaDetails) {        
        ControlVaca updatedControlVaca = controlVacaService.update(controlVacaDetails, id);
        return ResponseEntity.ok(updatedControlVaca);
    }      
}
