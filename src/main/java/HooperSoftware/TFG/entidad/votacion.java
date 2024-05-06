package HooperSoftware.TFG.entidad;

import java.util.List;

import jakarta.persistence.CascadeType;
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

    List<String> opcionesVotacion;

    Boolean enCurso;

    @OneToMany(cascade = CascadeType.ALL,mappedBy = "nombreUsuario")
    List<Usuario> usuarios;

    @OneToMany(cascade = CascadeType.ALL,mappedBy = "idEntrenador")
    List<Entrenador> entrenadores;

    @OneToMany(cascade = CascadeType.ALL,mappedBy = "idJugador")
    List<Jugador> jugadores;
    
}
