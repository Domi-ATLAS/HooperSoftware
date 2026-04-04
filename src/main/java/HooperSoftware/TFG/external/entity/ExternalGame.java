package HooperSoftware.TFG.external.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
public class ExternalGame {

    @Id
    private Long id;

    private LocalDate date;

    private Integer homeScore;
    private Integer visitorScore;

    @ManyToOne
    @JoinColumn(name = "home_team_id")
    private ExternalTeam homeTeam;

    @ManyToOne
    @JoinColumn(name = "visitor_team_id")
    private ExternalTeam visitorTeam;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public Integer getHomeScore() {
        return homeScore;
    }

    public void setHomeScore(Integer homeScore) {
        this.homeScore = homeScore;
    }

    public Integer getVisitorScore() {
        return visitorScore;
    }

    public void setVisitorScore(Integer visitorScore) {
        this.visitorScore = visitorScore;
    }

    public ExternalTeam getHomeTeam() {
        return homeTeam;
    }

    public void setHomeTeam(ExternalTeam homeTeam) {
        this.homeTeam = homeTeam;
    }

    public ExternalTeam getVisitorTeam() {
        return visitorTeam;
    }

    public void setVisitorTeam(ExternalTeam visitorTeam) {
        this.visitorTeam = visitorTeam;
    }
}
