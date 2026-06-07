package HooperSoftware.TFG.dto;

import java.util.List;

import lombok.Getter;

@Getter
public class DynastyResultDTO {

    private String equipo;
    private String siglas;

    private List<String> temporadas;

    private Integer titulos;
    private Integer victoriasTotales;

    private Integer dynastyScore;

    public DynastyResultDTO(
            String equipo,
            String siglas,
            List<String> temporadas,
            Integer titulos,
            Integer victoriasTotales,
            Integer dynastyScore) {

        this.equipo = equipo;
        this.siglas = siglas;
        this.temporadas = temporadas;
        this.titulos = titulos;
        this.victoriasTotales = victoriasTotales;
        this.dynastyScore = dynastyScore;
    }

    // getters
}