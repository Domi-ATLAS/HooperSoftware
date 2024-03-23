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
public class jugador {

    @Id
    Integer idJugador;

    String nombreJugador;

    String posicion;

    String trayectoriaJug;

    String añoDraft;

    Integer edadJug;

    Integer añosAllStarJug;

    Integer añosNBAJug;

    Integer añosOtraLigaJug;


    
}
