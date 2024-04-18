package HooperSoftware.TFG.servicio;


import HooperSoftware.TFG.entidad.Jornada;
import HooperSoftware.TFG.entidad.Partido;
import HooperSoftware.TFG.repositorio.JornadaRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class JornadaService {

    private final JornadaRepository jornadaRepository;

    public JornadaService(JornadaRepository jornadaRepository) {
        this.jornadaRepository = jornadaRepository;
    }

    @Transactional(readOnly = true)
    public List<Partido> getPartidosJornada(Integer idJornada) {
        Jornada jornada = jornadaRepository.findById(idJornada).orElse(null);
        if (jornada != null) {
            return jornada.getPartidos();
        }
        return null;
    }

    @Transactional(readOnly = true)
    public List<Jornada> findAll() {
        return jornadaRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Jornada findJornadaById(Integer idJornada) {
        return jornadaRepository.findById(idJornada).orElse(null);
    }

    @Transactional(readOnly = true)
    public Jornada save (Jornada jornada){
        return jornadaRepository.save(jornada);
    }

    @Transactional
    public void deleteJornada(Integer id){
        jornadaRepository.deleteById(id);
    }

}