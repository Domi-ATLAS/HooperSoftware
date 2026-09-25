package HooperSoftware.TFG.servicio;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import HooperSoftware.TFG.entidad.VotoUsuario;
import HooperSoftware.TFG.repositorio.VotoUsuarioRepository;

@Service
public class VotoUsuarioService {

    private final VotoUsuarioRepository repository;

    public VotoUsuarioService(
            VotoUsuarioRepository repository) {

        this.repository = repository;
    }

    public VotoUsuario save(
            VotoUsuario voto) {

        return repository.save(voto);
    }

    public boolean yaHaVotado(
            String username,
            Integer idVotacion) {

        return repository.findVotoUsuario(
                username,
                idVotacion) != null;
    }

    @Transactional(readOnly = true)
    public List<Object[]> contarVotosPorOpcion(Integer idVotacion) {
        return repository.contarVotosPorOpcion(idVotacion);
    }

    @Transactional(readOnly = true)
    public List<VotoUsuario> findByUsername(String username) {
        return repository.findByUsername(username);
    }
}
