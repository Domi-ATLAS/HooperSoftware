package HooperSoftware.TFG.entidad;

import java.time.LocalDate;

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
public class transferencia {

    @Id
    Integer idTransferencia;

    Integer precio;

    Boolean rondaDraft;

    LocalDate fecha;

    String equipoOrigen;

    String equipoDestino;

    String jugador;

    String infoRondaDraft;
    
}
