package HooperSoftware.TFG.scraping;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.jsoup.nodes.Element;

public class EquipoScraping {
    
    public static void main(String[] args) {
        String url =  "https://www.basketball-reference.com/teams/";

        try{
            Document  doc = Jsoup.connect(url).get();
            Elements equipos = doc.select("table tbody tr th a");

            String nombre = equipos.text();
            String titulosNba = equipos.select(".years_league_champion").text();

            System.err.println("-------------------EQUIPOS-------------------");    
            System.out.println(nombre);
            System.out.println("Titulos NBA: " + titulosNba);
            for(Element equipo : equipos){

            }
        }
        catch(Exception e){
            e.printStackTrace();
        }


    }
    
}
