package HooperSoftware.TFG.dto;

import java.util.List;

public class LineupAnalysisDTO {

    private final String resumen;
    private final int ratingOfensivo;
    private final int spacing;
    private final int defensa;
    private final int equilibrio;
    private final List<LineupPickDTO> seleccionados;
    private final List<LineupRecommendationDTO> mejoresCompaneros;
    private final List<LineupRecommendationDTO> rivalesFavorables;
    private final List<TeamFitDTO> encajeEquipos;
    private final List<SlotSuggestionDTO> sugerenciasCasillas;

    public LineupAnalysisDTO(
            String resumen,
            int ratingOfensivo,
            int spacing,
            int defensa,
            int equilibrio,
            List<LineupPickDTO> seleccionados,
            List<LineupRecommendationDTO> mejoresCompaneros,
            List<LineupRecommendationDTO> rivalesFavorables,
            List<TeamFitDTO> encajeEquipos,
            List<SlotSuggestionDTO> sugerenciasCasillas) {
        this.resumen = resumen;
        this.ratingOfensivo = ratingOfensivo;
        this.spacing = spacing;
        this.defensa = defensa;
        this.equilibrio = equilibrio;
        this.seleccionados = seleccionados;
        this.mejoresCompaneros = mejoresCompaneros;
        this.rivalesFavorables = rivalesFavorables;
        this.encajeEquipos = encajeEquipos;
        this.sugerenciasCasillas = sugerenciasCasillas;
    }

    public String getResumen() {
        return resumen;
    }

    public int getRatingOfensivo() {
        return ratingOfensivo;
    }

    public int getSpacing() {
        return spacing;
    }

    public int getDefensa() {
        return defensa;
    }

    public int getEquilibrio() {
        return equilibrio;
    }

    public List<LineupPickDTO> getSeleccionados() {
        return seleccionados;
    }

    public List<LineupRecommendationDTO> getMejoresCompaneros() {
        return mejoresCompaneros;
    }

    public List<LineupRecommendationDTO> getRivalesFavorables() {
        return rivalesFavorables;
    }

    public List<TeamFitDTO> getEncajeEquipos() {
        return encajeEquipos;
    }

    public List<SlotSuggestionDTO> getSugerenciasCasillas() {
        return sugerenciasCasillas;
    }

    public static class LineupPickDTO {

        private final String slot;
        private final String jugador;
        private final String equipo;
        private final String posicion;
        private final int rating;
        private final int tiroEstimado;

        public LineupPickDTO(
                String slot,
                String jugador,
                String equipo,
                String posicion,
                int rating,
                int tiroEstimado) {
            this.slot = slot;
            this.jugador = jugador;
            this.equipo = equipo;
            this.posicion = posicion;
            this.rating = rating;
            this.tiroEstimado = tiroEstimado;
        }

        public String getSlot() {
            return slot;
        }

        public String getJugador() {
            return jugador;
        }

        public String getEquipo() {
            return equipo;
        }

        public String getPosicion() {
            return posicion;
        }

        public int getRating() {
            return rating;
        }

        public int getTiroEstimado() {
            return tiroEstimado;
        }
    }

    public static class LineupRecommendationDTO {

        private final String jugador;
        private final String equipo;
        private final String posicion;
        private final int porcentaje;
        private final String motivo;

        public LineupRecommendationDTO(
                String jugador,
                String equipo,
                String posicion,
                int porcentaje,
                String motivo) {
            this.jugador = jugador;
            this.equipo = equipo;
            this.posicion = posicion;
            this.porcentaje = porcentaje;
            this.motivo = motivo;
        }

        public String getJugador() {
            return jugador;
        }

        public String getEquipo() {
            return equipo;
        }

        public String getPosicion() {
            return posicion;
        }

        public int getPorcentaje() {
            return porcentaje;
        }

        public String getMotivo() {
            return motivo;
        }
    }

    public static class TeamFitDTO {

        private final String equipo;
        private final String siglas;
        private final int encaje;
        private final String motivo;

        public TeamFitDTO(String equipo, String siglas, int encaje, String motivo) {
            this.equipo = equipo;
            this.siglas = siglas;
            this.encaje = encaje;
            this.motivo = motivo;
        }

        public String getEquipo() {
            return equipo;
        }

        public String getSiglas() {
            return siglas;
        }

        public int getEncaje() {
            return encaje;
        }

        public String getMotivo() {
            return motivo;
        }
    }

    public static class SlotSuggestionDTO {

        private final String slot;
        private final Integer jugadorId;
        private final String jugador;
        private final String equipo;
        private final int encaje;
        private final String motivo;

        public SlotSuggestionDTO(String slot, Integer jugadorId, String jugador, String equipo, int encaje, String motivo) {
            this.slot = slot;
            this.jugadorId = jugadorId;
            this.jugador = jugador;
            this.equipo = equipo;
            this.encaje = encaje;
            this.motivo = motivo;
        }

        public String getSlot() {
            return slot;
        }

        public Integer getJugadorId() {
            return jugadorId;
        }

        public String getJugador() {
            return jugador;
        }

        public String getEquipo() {
            return equipo;
        }

        public int getEncaje() {
            return encaje;
        }

        public String getMotivo() {
            return motivo;
        }
    }
}
