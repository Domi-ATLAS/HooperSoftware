package HooperSoftware.TFG.servicio;


import HooperSoftware.TFG.entidad.Jornada;
import HooperSoftware.TFG.entidad.Partido;
import HooperSoftware.TFG.repositorio.JornadaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class JornadaService {

    private final JornadaRepository jornadaRepository;

    @Autowired
    public JornadaService(JornadaRepository jornadaRepository) {
        this.jornadaRepository = jornadaRepository;
    }

    public List<Partido> getPartidosJornada(Integer idJornada) {
        Jornada jornada = jornadaRepository.findById(idJornada).orElse(null);
        if (jornada != null) {
            return jornada.getPartidos();
        }
        return null;
    }
}