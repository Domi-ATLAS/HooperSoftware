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
public class temporada {

    @Id
    Integer idTemporada;

    String añosTemporada;

    String campeonTemporada;

    String mvpTemporada;

    String rookieTemporada;

    String defensorTemporada;

    String sextoHombreTemporada;

    String jugadorMasMejoradoTemporada;

    String entrenadorTemporada;

    String campeonOesteTemp;

    String campeonEsteTemp;

    String campeonNBATemp;
    
}
