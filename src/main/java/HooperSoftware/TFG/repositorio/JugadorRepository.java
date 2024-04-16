package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.Jugador;

@Repository
public interface JugadorRepository extends CrudRepository<Jugador,Integer>{
    
    @Query("SELECT j FROM Jugador j")
    List<Jugador> findAll();

    @Query("SELECT j FROM Jugador j WHERE j.idJugador = ?1")
    Jugador findJugadorById(Integer idJugador);

    @Query("SELECT j FROM Jugador j WHERE j.nombreJugador LIKE ?1")
    List<Jugador> findJugadorByNombre(String nombre);

    @Query("SELECT j FROM Jugador j WHERE j.posicion = ?1")
    List<Jugador> findJugadorByPosicion(String posicion);

    @Query("SELECT j FROM Jugador j WHERE j.dorsal = ?1")
    List<Jugador> findJugadorByDorsal(Integer dorsal);

    @Query("SELECT j FROM Jugador j WHERE j.anoDraft = ?1")
    List<Jugador> findJugadorByAnoDraft(Integer anoDraft);

    @Query("SELECT j FROM Jugador j WHERE j.edadJug >= ?1")
    List<Jugador> findJugadorByEdadJugGreaterThan(Integer edadJug);

    @Query("SELECT j FROM Jugador j WHERE j.edadJug <= ?1")
    List<Jugador> findJugadorByEdadJugLessThan(Integer edadJug);

    @Query("SELECT j FROM Jugador j WHERE j.anosAllStarJug >= ?1")
    List<Jugador> findJugadorByAnosAllStarJugGreaterThan(Integer anosAllStarJug);

    @Query("SELECT j FROM Jugador j WHERE j.anosAllStarJug <= ?1")
    List<Jugador> findJugadorByAnosAllStarJugLessThan(Integer anosAllStarJug);

    @Query("SELECT j FROM Jugador j WHERE j.anosNbaJug >= ?1")
    List<Jugador> findJugadorByAnosNbaJugGreaterThan(Integer anosNbaJug);

    @Query("SELECT j FROM Jugador j WHERE j.anosNbaJug <= ?1")
    List<Jugador> findJugadorByAnosNbaJugLessThan(Integer anosNbaJug);

    @Query("SELECT j FROM Jugador j WHERE j.anosOtraLigaJug >= ?1")
    List<Jugador> findJugadorByAnosOtraLigaJugGreaterThan(Integer anosOtraLigaJug);

    @Query("SELECT j FROM Jugador j WHERE j.anosOtraLigaJug <= ?1")
    List<Jugador> findJugadorByAnosOtraLigaJugLessThan(Integer anosOtraLigaJug);

    @Query("SELECT j FROM Jugador j WHERE j.trayectoriaJug LIKE ?1")
    List<Jugador> findJugadorByTrayectoriaJug(String trayectoriaJug);



}
