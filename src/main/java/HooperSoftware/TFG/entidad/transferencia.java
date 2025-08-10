package HooperSoftware.TFG.entidad;

import java.time.LocalDate;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.util.List;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
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

    String equipoOrigenString;

    String equipoDestinoString;

    String infoRondaDraft;

    @OneToMany
    List<Jugador> jugadores;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "equipoOrigen", referencedColumnName = "idEquipo")
    Equipo equipoOrigen;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "equipoDestino", referencedColumnName = "idEquipo")
    Equipo equipoDestino;

}
