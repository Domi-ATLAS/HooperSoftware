package HooperSoftware.TFG.entidad;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import HooperSoftware.TFG.entidad.Votacion;
import HooperSoftware.TFG.entidad.EstadisticasJugador;
import HooperSoftware.TFG.entidad.Partido;




@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Entity
public class Jugador {

    @Id
    Integer idJugador;

    String nombreJugador;

    String posicion;

    Integer dorsal;

    String trayectoriaJug;

    Integer anoDraft;

    Integer edadJug;

    Integer anosAllStarJug;

    Integer anosNbaJug;

    Integer anosOtraLigaJug;

    String fotoJugador;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "estadisticasJug",referencedColumnName = "idEstJugador")
    EstadisticasJugador estadisticasJug;

    
}
