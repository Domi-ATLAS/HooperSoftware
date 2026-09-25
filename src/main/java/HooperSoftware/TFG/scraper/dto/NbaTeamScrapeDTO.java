package HooperSoftware.TFG.scraper.dto;

public class NbaTeamScrapeDTO {

    private String name;
    private String abbreviation;
    private String conference;
    private String url;

    public NbaTeamScrapeDTO(String name, String abbreviation, String conference, String url) {
        this.name = name;
        this.abbreviation = abbreviation;
        this.conference = conference;
        this.url = url;
    }

    public String getName() { return name; }
    public String getAbbreviation() { return abbreviation; }
    public String getConference() { return conference; }
    public String getUrl() { return url; }

    @Override
    public String toString() {
        return name + " (" + abbreviation + ") - " + conference;
    }
}
