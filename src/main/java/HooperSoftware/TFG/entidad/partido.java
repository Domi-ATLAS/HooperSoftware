package HooperSoftware.TFG.entidad;

import java.util.Date;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import HooperSoftware.TFG.entidad.Jugador;
import HooperSoftware.TFG.entidad.Entrenador;
import HooperSoftware.TFG.entidad.Equipo;
import HooperSoftware.TFG.entidad.Playoff;





@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Entity
public class Partido {

    @Id
    Integer idPartido;

    String resultadoC1;

    String resultadoC2;

    String resultadoC3;

    String resultadoC4;

    String resultadoTotal;

    Boolean prorroga;

    String resultadoProrroga;

    Boolean playOffSiONo;

    String temporada;

    String victoriaSerie;

    String equipoLocal;

    String equipoVisitante;

    Date fecha;

    String ganador;

    @OneToMany(cascade = CascadeType.ALL,mappedBy = "idJugador")
    List<Jugador> jugadores;

    @OneToMany(cascade = CascadeType.ALL,mappedBy = "idEntrenador")
    List<Entrenador> entrenadores;

    @ManyToOne
    @JoinColumn(name = "idPlayOff",referencedColumnName = "idPlayOff")
    Playoff playoff;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "equipoLocalTa",referencedColumnName = "idEquipo")
    Equipo equipoLocalTa;
    
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "equipoVisitanteTa",referencedColumnName = "idEquipo")
    Equipo equipoVisitanteTa;
}
