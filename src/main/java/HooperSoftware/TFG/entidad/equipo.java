package HooperSoftware.TFG.entidad;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;







@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Entity
public class Equipo {

    @Id
    Integer idEquipo;

    String nombreEquipo;

    String ciudad;

    String conferencia;

    String division;

    Integer anoFundacion;

    Integer anosNba;

    Integer titulosNba;

    Integer titulosConferencia;

    Integer partidosGanados;

    Integer partidosPerdidos;

    Double balanceTemporada;

    Integer posicion;

    String siglas;

    String estadio;

    String logoEquipo;

    String dorsalesRetirados;

    @OneToMany(mappedBy = "equipo", cascade = CascadeType.ALL)
    List<Jugador> jugadores;

    @OneToMany(mappedBy = "equipo", cascade = CascadeType.ALL)
    List<Entrenador> entrenadores;
    
    @OneToMany(mappedBy = "equipoOrigen", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    List<Transferencia> transferenciasOrigen;

    @OneToMany(mappedBy = "equipoDestino", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    List<Transferencia> transferenciasDestino;

}
