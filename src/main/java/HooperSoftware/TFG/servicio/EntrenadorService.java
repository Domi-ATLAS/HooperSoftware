package HooperSoftware.TFG.servicio;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import HooperSoftware.TFG.entidad.Entrenador;
import HooperSoftware.TFG.entidad.Equipo;
import HooperSoftware.TFG.repositorio.EntrenadorRepository;

@Service
public class EntrenadorService {

    EntrenadorRepository repository;

    EntrenadorService(EntrenadorRepository repo) {
        this.repository = repo;
    }

    @Transactional(readOnly = true)
    public List<Entrenador> findAll() {
        return repository.findAll();
    }

    @Transactional(readOnly = true)
    public Entrenador findEntrById(Integer idEntrenador) {
        return repository.findEntrById(idEntrenador);
    }

    @Transactional(readOnly = true)
    public Entrenador save(Entrenador entrenador) {
        return repository.save(entrenador);
    }

    @Transactional
    public void deleteEntrenador(Integer id) {
        repository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public Equipo findEquipoByEntrenador(String nombre) {
        return repository.findEquipoByEntrenador(nombre);
    }

    @Transactional(readOnly = true)
    public List<Entrenador> findByEquipoEntr(Integer equipoId) {
        return repository.findByEquipoId(equipoId);
    }

    public List<Entrenador> findEntrByEquipoTrayectoria(String trim) {
        return repository.findEntrByEquipoTrayectoria(trim);
    }

    public List<Entrenador> findEntrByNombre(String trim) {
        return repository.findEntrByNombre(trim);
    }
}
