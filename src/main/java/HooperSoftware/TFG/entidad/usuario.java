package HooperSoftware.TFG.entidad;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;



@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Entity
public class usuario {

    @Id
    String nombreUsuario;

    Integer numeroTelefono;

    String correo;

    String equipoFavorito;

    String nickName;

    String contraseña;
    
}
