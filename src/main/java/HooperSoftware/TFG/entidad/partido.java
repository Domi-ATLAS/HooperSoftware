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
public class partido {

    @Id
    Integer idPartido;

    String resultadoC1;

    String resultadoC2;

    String resultadoC3;

    String resultadoC4;

    String resultadoTotal;

    Boolean prorroga;

    String resultadoProrroga;

    Boolean playOff;

    Integer victoriaSerie;
    
}
