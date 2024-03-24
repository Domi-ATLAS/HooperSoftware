package HooperSoftware.TFG.entidad;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
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

    Integer victoriaSerie;

    @ManyToMany(cascade = CascadeType.ALL,mappedBy = "Partidos")
    List<Jugador> jugadores;

    @ManyToMany(cascade = CascadeType.ALL,mappedBy = "Partidos")
    List<Entrenador> entrenadores;

    @ManyToMany(cascade = CascadeType.ALL,mappedBy = "Partidos")
    List<Equipo> equipos;

    @ManyToOne
    Playoff playoff;
}
