package HooperSoftware.TFG.entidad;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
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

    String añosTemporada;

    String campeonTemporada;

    String mvpTemporada;

    String rookieTemporada;

    String defensorTemporada;

    String sextoHombreTemporada;

    String jugadorMasMejoradoTemporada;

    String entrenadorTemporada;

    String campeonOesteTemp;

    String campeonEsteTemp;

    String campeonNBATemp;

    @ManyToMany(cascade = CascadeType.ALL,mappedBy = "Temporadas")
    List<Equipo> equipos;

    @OneToMany
    List<Jornada> jornadas;
    
}
