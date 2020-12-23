package com.bookify_Project.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.bookify_Project.models.Trip;

@Repository
public interface TripRepository extends CrudRepository<Trip, Long> {
	List<Trip> findAll();
	List<Trip> findByCreatoridContaining(Long id);
}
