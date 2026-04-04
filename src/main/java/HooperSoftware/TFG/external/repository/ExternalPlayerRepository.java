package HooperSoftware.TFG.external.repository;

import HooperSoftware.TFG.external.entity.ExternalPlayer;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ExternalPlayerRepository extends JpaRepository<ExternalPlayer, Long> {
}
