package HooperSoftware.TFG.servicio;

public class WinsPredictionDTO {

    private int winsAntes;
    private int winsDespues;
    private int diferencia;

    private String tierAntes;
    private String tierDespues;

    private String mensajeIA;

    public WinsPredictionDTO(
            int winsAntes,
            int winsDespues,
            int diferencia,
            String tierAntes,
            String tierDespues,
            String mensajeIA) {

        this.winsAntes = winsAntes;
        this.winsDespues = winsDespues;
        this.diferencia = diferencia;
        this.tierAntes = tierAntes;
        this.tierDespues = tierDespues;
        this.mensajeIA = mensajeIA;
    }

    public int getWinsAntes() { return winsAntes; }
    public int getWinsDespues() { return winsDespues; }
    public int getDiferencia() { return diferencia; }

    public String getTierAntes() { return tierAntes; }
    public String getTierDespues() { return tierDespues; }

    public String getMensajeIA() { return mensajeIA; }
}