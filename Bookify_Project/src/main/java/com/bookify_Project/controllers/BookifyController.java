package com.bookify_Project.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookify_Project.models.Rating;
import com.bookify_Project.models.Trip;
import com.bookify_Project.models.User;
import com.bookify_Project.services.RatingService;
import com.bookify_Project.services.TripService;
import com.bookify_Project.services.UserService;
import com.bookify_Project.validators.UserValidator;

@Controller
public class BookifyController {

	private UserService userService;
	private TripService tripService;
	private RatingService ratingService;
	private UserValidator userValidator;

	public BookifyController(UserValidator userValidator, RatingService ratingService, TripService tripService,
			UserService userService) {
		this.userValidator = userValidator;
		this.ratingService = ratingService;
		this.tripService = tripService;
		this.userService = userService;
	}

	@GetMapping("/")
	public String index(@ModelAttribute("user") User user) {
		return "index.jsp";
	}

	@PostMapping("/registration")
	public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
		userValidator.validate(user, result);
		if (result.hasErrors()) {
			return "index.jsp";
		}
		User u = userService.registerUser(user);
		session.setAttribute("user_id", u.getId());
		return "redirect:/home";
	}

	@PostMapping("/login")
	public String loginUser(@RequestParam("email") String email, @RequestParam("password") String password, Model model,
			HttpSession session) {
		boolean isAuthenticated = userService.authenticateUser(email, password);
		if (isAuthenticated) {
			User u = userService.findByEmail(email);
			session.setAttribute("user_id", u.getId());
			return "redirect:/home";
		}
		model.addAttribute("error", "Invalid Credentials. Please try again.");
		return "index.jsp";
	}

	@GetMapping("/home")
	public String home(HttpSession session, Model model, @ModelAttribute("user") User user,
			@ModelAttribute("trip") Trip trip) {
		Long userId = (Long) session.getAttribute("user_id");
		User u = userService.findById(userId);
		List<Trip> trips = tripService.findTrips();
		model.addAttribute("user", u);
		model.addAttribute("trips", trips);
		return "homePage.jsp";
	}

	@PostMapping("/trips")
	public String process(@Valid @ModelAttribute("addNew") Trip trip, BindingResult result, Model model,
			HttpSession session) {
		if (result.hasErrors()) {
			List<Trip> trips = tripService.findTrips();
			model.addAttribute("trips", trips);
			return "homePage.jsp";
		}
		Long userId = (Long) session.getAttribute("user_id");
		Trip t = tripService.save(trip);
		t.setCreatorid(userId);
		tripService.save(t);
		return "redirect:/home";
	}

	@GetMapping("/trips/{id}")
	public String trips(@PathVariable("id") Long id, Model model, HttpSession session, @ModelAttribute("rating") Rating rating) {
		Long userId = (Long) session.getAttribute("user_id");
		User u = userService.findById(userId);
		model.addAttribute("userEmail", u.getEmail());
		Trip trip = tripService.findById(id);
		List<User> users = trip.getUsers();
		List<Rating> ratings = trip.getRatings();
		model.addAttribute("trip", trip);
		model.addAttribute("users", users);
		model.addAttribute("ratings", ratings);
		return "trip.jsp";
	}

	@PostMapping("/trips/{id}")
	public String addToTrip(@PathVariable("id") Long id, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("user_id");
		User u = userService.findById(userId);
		Trip trip = tripService.findById(id);
		trip.getUsers().add(u);
		tripService.save(trip);
		return "redirect:/trips/{id}";
	}
	
	@PostMapping("/trips/{id}/rating")
	public String addRating(@Valid @ModelAttribute("rating") Rating rating, @PathVariable("id") Long id, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("user_id");
		User u = userService.findById(userId);
		Trip trip = tripService.findById(id);
		Rating r = ratingService.save(rating);
		r.setTrip(trip);
		r.setUser(u);
		ratingService.save(r);
		return "redirect:/trips/" + trip.getId();
	}

	@PostMapping("/trips/{id}/remove")
	public String removeFromTrip(@PathVariable("id") Long id, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("user_id");
		User u = userService.findById(userId);
		Trip trip = tripService.findById(id);
		trip.getUsers().remove(u);
		tripService.save(trip);
		return "redirect:/users/{id}";
	}

	@GetMapping("/trips/{id}/edit")
	public String editForm(@PathVariable("id") Long id, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("user_id");
		Trip trip = tripService.findById(id);
		if (trip.getCreatorid() == userId) {
			model.addAttribute("trip", trip);
			return "edit.jsp";
		}
		return "redirect:/home";
	}

	@PostMapping("/trips/{id}/edit")
	public String edit(@Valid @ModelAttribute("trip") Trip trip, BindingResult result) {
		if (result.hasErrors()) {
			return "edit.jsp";
		}
		tripService.save(trip);
		return "redirect:/home";
	}

	@RequestMapping("/trips/{id}delete")
	public String delete(@PathVariable("id") Long id) {
		tripService.deleteById(id);
		return "redirect:/home";
	}

	@GetMapping("/users/{id}")
	public String userPage(HttpSession session, Model model, @PathVariable("id") Long id) {
		User u = userService.findById(id);
		List<Trip> trips = u.getTrips();
		List<Trip> mytrips = tripService.findTrips();
		model.addAttribute("user", u);
		model.addAttribute("trips", trips);
		model.addAttribute("mytrips", mytrips);
		return "user.jsp";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}
