package HooperSoftware.TFG.servicio;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import HooperSoftware.TFG.entidad.Jugador;
import HooperSoftware.TFG.entidad.Partido;
import HooperSoftware.TFG.repositorio.PartidoRepository;

@Service
public class PartidoService {

    PartidoRepository  repository;

    PartidoService(PartidoRepository repo){
        this.repository = repo;
    }

    @Transactional(readOnly = true)
    public List<Partido> findAll(){
        return repository.findAll();
    }

    @Transactional(readOnly = true)
    public Partido findPartidoById(Integer idPartido){
        return repository.findPartidoById(idPartido);
    }
    
    @Transactional(readOnly = true)
    public Partido save (Partido partido){
        return repository.save(partido);
    }

    @Transactional
    public void deletePartido(Integer id){
        repository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public List<Partido> findPlayOff24(){
        return repository.findPartidosPlayOff2024();
    }
    
    @Transactional(readOnly = true)
    public List<Partido> findPlayOff23(){
        return repository.findPartidosPlayOff2023();
    }

    @Transactional(readOnly = true)
    public List<Partido> findAllPlayOffGames(){
        return repository.findAllPlayOffGames();
    }

    @Transactional(readOnly = true)
    public List<Partido> findSeriesPartidos(String equipoLocal, String equipoVisitante, String temporadaPlayoff) {
        return repository.findSeriePartidoRepo(equipoLocal, equipoVisitante, temporadaPlayoff);
    }

    @Transactional(readOnly = true)
    public List<Jugador> findLocalTeamPlayersByPartidoId(Integer id){
        return repository.findLocalTeamPlayersByPartidoId(id);
    }

    @Transactional(readOnly = true)
    public List<Jugador> findVisitTeamPlayersByPartidoId(Integer id){
        return repository.findVisitTeamPlayersByPartidoId(id);
    }

    @Transactional(readOnly = true)
    public List<Partido> findLast10Games(String nombreEquipo){
        return repository.findLast10MatchesByTeam(nombreEquipo);
    }

    public Object findPlayOffGamesByTemporada(String temporada) {
        return repository.findPlayOffGamesByTemporada(temporada);
    }


}
