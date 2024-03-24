package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.Jugador;

@Repository
public interface JugadorRepository extends CrudRepository<Jugador,Integer>{
    
    List<Jugador> findAll();

}
