package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.Entrenador;
import HooperSoftware.TFG.entidad.Equipo;

@Repository
public interface EntrenadorRepository extends CrudRepository<Entrenador, Integer> {

    @Query("SELECT e FROM Entrenador e")
    List<Entrenador> findAll();

    @Query("SELECT e FROM Entrenador e WHERE e.idEntrenador = ?1")
    Entrenador findEntrById(Integer idEntrenador);

    @Query("SELECT e FROM Entrenador e WHERE lower(e.nombeEntrenador) LIKE lower(?1)")
    List<Entrenador> findEntrByNombre(String nombre);

    @Query("SELECT e FROM Entrenador e WHERE e.equipoEntr = ?1")
    List<Entrenador> findEntrByEquipo(String equipo);

    @Query("SELECT e FROM Entrenador e WHERE e.trayectoriaEntr LIKE %?1%")
    List<Entrenador> findEntrByEquipoTrayectoria(String nombre);

    @Query("SELECT e FROM Entrenador e WHERE e.edadEntr > ?1")
    List<Entrenador> findEntrByEdad(Integer edad);

    @Query("SELECT e FROM Entrenador e WHERE e.anosNbaEntr > ?1")
    List<Entrenador> findEntrByAnosNba(Integer anosNba);

    @Query("SELECT e FROM Entrenador e WHERE e.anosOtrasLigasEntr > ?1")
    List<Entrenador> findEntrByAnosOtrasLigas(Integer anosOtrasLigas);

    @Query("SELECT e FROM Entrenador e WHERE e.aSidoJugador = ?1")
    List<Entrenador> findByASidoJugador(Boolean aSidoJugador);

    @Query("SELECT e FROM Equipo e JOIN e.entrenadores j WHERE j.nombeEntrenador = ?1")
    Equipo findEquipoByEntrenador(String e);

    @Query("SELECT e FROM Entrenador e WHERE e.equipo.id = :equipoId")
    List<Entrenador> findByEquipoId(@Param("equipoId") Integer equipoId);
}
