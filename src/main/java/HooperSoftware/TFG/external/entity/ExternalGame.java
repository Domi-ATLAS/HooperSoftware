package HooperSoftware.TFG.external.entity;

@Entity
@Table(name = "external_games")
public class ExternalGame {

    @Id
    private Long id;

    private LocalDate date;
    private Integer season;
    private String status;

    private Integer homeScore;
    private Integer visitorScore;

    @ManyToOne
    private ExternalTeam homeTeam;

    @ManyToOne
    private ExternalTeam visitorTeam;
}
