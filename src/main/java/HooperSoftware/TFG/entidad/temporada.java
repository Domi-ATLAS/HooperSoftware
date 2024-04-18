package HooperSoftware.TFG.entidad;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import HooperSoftware.TFG.entidad.Equipo;
import HooperSoftware.TFG.entidad.Jornada;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Entity
public class Temporada {

    @Id
    Integer idTemporada;

    String anosTemporada;

    String campeonTemporada;

    String mvpTemporada;

    String rookieTemporada;

    String defensorTemporada;

    String sextoHombreTemporada;

    String jugadorMasMejoradoTemporada;

    String entrenadorTemporada;

    String campeonOesteTemp;

    String campeonEsteTemp;

    String campeonNbaTemp;

    /* @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idEquipo",referencedColumnName = "idEquipo")
    Equipo equipo; */

    @OneToMany
    List<Jornada> jornadas;
    
}
