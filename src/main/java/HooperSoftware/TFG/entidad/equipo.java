package HooperSoftware.TFG.entidad;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;
import HooperSoftware.TFG.entidad.Jugador;
import HooperSoftware.TFG.entidad.Entrenador;
import HooperSoftware.TFG.entidad.Transferencia;
import HooperSoftware.TFG.entidad.Partido;  
import HooperSoftware.TFG.entidad.Temporada;  







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

    @OneToMany
    List<Jugador> jugadores;

    @OneToMany
    List<Entrenador> entrenadores;
    
    @OneToMany(fetch = FetchType.EAGER)
    List<Transferencia> transferencias;

}
