package HooperSoftware.TFG.servicio;


import HooperSoftware.TFG.entidad.Jugador;
import HooperSoftware.TFG.entidad.Transferencia;
import HooperSoftware.TFG.repositorio.TransferenciaRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class TransferenciaService {

    private final TransferenciaRepository transferenciaRepository;

    public TransferenciaService(TransferenciaRepository transferenciaRepository) {
        this.transferenciaRepository = transferenciaRepository;
    }

    @Transactional(readOnly = true)
    public List<Transferencia> findAll() {
        return transferenciaRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Transferencia findTransferenciaById(Integer idTransferencia) {
        return transferenciaRepository.findTransferenciaById(idTransferencia);
    }

    @Transactional(readOnly = true)
    public Transferencia save (Transferencia transferencia){
        return transferenciaRepository.save(transferencia);
    }

    @Transactional
    public void deleteTransferencia(Integer id){
        transferenciaRepository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public List<Jugador> getJugadoresTransferencia(Integer idTransferencia) {
        Transferencia transferencia = transferenciaRepository.findTransferenciaById(idTransferencia);
        if (transferencia != null) {
            return transferencia.getJugadores();
        }
        return null;
    }

    @Transactional(readOnly = true)
    public List<Transferencia> findAllTransferencesByTeamById(Integer teamId) {
        return transferenciaRepository.findAllTransferencesByTeamById(teamId);
    }
}
