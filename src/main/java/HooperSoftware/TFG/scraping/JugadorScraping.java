package HooperSoftware.TFG.scraping;

import HooperSoftware.TFG.entidad.EstadisticasJugador;
import HooperSoftware.TFG.entidad.Jugador;
import HooperSoftware.TFG.repositorio.EstadisticasJugadorRepository;
import HooperSoftware.TFG.repositorio.JugadorRepository;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
public class JugadorScraping {

    @Autowired
    private JugadorRepository jugadorRepository;

    @Autowired
    private EstadisticasJugadorRepository estadisticasJugadorRepository;

    public List<Jugador> realizarScraping() throws IOException {
        String baseUrl = "https://www.basketball-reference.com/players/";
        List<Jugador> jugadores = new ArrayList<>();

        for (char letra = 'a'; letra <= 'z'; letra++) {
            String url = baseUrl + letra + "/";
            Document doc = Jsoup.connect(url).get();

            // Selector para los elementos que contienen los links a los jugadores
            Elements elementosJugadores = doc.select("table tbody tr th a");

            for (Element element : elementosJugadores) {
                String jugadorUrl = "https://www.basketball-reference.com" + element.attr("href");

                // Realizar scraping de cada jugador
                Jugador jugador = scrapeJugador(jugadorUrl);

                if (jugador != null) {
                    // Guardar el jugador en la base de datos
                    jugadorRepository.save(jugador);
                    jugadores.add(jugador);
                }
            }
        }
        return jugadores;
    }

    private Jugador scrapeJugador(String jugadorUrl) throws IOException {
        Document doc = Jsoup.connect(jugadorUrl).get();

        // Parsear los datos de cada jugador desde el HTML
        String nombreJugador = doc.select("h1[itemprop=name]").first().text();
        String posicion = doc.select("strong:contains(Position) + p").first().text();
        Integer dorsal = Integer.parseInt(doc.select("strong:contains(Jersey Number) + p").first().text());
        String trayectoriaJug = doc.select("strong:contains(Teams) + p").first().text();
        Integer anoDraft = Integer.parseInt(doc.select("strong:contains(Drafted) + p").first().text());
        Integer edadJug = Integer.parseInt(doc.select("strong:contains(Age) + p").first().text());

        // Crear un nuevo objeto Jugador
        Jugador jugador = new Jugador();
        jugador.setNombreJugador(nombreJugador);
        jugador.setPosicion(posicion);
        jugador.setDorsal(dorsal);
        jugador.setTrayectoriaJug(trayectoriaJug);
        jugador.setAnoDraft(anoDraft);
        jugador.setEdadJug(edadJug);

        // Establecer estadísticas del jugador
        EstadisticasJugador estadisticasJugador = scrapeEstadisticasJugador(jugadorUrl);
        jugador.setEstadisticasJug(estadisticasJugador);

        return jugador;
    }

    private EstadisticasJugador scrapeEstadisticasJugador(String jugadorUrl) throws IOException {
        // Implementa aquí la lógica para scrapear las estadísticas de jugador
        // Puedes usar doc.select() y otros métodos de JSoup según la estructura de la página
        // Ejemplo básico:
        EstadisticasJugador estadisticasJugador = new EstadisticasJugador();
        // Lógica para obtener y setear las estadísticas
        return estadisticasJugador;
    }
}
