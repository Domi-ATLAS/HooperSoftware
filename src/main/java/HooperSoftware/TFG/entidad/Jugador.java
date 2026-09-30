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
public class Jugador {

    @Id
    Integer idJugador;

    String nombreJugador;

    String posicion;

    Integer dorsal;

    String dorsales;

    Boolean retirado;

    Boolean hallOfFame;

    String universidad;

    String paisNacimiento;

    String ciudadNacimiento;

    String alturaJug;

    String pesoJug;

    String trayectoriaJug;

    Integer anoDraft;

    Integer edadJug;

    Integer anosAllStarJug;

    Integer anosNbaJug;

    Integer anosOtraLigaJug;

    String temporadaJugador;

    String fotoJugador;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "estadisticasJug", referencedColumnName = "idEstJugador")
    EstadisticasJugador estadisticasJug;

    @ManyToOne
    @JoinColumn(name = "idEquipo", referencedColumnName = "idEquipo") // Nombre de la columna en la BD
    private Equipo equipo;

    public String getNombreJugador() {
        return nombreJugador;
    }

    public Integer getAnosNbaJug() {
        return anosNbaJug;
    }

    public Integer getAnosAllStarJug() {
        return anosAllStarJug;
    }

    public Integer getEdadJug() {
        return edadJug;
    }

    public String getPosicion() {
        return posicion;
    }

    public Equipo getEquipo() {
        return equipo;
    }

    public Integer getIdJugador() {
        return idJugador;
    }

}
