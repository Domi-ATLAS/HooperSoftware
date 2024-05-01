package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.Entrenador;
import HooperSoftware.TFG.entidad.Equipo;
import HooperSoftware.TFG.entidad.Jugador;

@Repository
public interface EquipoRepository extends CrudRepository<Equipo,Integer>{
    
    @Query("SELECT e FROM Equipo e")
    List<Equipo> findAll();

    @Query("SELECT e FROM Equipo e WHERE e.idEquipo = ?1")
    Equipo findEquipoById(Integer idEquipo);

    @Query("SELECT e FROM Equipo e WHERE e.nombreEquipo LIKE ?1")
    List<Equipo> findEquipoByNombre(String nombre);

    @Query("SELECT e FROM Equipo e WHERE e.conferencia = ?1")
    List<Equipo> findEquipoByConferencia(String conferencia);

    @Query("SELECT e FROM Equipo e WHERE e.division = ?1")
    List<Equipo> findEquipoByDivision(String division);

    @Query("SELECT e FROM Equipo e WHERE e.anoFundacion > ?1")
    List<Equipo> findEquipoByAnoFundacion(Integer anoFundacion);

    @Query("SELECT e FROM Equipo e WHERE e.anosNba > ?1")
    List<Equipo> findEquipoByAnosNba(Integer anosNba);

    @Query("SELECT e FROM Equipo e WHERE e.titulosNba > ?1")
    List<Equipo> findEquipoByTitulosNba(Integer titulosNba);

    @Query("SELECT e FROM Equipo e WHERE e.titulosConferencia > ?1")
    List<Equipo> findEquipoByTitulosConferencia(Integer titulosConferencia);

    @Query("SELECT e FROM Equipo e WHERE e.partidosGanados > ?1")
    List<Equipo> findEquipoByPartidosGanados(Integer partidosGanados);

    @Query("SELECT e FROM Equipo e WHERE e.partidosPerdidos > ?1")
    List<Equipo> findEquipoByPartidosPerdidos(Integer partidosPerdidos);

    @Query("SELECT e FROM Equipo e WHERE e.balanceTemporada > ?1")
    List<Equipo> findEquipoByBalanceTemporada(Integer balanceTemporada);

    @Query("SELECT e.jugadores FROM Equipo e WHERE e.id = ?1")
    List<Jugador> findJugadoresByEquipoId(Integer equipoId);

    @Query("SELECT e.entrenadores FROM Equipo e WHERE e.id = ?1")
    List<Entrenador> findEntrenadoresByEquipoId(Integer equipoId);

}
