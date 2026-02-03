package HooperSoftware.TFG.external.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "external_teams")
public class ExternalTeam {

    @Id
    @Column(name = "id")
    private Long id; // ID de balldontlie

    @Column(name = "abbreviation", length = 5)
    private String abbreviation;

    @Column(name = "city")
    private String city;

    @Column(name = "name")
    private String name;

    @Column(name = "conference")
    private String conference;

    @Column(name = "division")
    private String division;

    // =====================
    // Constructores
    // =====================
    public ExternalTeam() {
    }

    public ExternalTeam(Long id, String abbreviation, String city, String name,
            String conference, String division) {
        this.id = id;
        this.abbreviation = abbreviation;
        this.city = city;
        this.name = name;
        this.conference = conference;
        this.division = division;
    }

    // =====================
    // Getters & Setters
    // =====================
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAbbreviation() {
        return abbreviation;
    }

    public void setAbbreviation(String abbreviation) {
        this.abbreviation = abbreviation;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getConference() {
        return conference;
    }

    public void setConference(String conference) {
        this.conference = conference;
    }

    public String getDivision() {
        return division;
    }

    public void setDivision(String division) {
        this.division = division;
    }
}
