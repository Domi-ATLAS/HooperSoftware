package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.EstadisticasEntrenador;

@Repository
public interface EstadisticasEntrenadorRepository extends CrudRepository<EstadisticasEntrenador,Integer>{
    
    @Query("SELECT e FROM EstadisticasEntrenador e")
    List<EstadisticasEntrenador> findAll();

    @Query("SELECT e FROM EstadisticasEntrenador e WHERE e.idEstEntrenador = ?1")
    EstadisticasEntrenador findEstadisticasEntrenadorById(Integer idEstadisticasEntrenador);

    @Query("SELECT e FROM EstadisticasEntrenador e WHERE e.partidosJugadosEntr > ?1")
    List<EstadisticasEntrenador> findEstadisticasEntrenadorByPartidosJugadosEntr(Integer partidosJugadosEntr);

    @Query("SELECT e FROM EstadisticasEntrenador e WHERE e.partidosGanadosEntr > ?1")
    List<EstadisticasEntrenador> findEstadisticasEntrenadorByPartidosGanadosEntr(Integer partidosGanadosEntr);

    @Query("SELECT e FROM EstadisticasEntrenador e WHERE e.partidosPerdidosEntr > ?1")
    List<EstadisticasEntrenador> findEstadisticasEntrenadorByPartidosPerdidosEntr(Integer partidosPerdidosEntr);

    @Query("SELECT e FROM EstadisticasEntrenador e WHERE e.titulosGanadoNbaEntr > ?1")
    List<EstadisticasEntrenador> findEstadisticasEntrenadorByTitulosGanadoNbaEntr(Integer titulosGanadoNbaEntr);

    @Query("SELECT e FROM EstadisticasEntrenador e WHERE e.titulosPerdidosNbaEntr > ?1")
    List<EstadisticasEntrenador> findEstadisticasEntrenadorByTitulosPerdidosNbaEntr(Integer titulosPerdidosNbaEntr);

    @Query("SELECT e FROM EstadisticasEntrenador e WHERE e.titulosGanadoConferenciaEntr > ?1")
    List<EstadisticasEntrenador> findEstadisticasEntrenadorByTitulosGanadoConfercia(Integer titulosConferenciaGanados);

    @Query("SELECT e FROM EstadisticasEntrenador e WHERE e.titulosPerdidosConferenciaEntr > ?1")
    List<EstadisticasEntrenador> findEstadisticasEntrenadorByTitulosPerdidosConferencia(Integer titulosConferenciaPerdidos);

    @Query("SELECT e FROM EstadisticasEntrenador e ORDER BY e.partidosJugadosEntr DESC")
    List<EstadisticasEntrenador> findAllByOrderByPartidosJugadosEntrDesc();

    @Query("SELECT e FROM EstadisticasEntrenador e ORDER BY e.partidosGanadosEntr DESC")
    List<EstadisticasEntrenador> findAllByOrderByPartidosGanadosEntrDesc();

    @Query("SELECT e FROM EstadisticasEntrenador e ORDER BY e.partidosPerdidosEntr DESC")
    List<EstadisticasEntrenador> findAllByOrderByPartidosPerdidosEntrDesc();

    @Query("SELECT e FROM EstadisticasEntrenador e ORDER BY e.titulosGanadoNbaEntr DESC")
    List<EstadisticasEntrenador> findAllByOrderByTitulosGanadoNbaEntrDesc();

    @Query("SELECT e FROM EstadisticasEntrenador e ORDER BY e.titulosPerdidosNbaEntr DESC")
    List<EstadisticasEntrenador> findAllByOrderByTitulosPerdidosNbaEntrDesc();

    @Query("SELECT e FROM EstadisticasEntrenador e ORDER BY e.titulosGanadoConferenciaEntr DESC")
    List<EstadisticasEntrenador> findAllByOrderByTitulosGanadoConferenciaEntrDesc();

    @Query("SELECT e FROM EstadisticasEntrenador e ORDER BY e.titulosPerdidosConferenciaEntr DESC")
    List<EstadisticasEntrenador> findAllByOrderByTitulosPerdidosConferenciaEntrDesc();


}
