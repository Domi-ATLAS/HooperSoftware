package HooperSoftware.TFG.dto;

import java.util.ArrayList;
import java.util.List;

public class ComparativaDTO {

    private String temporadaA;
    private String temporadaB;
    private SeasonTotals temporadaATotals;
    private SeasonTotals temporadaBTotals;
    private List<ChartRow> chartRows = new ArrayList<>();
    private List<TeamCompareRow> teamRows = new ArrayList<>();
    private List<PlayerCompareRow> playerRows = new ArrayList<>();
    private String resumen;

    public String getTemporadaA() {
        return temporadaA;
    }

    public void setTemporadaA(String temporadaA) {
        this.temporadaA = temporadaA;
    }

    public String getTemporadaB() {
        return temporadaB;
    }

    public void setTemporadaB(String temporadaB) {
        this.temporadaB = temporadaB;
    }

    public SeasonTotals getTemporadaATotals() {
        return temporadaATotals;
    }

    public void setTemporadaATotals(SeasonTotals temporadaATotals) {
        this.temporadaATotals = temporadaATotals;
    }

    public SeasonTotals getTemporadaBTotals() {
        return temporadaBTotals;
    }

    public void setTemporadaBTotals(SeasonTotals temporadaBTotals) {
        this.temporadaBTotals = temporadaBTotals;
    }

    public List<ChartRow> getChartRows() {
        return chartRows;
    }

    public void setChartRows(List<ChartRow> chartRows) {
        this.chartRows = chartRows;
    }

    public List<TeamCompareRow> getTeamRows() {
        return teamRows;
    }

    public void setTeamRows(List<TeamCompareRow> teamRows) {
        this.teamRows = teamRows;
    }

    public List<PlayerCompareRow> getPlayerRows() {
        return playerRows;
    }

    public void setPlayerRows(List<PlayerCompareRow> playerRows) {
        this.playerRows = playerRows;
    }

    public String getResumen() {
        return resumen;
    }

    public void setResumen(String resumen) {
        this.resumen = resumen;
    }

    public static class SeasonTotals {
        private int jugadores;
        private int partidos;
        private int puntos;
        private int asistencias;
        private int rebotes;
        private int robos;
        private int tapones;
        private int triples;
        private double puntosPorJugador;
        private double puntosPorPartido;

        public int getJugadores() {
            return jugadores;
        }

        public void setJugadores(int jugadores) {
            this.jugadores = jugadores;
        }

        public int getPartidos() {
            return partidos;
        }

        public void setPartidos(int partidos) {
            this.partidos = partidos;
        }

        public int getPuntos() {
            return puntos;
        }

        public void setPuntos(int puntos) {
            this.puntos = puntos;
        }

        public int getAsistencias() {
            return asistencias;
        }

        public void setAsistencias(int asistencias) {
            this.asistencias = asistencias;
        }

        public int getRebotes() {
            return rebotes;
        }

        public void setRebotes(int rebotes) {
            this.rebotes = rebotes;
        }

        public int getRobos() {
            return robos;
        }

        public void setRobos(int robos) {
            this.robos = robos;
        }

        public int getTapones() {
            return tapones;
        }

        public void setTapones(int tapones) {
            this.tapones = tapones;
        }

        public int getTriples() {
            return triples;
        }

        public void setTriples(int triples) {
            this.triples = triples;
        }

        public double getPuntosPorJugador() {
            return puntosPorJugador;
        }

        public void setPuntosPorJugador(double puntosPorJugador) {
            this.puntosPorJugador = puntosPorJugador;
        }

        public double getPuntosPorPartido() {
            return puntosPorPartido;
        }

        public void setPuntosPorPartido(double puntosPorPartido) {
            this.puntosPorPartido = puntosPorPartido;
        }
    }

    public static class ChartRow {
        private String label;
        private double valueA;
        private double valueB;
        private String displayA;
        private String displayB;

        public ChartRow(String label, double valueA, double valueB, String displayA, String displayB) {
            this.label = label;
            this.valueA = valueA;
            this.valueB = valueB;
            this.displayA = displayA;
            this.displayB = displayB;
        }

        public String getLabel() {
            return label;
        }

        public double getValueA() {
            return valueA;
        }

        public double getValueB() {
            return valueB;
        }

        public String getDisplayA() {
            return displayA;
        }

        public String getDisplayB() {
            return displayB;
        }
    }

    public static class TeamCompareRow {
        private String equipo;
        private int jugadoresA;
        private int jugadoresB;
        private int puntosA;
        private int puntosB;
        private int partidosA;
        private int partidosB;

        public TeamCompareRow(String equipo, int jugadoresA, int jugadoresB, int puntosA, int puntosB, int partidosA, int partidosB) {
            this.equipo = equipo;
            this.jugadoresA = jugadoresA;
            this.jugadoresB = jugadoresB;
            this.puntosA = puntosA;
            this.puntosB = puntosB;
            this.partidosA = partidosA;
            this.partidosB = partidosB;
        }

        public String getEquipo() {
            return equipo;
        }

        public int getJugadoresA() {
            return jugadoresA;
        }

        public int getJugadoresB() {
            return jugadoresB;
        }

        public int getPuntosA() {
            return puntosA;
        }

        public int getPuntosB() {
            return puntosB;
        }

        public int getPartidosA() {
            return partidosA;
        }

        public int getPartidosB() {
            return partidosB;
        }
    }

    public static class PlayerCompareRow {
        private String jugador;
        private String equipoA;
        private String equipoB;
        private int puntosA;
        private int puntosB;
        private int asistenciasA;
        private int asistenciasB;
        private int rebotesA;
        private int rebotesB;

        public PlayerCompareRow(String jugador, String equipoA, String equipoB, int puntosA, int puntosB,
                                int asistenciasA, int asistenciasB, int rebotesA, int rebotesB) {
            this.jugador = jugador;
            this.equipoA = equipoA;
            this.equipoB = equipoB;
            this.puntosA = puntosA;
            this.puntosB = puntosB;
            this.asistenciasA = asistenciasA;
            this.asistenciasB = asistenciasB;
            this.rebotesA = rebotesA;
            this.rebotesB = rebotesB;
        }

        public String getJugador() {
            return jugador;
        }

        public String getEquipoA() {
            return equipoA;
        }

        public String getEquipoB() {
            return equipoB;
        }

        public int getPuntosA() {
            return puntosA;
        }

        public int getPuntosB() {
            return puntosB;
        }

        public int getAsistenciasA() {
            return asistenciasA;
        }

        public int getAsistenciasB() {
            return asistenciasB;
        }

        public int getRebotesA() {
            return rebotesA;
        }

        public int getRebotesB() {
            return rebotesB;
        }
    }
}
