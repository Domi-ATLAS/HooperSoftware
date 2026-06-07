package HooperSoftware.TFG.entidad;

import java.util.Date;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import HooperSoftware.TFG.entidad.Usuario;
import HooperSoftware.TFG.entidad.Jugador;
import HooperSoftware.TFG.entidad.Entrenador;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Entity
public class Votacion {

    @Id
    Integer idVotacion;

    String ganador;

    Integer duracionVotacion;

    Categoria categotiaVotacion;

    /*     @ElementCollection
     */    String opcionesVotacion;

    Boolean enCurso;

    Boolean oficial;

    String temporada;

    String jornada;

    Date fecha;

    Integer totalVotos;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "nombreUsuario")
    List<Usuario> usuarios;

    public String getOpcionesVotacion() {
        return opcionesVotacion;
    }

    public Integer getTotalVotos() {
        return totalVotos;
    }

    public void setTotalVotos(Integer totalVotos) {
        this.totalVotos = totalVotos;
    }
}
