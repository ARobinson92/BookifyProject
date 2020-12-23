package com.bookify_Project.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookify_Project.models.Trip;
import com.bookify_Project.repositories.TripRepository;

@Service
public class TripService {

	@Autowired
	private TripRepository tripRepository;

	public List<Trip> findTrips() {
		return tripRepository.findAll();
	}

	public Trip findById(Long id) {
		Optional<Trip> trip = tripRepository.findById(id);
		if(trip.isPresent()) {
			return trip.get();
		} else {
			return null;
		}
	}
	
	public List<Trip> findByCreator_Id(Long id) {
		return tripRepository.findByCreatoridContaining(id);
	}

	public Trip save(Trip trip) {
		return tripRepository.save(trip);
	}

	public void deleteById(Long id) {
		tripRepository.deleteById(id);
	}
}
