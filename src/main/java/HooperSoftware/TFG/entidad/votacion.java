package HooperSoftware.TFG.entidad;

import java.util.List;

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
public class votacion {

    @Id
    Integer idVotacion;

    String ganador;

    Integer duracionVotacion;

    String categotiaVotacion;

    List<String> opcionesVotacion;
    
}
