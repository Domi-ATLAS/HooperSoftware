package HooperSoftware.TFG.servicio;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import HooperSoftware.TFG.entidad.Equipo;
import HooperSoftware.TFG.repositorio.EquipoRepository;

@Service
public class EquipoService {

    EquipoRepository repository;

    EquipoService(EquipoRepository repo){
        this.repository = repo;
    }

    @Transactional(readOnly = true)
    public List<Equipo> findAll(){
        return repository.findAll();
    }

    @Transactional(readOnly = true)
    public Equipo findEquipoById(Integer idEquipo){
        return repository.findEquipoById(idEquipo);
    }
    
    @Transactional(readOnly = true)
    public Equipo save (Equipo equipo){
        return repository.save(equipo);
    }

    @Transactional
    public void deleteEquipo(Integer id){
        repository.deleteById(id);
    }

}
