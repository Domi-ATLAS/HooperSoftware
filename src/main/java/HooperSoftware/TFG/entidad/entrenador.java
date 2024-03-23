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
public class entrenador {

    @Id
    Integer idEntrenador;

    String nombeEntrenador;

    String trayectoriaEntr;

    Integer edadEntr;

    Integer añosNbaEntr;
    
    Integer añosOtrasLigasEntr;

    Integer añosAllStarEntr;

    Boolean aSidoJugador;
    
}
