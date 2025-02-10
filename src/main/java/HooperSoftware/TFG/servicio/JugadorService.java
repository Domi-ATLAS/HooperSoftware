package HooperSoftware.TFG.servicio;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import HooperSoftware.TFG.entidad.Equipo;
import HooperSoftware.TFG.entidad.Jugador;
import HooperSoftware.TFG.repositorio.JugadorRepository;

@Service
public class JugadorService {

    JugadorRepository repository;

    JugadorService(JugadorRepository repo){
        this.repository = repo;
    }

    @Transactional(readOnly = true)
    public List<Jugador> findAll(){
        return repository.findAll();
    }

    @Transactional(readOnly = true)
    public Jugador findJugadorById(Integer idJugador){
        return repository.findJugadorById(idJugador);
    }

    @Transactional(readOnly = true)
    public Jugador save (Jugador jugador){
        return repository.save(jugador);
    }

    @Transactional
    public void deleteJugador(Integer id){
        repository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public Equipo findEquipoByJugador(String nombre){
        return repository.findEquipoByNombreJugador(nombre);
    }

    @Transactional(readOnly = true)
    public List<Jugador> findJugadorByNombre(String nombre){
        return repository.findJugadorByNombre(nombre);
    }
    
}
