package HooperSoftware.TFG.entidad;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Entity
public class Entrenador {

    @Id
    Integer idEntrenador;

    String nombeEntrenador;

    String equipoEntr;

    String trayectoriaEntr;

    Integer edadEntr;

    Integer anosNbaEntr;

    Integer anosOtrasLigasEntr;

    Integer anosAllStarEntr;

    Boolean aSidoJugador;

    String fotoEntrenador;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "estadisticasEntr", referencedColumnName = "idEstEntrenador")
    EstadisticasEntrenador estadisticasEntr;

    @ManyToOne
    @JoinColumn(name = "idEquipo", referencedColumnName = "idEquipo") // Relación con Equipo
    private Equipo equipo;

    public String getNombeEntrenador() {
        return nombeEntrenador;
    }
}
