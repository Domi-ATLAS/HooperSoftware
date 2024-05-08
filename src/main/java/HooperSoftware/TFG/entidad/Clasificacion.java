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
public class Clasificacion {
    
    @Id
    String temporada;

    String primeroEste;

    String segundoEste;

    String terceroEste;

    String cuartoEste;

    String quintoEste;

    String sextoEste;

    String septimoEste;

    String octavoEste;

    String primeroOeste;

    String segundoOeste;

    String terceroOeste;

    String cuartoOeste;

    String quintoOeste;

    String sextoOeste;

    String septimoOeste;

    String octavoOeste;
}
