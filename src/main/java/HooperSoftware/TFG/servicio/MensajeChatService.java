package HooperSoftware.TFG.servicio;

import java.util.List;

import org.springframework.stereotype.Service;

import HooperSoftware.TFG.entidad.MensajeChat;
import HooperSoftware.TFG.repositorio.MensajeChatRepository;

@Service
public class MensajeChatService {

    private final MensajeChatRepository repository;

    public MensajeChatService(
            MensajeChatRepository repository) {

        this.repository = repository;
    }

    public MensajeChat save(
            MensajeChat mensaje) {

        return repository.save(mensaje);
    }

    public List<MensajeChat> findAllMessages() {

        return repository.findAllMessages();
    }
}