package HooperSoftware.TFG.entidad;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;



@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Entity
public class equipo {

    @Id
    Integer idEquipo;

    Integer añosNba;

    Integer titulosNba;

    Integer titulosConferencia;

    Integer partidosGanados;

    Integer partidosPerdidos;

    String balanceTemporada;
    
}
