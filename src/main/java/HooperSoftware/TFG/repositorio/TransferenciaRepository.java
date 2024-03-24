package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.Transferencia;

@Repository
public interface TransferenciaRepository extends CrudRepository<Transferencia,Integer>{
    
    List<Transferencia> findAll();

}
