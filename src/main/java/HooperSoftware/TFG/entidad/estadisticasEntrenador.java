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
public class EstadisticasEntrenador {

    @Id
    Integer idEstEntrenador;

    Integer partidosJugadosEntr;

    Integer partidosGanadosEntr;

    Integer partidosPerdidosEntr;

    Integer titulosGanadoNbaEntr;

    Integer titulosPerdidosNbaEntr;

    Integer titulosGanadoConferenciaEntr;

    Integer titulosPerdidosConferenciaEntr;
    
}
