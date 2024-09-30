package HooperSoftware.TFG.repositorio;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.Transferencia;

@Repository
public interface TransferenciaRepository extends CrudRepository<Transferencia,Integer>{
    
    @Query("SELECT t FROM Transferencia t")
    List<Transferencia> findAll();

    @Query("SELECT t FROM Transferencia t WHERE t.idTransferencia = ?1")
    Transferencia findTransferenciaById(Integer idTransferencia);

    @Query("SELECT t FROM Transferencia t WHERE t.precio >= ?1")
    List<Transferencia> findTransferenciaByPrecio(Integer precio);

    @Query("SELECT t FROM Transferencia t WHERE t.rondaDraft = true")
    List<Transferencia> findTransferenciaByRondaDraft();

    @Query("SELECT t FROM Transferencia t WHERE t.fecha = ?1")
    List<Transferencia> findTransferenciaByFecha(LocalDate fecha);

    @Query("SELECT t FROM Transferencia t WHERE t.equipoOrigen = ?1")
    List<Transferencia> findTransferenciaByEquipoOrigen(String equipoOrigen);

    @Query("SELECT t FROM Transferencia t WHERE t.equipoDestino = ?1")
    List<Transferencia> findTransferenciaByEquipoDestino(String equipoDestino);

    @Query("SELECT t FROM Transferencia t WHERE t.equipoOrigen.idEquipo = ?1 OR t.equipoDestino.idEquipo = ?1")
    List<Transferencia> findAllTransferencesByTeamById(Integer teamId);


}
