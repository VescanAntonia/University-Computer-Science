package com.example.citybreak.repository;

import com.example.citybreak.model.CityBreak;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface CityBreakRepository extends JpaRepository<CityBreak, Long> {
}
