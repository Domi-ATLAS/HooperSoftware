package HooperSoftware.TFG.servicio;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import HooperSoftware.TFG.entidad.Equipo;
import HooperSoftware.TFG.entidad.Playoff;
import HooperSoftware.TFG.repositorio.PlayoffRepository;

@Service
public class PlayoffService {

    PlayoffRepository repository;

    PlayoffService(PlayoffRepository repo){
        this.repository = repo;
    }

    @Transactional(readOnly = true)
    public List<Playoff> findAll(){
        return repository.findAll();
    }

    @Transactional(readOnly = true)
    public Playoff findPlayoffById(Integer idPlayoff){
        return repository.findPlayOffById(idPlayoff);
    }

    @Transactional(readOnly = true)
    public Playoff findPlayoffByTemporada(String temporada){
        return repository.findPlayOffByTemporada(temporada);
    }
    
    @Transactional(readOnly = true)
    public Playoff save (Playoff playoff){
        return repository.save(playoff);
    }

    @Transactional
    public void deletePlayoff(Integer id){
        repository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public List<Equipo> findEquiposByPlayOffs(String temporada) {
        return repository.findEquiposByPlayOffs(temporada);
    }
    
}
