package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.Jornada;

@Repository
public interface JornadaRepository extends CrudRepository<Jornada,Integer>{
    
    @Query("SELECT j FROM Jornada j")
    List<Jornada> findAll();

    @Query("SELECT j FROM Jornada j WHERE j.idJornada = ?1")
    Jornada findJornadaById(Integer idJornada);

    @Query("SELECT j FROM Jornada j WHERE j.numJornada = ?1")
    List<Jornada> findJornadaByNumJornada(Integer numJornada);

    @Query("SELECT j FROM Jornada j WHERE j.numJornada >= ?1")
    List<Jornada> findJornadaByNumJornadaGreaterThan(Integer numJornada);

    @Query("SELECT j FROM Jornada j WHERE j.numJornada <= ?1")
    List<Jornada> findJornadaByNumJornadaLessThan(Integer numJornada);

    @Query("SELECT j FROM Jornada j WHERE j.numeroPartido = ?1")
    List<Jornada> findJornadaByNumeroPartido(Integer numeroPartido);

    @Query("SELECT j FROM Jornada j WHERE j.numJornada = ?1 AND j.partidoCancelado = true")
    List<Jornada> findJornadaByNumJornadaAndCancelado(Integer numJornada);

    @Query("SELECT j FROM Jornada j WHERE j.numJornada = ?1 AND j.partidoCancelado = false")
    List<Jornada> findJornadaByNumJornadaAndNoCancelado(Integer numJornada);

    @Query("SELECT j FROM Jornada j WHERE j.temporada = ?1 ")
    List<Jornada> findJornadaByTemporada(String temporada);

    @Query("SELECT j FROM Jornada j WHERE j.temporada = ?1 AND j.numJornada = ?2")
    List<Jornada> findJornadaByTemporadaAndNumJornada(String temporada, Integer numJornada);

    @Query("SELECT j FROM Jornada j WHERE j.temporada = ?1 AND j.numeroPartido >= ?2")
    List<Jornada> findJornadaByTemporadaAndNumeroPartidoGreaterThan(String temporada, Integer numeroPartido);

    @Query("SELECT j FROM Jornada j WHERE j.temporada = ?1 AND j.numeroPartido <= ?2")
    List<Jornada> findJornadaByTemporadaAndNumeroPartidoLessThan(String temporada, Integer numeroPartido);

    @Query("SELECT j FROM Jornada j WHERE j.temporada = ?1 AND j.numJornada >= ?2")
    List<Jornada> findJornadaByTemporadaAndNumJornadaGreaterThan(String temporada, Integer numJornada);

    @Query("SELECT j FROM Jornada j WHERE j.temporada = ?1 AND j.numJornada <= ?2")
    List<Jornada> findJornadaByTemporadaAndNumJornadaLessThan(String temporada, Integer numJornada);

    @Query("SELECT j FROM Jornada j WHERE j.temporada = ?1 AND j.numJornada = ?2 AND j.partidoCancelado = true")
    List<Jornada> findJornadaByTemporadaAndNumJornadaAndCancelado(String temporada, Integer numJornada);

    @Query("SELECT j FROM Jornada j WHERE j.temporada = ?1 AND j.numJornada = ?2 AND j.partidoCancelado = false")
    List<Jornada> findJornadaByTemporadaAndNumJornadaAndNoCancelado(String temporada, Integer numJornada);

    


}
