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
public class estadisticasJugador {

    @Id
    Integer idEstJugador;

    Integer puntosTotales;

    Integer asistenciasTotales;

    Integer rebotesTotales;

    Integer taponesTotales;

    Integer robosTotales;

    Integer partidosJugadosJug;

    Integer partidosGanadosJug;

    Integer partidosPerdidosJug; 

    Integer triplesAnotados;

    Integer tirosLibresAnotados;

    Integer tirosDeCampoAnotados;

    Integer minutosTotales;

    Integer titulosGanadoNbaJug;

    Integer titulosPerdidosNbaJug;

    Integer titulosGanadoConferenciaJug;

    Integer titulosPerdidosConferenciaJug;

    
}
