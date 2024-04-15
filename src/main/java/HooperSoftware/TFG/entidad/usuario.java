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
import HooperSoftware.TFG.entidad.Votacion;


@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Entity
public class Usuario {

    @Id
    String nombreUsuario;

    Integer numeroTelefono;

    String correo;

    String equipoFavorito;

    String nickName;

    String contrasena;

    String foto;

    @OneToMany(cascade = CascadeType.ALL,mappedBy = "idVotacion")
    List<Votacion> votaciones;
    
}
