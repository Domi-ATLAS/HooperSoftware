package HooperSoftware.TFG.servicio;


import HooperSoftware.TFG.entidad.Jugador;
import HooperSoftware.TFG.entidad.Transferencia;
import HooperSoftware.TFG.repositorio.TransferenciaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TransferenciaService {

    private final TransferenciaRepository transferenciaRepository;

    @Autowired
    public TransferenciaService(TransferenciaRepository transferenciaRepository) {
        this.transferenciaRepository = transferenciaRepository;
    }

    public List<Jugador> getJugadoresTransferencia(Integer idTransferencia) {
        Transferencia transferencia = transferenciaRepository.findTransferenciaById(idTransferencia);
        if (transferencia != null) {
            return transferencia.getJugadores();
        }
        return null;
    }
}
