package HooperSoftware.TFG.external.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import HooperSoftware.TFG.external.entity.ExternalGame;

public interface ExternalGameRepository extends JpaRepository<ExternalGame, Long> {
}
