package HooperSoftware.TFG.entidad;

import java.time.LocalDate;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.util.List;
import jakarta.persistence.OneToMany;
import HooperSoftware.TFG.entidad.Jugador;
import HooperSoftware.TFG.entidad.Equipo;





@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Entity
public class Transferencia {

    @Id
    Integer idTransferencia;

    Integer precio;

    Boolean rondaDraft;

    LocalDate fecha;

    String equipoOrigen;

    String equipoDestino;

    String jugador;

    String infoRondaDraft;

    @OneToMany
    List<Jugador> jugadores;

    @ManyToMany(cascade = CascadeType.ALL,mappedBy = "Transferencias")
    List<Equipo> equipos;

}
