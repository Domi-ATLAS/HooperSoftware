package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import HooperSoftware.TFG.entidad.MensajeChat;

public interface MensajeChatRepository
        extends CrudRepository<MensajeChat,Integer>{

    @Query("""
           SELECT m
           FROM MensajeChat m
           ORDER BY m.fecha DESC
           """)
    List<MensajeChat> findAllMessages();
}