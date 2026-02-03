package HooperSoftware.TFG.external.entity;

@Entity
@Table(name = "external_players")
public class ExternalPlayer {

    @Id
    private Long id;

    private String firstName;
    private String lastName;
    private String position;
    private Integer heightFeet;
    private Integer heightInches;
    private Integer weightPounds;

    @ManyToOne
    @JoinColumn(name = "team_id")
    private ExternalTeam team;
}
