package HooperSoftware.TFG.dto;

import java.util.ArrayList;
import java.util.List;

public class ComparativaScenarioDTO {

    private String titulo;
    private String temporada;
    private String equipoReferencia;
    private int jugadores;
    private double ratingReferencia;
    private double ratingSimulado;
    private int victoriasReferencia;
    private int victoriasSimuladas;
    private int diferenciaVictorias;
    private int puntosReferencia;
    private int puntosSimulados;
    private int defensaReferencia;
    private int defensaSimulada;
    private String resumen;
    private List<String> jugadoresSeleccionados = new ArrayList<>();

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getTemporada() {
        return temporada;
    }

    public void setTemporada(String temporada) {
        this.temporada = temporada;
    }

    public String getEquipoReferencia() {
        return equipoReferencia;
    }

    public void setEquipoReferencia(String equipoReferencia) {
        this.equipoReferencia = equipoReferencia;
    }

    public int getJugadores() {
        return jugadores;
    }

    public void setJugadores(int jugadores) {
        this.jugadores = jugadores;
    }

    public double getRatingReferencia() {
        return ratingReferencia;
    }

    public void setRatingReferencia(double ratingReferencia) {
        this.ratingReferencia = ratingReferencia;
    }

    public double getRatingSimulado() {
        return ratingSimulado;
    }

    public void setRatingSimulado(double ratingSimulado) {
        this.ratingSimulado = ratingSimulado;
    }

    public int getVictoriasReferencia() {
        return victoriasReferencia;
    }

    public void setVictoriasReferencia(int victoriasReferencia) {
        this.victoriasReferencia = victoriasReferencia;
    }

    public int getVictoriasSimuladas() {
        return victoriasSimuladas;
    }

    public void setVictoriasSimuladas(int victoriasSimuladas) {
        this.victoriasSimuladas = victoriasSimuladas;
    }

    public int getDiferenciaVictorias() {
        return diferenciaVictorias;
    }

    public void setDiferenciaVictorias(int diferenciaVictorias) {
        this.diferenciaVictorias = diferenciaVictorias;
    }

    public int getPuntosReferencia() {
        return puntosReferencia;
    }

    public void setPuntosReferencia(int puntosReferencia) {
        this.puntosReferencia = puntosReferencia;
    }

    public int getPuntosSimulados() {
        return puntosSimulados;
    }

    public void setPuntosSimulados(int puntosSimulados) {
        this.puntosSimulados = puntosSimulados;
    }

    public int getDefensaReferencia() {
        return defensaReferencia;
    }

    public void setDefensaReferencia(int defensaReferencia) {
        this.defensaReferencia = defensaReferencia;
    }

    public int getDefensaSimulada() {
        return defensaSimulada;
    }

    public void setDefensaSimulada(int defensaSimulada) {
        this.defensaSimulada = defensaSimulada;
    }

    public String getResumen() {
        return resumen;
    }

    public void setResumen(String resumen) {
        this.resumen = resumen;
    }

    public List<String> getJugadoresSeleccionados() {
        return jugadoresSeleccionados;
    }

    public void setJugadoresSeleccionados(List<String> jugadoresSeleccionados) {
        this.jugadoresSeleccionados = jugadoresSeleccionados;
    }
}
