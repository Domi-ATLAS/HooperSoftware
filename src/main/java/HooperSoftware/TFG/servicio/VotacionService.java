package HooperSoftware.TFG.servicio;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import HooperSoftware.TFG.entidad.Categoria;
import HooperSoftware.TFG.entidad.Votacion;
import HooperSoftware.TFG.repositorio.VotacionRepository;


@Service
public class VotacionService {

    private final VotacionRepository repository;

    public VotacionService(VotacionRepository repo){
        this.repository = repo;
    }

    @Transactional(readOnly = true)
    public Votacion findVotacionById(Integer idVotacion){
        return repository.findVotacionById(idVotacion);
    }

    @Transactional(readOnly = true)
    public List<Votacion> findAll(){
        return repository.findAll();
    }

    @Transactional(readOnly = true)
    public Votacion save (Votacion votacion){
        return repository.save(votacion);
    }

    @Transactional
    public void deleteVotacion(Integer id){
        repository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public List<Votacion> findVotacionesEnCurso(){
        return repository.findVotacionesEnCurso();
    }

    @Transactional(readOnly = true)
    public List<Votacion> findVotacionesOficiales(){
        return repository.findVotacionesOficiales();
    }

    @Transactional(readOnly = true)
    public List<Categoria> findAllCategorias(){
        return List.of(Categoria.values()); 
    }

    @Transactional(readOnly = true)
    public Integer findNextId() {
        return repository.findAll().stream()
                .map(Votacion::getIdVotacion)
                .max(Integer::compareTo)
                .orElse(0) + 1;
    }
    
}
