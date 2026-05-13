package HooperSoftware.TFG.dto;

import HooperSoftware.TFG.entidad.Equipo;

public class SeriesResultDTO {

    private Equipo ganador;
    private int winsA;
    private int winsB;

    public SeriesResultDTO(Equipo ganador, int winsA, int winsB) {
        this.ganador = ganador;
        this.winsA = winsA;
        this.winsB = winsB;
    }

    public Equipo getGanador() {
        return ganador;
    }

    public int getWinsA() {
        return winsA;
    }

    public int getWinsB() {
        return winsB;
    }
}