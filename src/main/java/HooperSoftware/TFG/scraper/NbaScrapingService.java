package HooperSoftware.TFG.scraper;

import HooperSoftware.TFG.scraper.dto.NbaTeamScrapeDTO;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class NbaScrapingService {

    private static final String TEAMS_URL
            = "https://www.basketball-reference.com/teams/";

    public List<NbaTeamScrapeDTO> scrapeTeams() {

        List<NbaTeamScrapeDTO> teams = new ArrayList<>();

        try {
            Document doc = Jsoup.connect(TEAMS_URL)
                    .userAgent("Mozilla/5.0")
                    .timeout(15_000)
                    .get();

            org.jsoup.select.NodeTraversor.traverse(
                    new org.jsoup.select.NodeVisitor() {
                @Override
                public void head(org.jsoup.nodes.Node node, int depth) {
                    if (node.nodeName().equals("#comment")) {
                        String commentHtml = node.toString();

                        if (commentHtml.contains("teams_active")) {
                            Document commentDoc = Jsoup.parse(commentHtml);

                            Elements rows = commentDoc
                                    .select("table#teams_active tr.full_table");

                            for (Element row : rows) {
                                Element teamCell = row
                                        .selectFirst("th[data-stat=team_name] a");

                                if (teamCell == null) {
                                    continue;
                                }

                                String name = teamCell.text();
                                String url = "https://www.basketball-reference.com"
                                        + teamCell.attr("href");
                                String abbreviation = url.split("/")[4];
                                String conference = row
                                        .select("td[data-stat=conf]").text();

                                teams.add(new NbaTeamScrapeDTO(
                                        name,
                                        abbreviation,
                                        conference,
                                        url
                                ));
                            }
                        }
                    }
                }

                @Override
                public void tail(org.jsoup.nodes.Node node, int depth) {
                }
            },
                    doc
            );

        } catch (Exception e) {
            throw new RuntimeException("Error scraping NBA teams", e);
        }
        teams.forEach(t -> System.out.println(t.getName()));
        return teams;
    }

    private void extractTeamsFromNode(org.jsoup.nodes.Node node, List<NbaTeamScrapeDTO> teams) {
        if (node.nodeName().equals("#comment")) {
            String html = node.toString();
            if (html.contains("teams_active")) {
                Document commentDoc = Jsoup.parse(html);

                Elements rows = commentDoc.select("table#teams_active tr.full_table");

                for (Element row : rows) {
                    Element teamCell = row.selectFirst("th[data-stat=team_name] a");
                    if (teamCell == null) {
                        continue;
                    }

                    String name = teamCell.text();
                    String url = "https://www.basketball-reference.com" + teamCell.attr("href");
                    String abbreviation = url.split("/")[4];
                    String conference = row.select("td[data-stat=conf]").text();

                    teams.add(new NbaTeamScrapeDTO(
                            name,
                            abbreviation,
                            conference,
                            url
                    ));
                }
            }
        }

        // Recursivo (por si está más profundo)
        for (org.jsoup.nodes.Node child : node.childNodes()) {
            extractTeamsFromNode(child, teams);
        }
    }

}
