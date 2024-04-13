package HooperSoftware.TFG.entidad;

import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import HooperSoftware.TFG.entidad.Partido;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Entity
public class Jornada {

    @Id
    Integer idJornada;

    Integer numeroPartido;

    Boolean partidoCancelado;

    @OneToMany
    List<Partido> partidos;


    
}
