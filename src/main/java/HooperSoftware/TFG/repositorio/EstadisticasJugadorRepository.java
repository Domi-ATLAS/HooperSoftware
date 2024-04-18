package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.EstadisticasJugador;

@Repository
public interface EstadisticasJugadorRepository extends CrudRepository<EstadisticasJugador,Integer> {
    
    @Query("SELECT e FROM EstadisticasJugador e")
    List<EstadisticasJugador> findAll();

    @Query("SELECT e FROM EstadisticasJugador e WHERE e.idEstJugador = ?1")
    EstadisticasJugador findEstadisticasJugadorById(Integer idEstadisticasJugador);

    @Query("SELECT e FROM EstadisticasJugador e WHERE e.puntosTotales >= ?1")
    List<EstadisticasJugador> findEstadisticasJugadorByPuntosTotales(Integer puntosTotales);

    @Query("SELECT e FROM EstadisticasJugador e WHERE e.asistenciasTotales >= ?1")
    List<EstadisticasJugador> findEstadisticasJugadorByAsistenciasTotales(Integer asistenciasTotales);

    @Query("SELECT e FROM EstadisticasJugador e WHERE e.rebotesTotales >= ?1")
    List<EstadisticasJugador> findEstadisticasJugadorByRebotesTotales(Integer rebotesTotales);

    @Query("SELECT e FROM EstadisticasJugador e WHERE e.tirosLibresAnotados >= ?1")
    List<EstadisticasJugador> findEstadisticasJugadorByTiroLibreAnotados(Integer tiroLibreAnotados);

    @Query("SELECT e FROM EstadisticasJugador e WHERE e.tirosDeCampoAnotados >= ?1")
    List<EstadisticasJugador> findEstadisticasJugadorByTirosDeCampoAnotados(Integer tirosDeCampoAnotados);

    @Query("SELECT e FROM EstadisticasJugador e WHERE e.minutosTotales >= ?1")
    List<EstadisticasJugador> findEstadisticasJugadorByMinutosTotales(Integer minutosTotales);

    @Query("SELECT e FROM EstadisticasJugador e WHERE e.partidosJugadosJug >= ?1")
    List<EstadisticasJugador> findEstadisticasJugadorByPartidosJugadosJug(Integer partidosJugadosJug);

    @Query("SELECT e FROM EstadisticasJugador e WHERE e.partidosGanadosJug >= ?1")
    List<EstadisticasJugador> findEstadisticasJugadorByPartidosGanadosJug(Integer partidosGanadosJug);

    @Query("SELECT e FROM EstadisticasJugador e WHERE e.partidosPerdidosJug >= ?1")
    List<EstadisticasJugador> findEstadisticasJugadorByPartidosPerdidosJug(Integer partidosPerdidosJug);

    @Query("SELECT e FROM EstadisticasJugador e WHERE e.titulosGanadoNbaJug >= ?1")
    List<EstadisticasJugador> findEstadisticasJugadorByTitulosGanadoNbaJug(Integer titulosGanadoNbaJug);

    @Query("SELECT e FROM EstadisticasJugador e WHERE e.titulosPerdidosNbaJug >= ?1")
    List<EstadisticasJugador> findEstadisticasJugadorByTitulosPerdidosNbaJug(Integer titulosPerdidosNbaJug);

    @Query("SELECT e FROM EstadisticasJugador e WHERE e.titulosGanadoConferenciaJug >= ?1")
    List<EstadisticasJugador> findEstadisticasJugadorByTitulosGanadoConferenciaJug(Integer titulosGanadoConferenciaJug);

    @Query("SELECT e FROM EstadisticasJugador e WHERE e.titulosPerdidosConferenciaJug >= ?1")
    List<EstadisticasJugador> findEstadisticasJugadorByTitulosPerdidosConferenciaJug(Integer titulosPerdidosConferenciaJug);

    @Query("SELECT e FROM EstadisticasJugador e WHERE e.robosTotales >= ?1")
    List<EstadisticasJugador> findEstadisticasJugadorByRobosTotales(Integer robosTotales);

}
