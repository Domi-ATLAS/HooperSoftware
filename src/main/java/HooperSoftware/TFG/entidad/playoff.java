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
public class Playoff {

    @Id
    Integer idPlayOff;

    String campeonCuartosOeste;

    String campeonSemisOeste;

    String campeonFinalOeste;

    String campeonCuartosEste;

    String campeonSemisEste;

    String campeonFinalEste;

    String campeonFinalNBA;


    
}
