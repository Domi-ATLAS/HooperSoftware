package HooperSoftware.TFG.external.repository;

import HooperSoftware.TFG.external.entity.ExternalTeam;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ExternalTeamRepository extends JpaRepository<ExternalTeam, Long> {
}
