package HooperSoftware.TFG.entidad;

import java.util.List;

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

    List<String> campeonesCuartosOeste;

    List<String> campeonesSemisOeste;

    String campeonFinalOeste;

    List<String> campeonesCuartosEste;

    List<String> campeonesSemisEste;

    String campeonFinalEste;

    String campeonFinalNba;


    
}
