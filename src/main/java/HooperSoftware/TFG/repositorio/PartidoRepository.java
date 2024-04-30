package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.Partido;

@Repository
public interface PartidoRepository extends CrudRepository<Partido,Integer> {

    @Query("SELECT p FROM Partido p")
    List<Partido> findAll();

    @Query("SELECT p FROM Partido p WHERE p.idPartido = ?1")
    Partido findPartidoById(Integer idPartido);
    
    @Query("SELECT p FROM Partido p WHERE p.playoff.idPlayOff = ?1")
    List<Partido> findPartidoByIdPlayOff(Integer idPlayOff);

    @Query("SELECT p FROM Partido p WHERE p.equipoLocal = ?1 AND p.equipoVisitante = ?2")
    List<Partido> findPartidoByEquipoLocalAndEquipoVisitante(String equipoLocal, String equipoVisitante);

    @Query("SELECT p FROM Partido p WHERE p.equipoLocal = ?1")
    List<Partido> findPartidoByEquipoLocal(String equipoLocal);

    @Query("SELECT p FROM Partido p WHERE p.equipoVisitante = ?1")
    List<Partido> findPartidoByEquipoVisitante(String equipoVisitante);

    @Query("SELECT p FROM Partido p WHERE p.playoff = ?1 AND p.victoriaSerie = ?2")
    List<Partido> findPartidoByVictoriaSerie(Integer idPlayOff, String victoriaSerie);

    @Query("SELECT p FROM Partido p WHERE p.playoff = ?1 AND p.equipoLocal = ?2")
    List<Partido> findPartidoByVictoriaSerieAndEquipoLocal(Integer idPlayOff, String equipoLocal);

    @Query("SELECT p FROM Partido p WHERE p.playoff = ?1 AND p.equipoVisitante = ?2")
    List<Partido> findPartidoByVictoriaSerieAndEquipoVisitante(Integer idPlayOff, String equipoVisitante);

    @Query("SELECT p FROM Partido p WHERE p.equipoLocal = ?1 AND p.equipoVisitante = ?2 AND p.playOffSiONo = True ")
    List<Partido> findPartidoByVictoriaSerieAndEquipoLocalAndEquipoVisitante(String equipoLocal, String equipoVisitante);
    
    @Query("SELECT p FROM Partido p WHERE p.playOffSiONo = true AND p.playoff.temporada = '2023-2024'")
    List<Partido> findPartidosPlayOff2024();

    @Query("SELECT p FROM Partido p WHERE p.playOffSiONo = true AND p.playoff.temporada = '2022-2023'")
    List<Partido> findPartidosPlayOff2023();

    @Query("SELECT p FROM Partido p WHERE p.playOffSiONo = true")
    List<Partido> findAllPlayOffGames();
}
