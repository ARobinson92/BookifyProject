package com.bookify_Project.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookify_Project.models.Rating;
import com.bookify_Project.repositories.RatingRepository;

@Service
public class RatingService {
	@Autowired
	private RatingRepository ratingRepository;
	
	public List<Rating> findRatings(){
		return ratingRepository.findAll();
	}
	
	public Rating findById(Long id) {
		Optional<Rating> rating = ratingRepository.findById(id);
		if(rating.isPresent()) {
			return rating.get();
		} else {
			return null;
		}
	}
	
	public Rating save(Rating rating) {
		return ratingRepository.save(rating);
	}
	
	public void deleteById(Long id) {
		ratingRepository.deleteById(id);
	}
}
