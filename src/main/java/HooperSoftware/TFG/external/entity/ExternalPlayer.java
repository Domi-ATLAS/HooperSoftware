package HooperSoftware.TFG.external.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "external_players")
public class ExternalPlayer {

    @Id
    private Long id;

    private String firstName;
    private String lastName;
    private String position;

    @ManyToOne
    @JoinColumn(name = "team_id")
    private ExternalTeam team;

    public ExternalPlayer() {
    }

    public ExternalPlayer(Long id, String firstName, String lastName, String position, ExternalTeam team) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.position = position;
        this.team = team;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public ExternalTeam getTeam() {
        return team;
    }

    public void setTeam(ExternalTeam team) {
        this.team = team;
    }
}
