package pe.edu.upeu.milkminder.repositories;


import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import pe.edu.upeu.milkminder.models.ControlVaca;

@Repository
public interface ControlVacaRepository extends JpaRepository<ControlVaca, Long>{
    
}
