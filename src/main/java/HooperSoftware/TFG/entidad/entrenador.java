package HooperSoftware.TFG.entidad;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import HooperSoftware.TFG.entidad.Votacion;
import HooperSoftware.TFG.entidad.EstadisticasEntrenador;




@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Entity
public class Entrenador {

    @Id
    Integer idEntrenador;

    String nombeEntrenador;

    String trayectoriaEntr;

    Integer edadEntr;

    Integer añosNbaEntr;
    
    Integer añosOtrasLigasEntr;

    Integer añosAllStarEntr;

    Boolean aSidoJugador;

    @ManyToMany(cascade = CascadeType.ALL,mappedBy = "Entrenadores")
    List<Votacion> votaciones;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "entrenador",referencedColumnName = "entrenador")
    EstadisticasEntrenador estadisticasEntr;

    
}
