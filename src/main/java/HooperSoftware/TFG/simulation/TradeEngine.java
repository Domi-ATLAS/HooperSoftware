package HooperSoftware.TFG.simulation;

import HooperSoftware.TFG.entidad.Jugador;

public class TradeEngine {

    public static int calcularScore(Jugador sale, Jugador llega){

        int score = 50;

        // POSICIÓN (química básica)
        if(sale.getPosicion()!=null && llega.getPosicion()!=null){
            if(sale.getPosicion().equalsIgnoreCase(llega.getPosicion())){
                score += 15;
            }
        }

        // EDAD (potencial)
        if(sale.getEdadJug()!=null && llega.getEdadJug()!=null){
            if(llega.getEdadJug() < sale.getEdadJug()){
                score += 10;
            }
        }

        // EXPERIENCIA
        if(sale.getAnosNbaJug()!=null && llega.getAnosNbaJug()!=null){
            score += (llega.getAnosNbaJug() - sale.getAnosNbaJug()) * 2;
        }

        // ALL STAR (impacto real)
        if(sale.getAnosAllStarJug()!=null && llega.getAnosAllStarJug()!=null){
            score += (llega.getAnosAllStarJug() - sale.getAnosAllStarJug()) * 5;
        }

        // SALARY SIMULADO (IMPORTANTE TFG)
        int salarioSale = estimarSalario(sale);
        int salarioLlega = estimarSalario(llega);

        int diferencia = Math.abs(salarioSale - salarioLlega);

        if(diferencia < 5) score += 15;
        else if(diferencia < 15) score += 5;
        else score -= 10;

        // NORMALIZAR
        if(score > 100) score = 100;
        if(score < 0) score = 0;

        return score;
    }

    // 💰 SALARIO SIMULADO
    public static int estimarSalario(Jugador j){

        int salario = 5;

        if(j.getAnosAllStarJug()!=null){
            salario += j.getAnosAllStarJug() * 8;
        }

        if(j.getAnosNbaJug()!=null){
            salario += j.getAnosNbaJug() * 2;
        }

        if(j.getEdadJug()!=null){
            if(j.getEdadJug() > 32){
                salario -= 3;
            }
        }

        return salario;
    }
}