package pe.edu.upeu.milkminder.models;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name = "controlvaca    ")
public class ControlVaca {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; 
    
    @Column(name = "etapaDetalle", nullable = false)
    private String etapaDetalle;

    @Column(name = "fechaProg", nullable = false)
    private String fechaProg;

    @JsonFormat(pattern = "yyyy-MM-dd")
    @Basic(optional = false)
    @Column(name = "fechaReal", nullable = false)
    @Temporal(TemporalType.DATE)
    private LocalDate fechaReal;

    @Column(name = "pesoVivo", nullable = false)
    private String pesoVivo;

    @Column(name = "preño", nullable = false)
    private String preno;

    @Column(name = "condicionCorporal", nullable = false)
    private String condicionCorporal;

    @Column(name = "tieneMastitis", nullable = false)
    private String tieneMastitis;

    @Column(name = "tratamiento", nullable = false)
    private String tratamiento;
}
