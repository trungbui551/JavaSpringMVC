package com.taplamweb.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.taplamweb.domain.User;
import com.taplamweb.repository.UserRepository;

import jakarta.persistence.Id;

@Service
public class UserService {
    private final UserRepository userRepository;

    public String handleHello() {
        return "Hello From Service";
    }

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public List<User> getAllUsers() {
        return this.userRepository.findAll();
    }

    public List<User> getUsersByEmail(String email) {
        return this.userRepository.findByEmail(email);
    }

    public User getUsersByID(long Id) {
        return this.userRepository.findById(Id);
    }

    public User handleSaveUser(User user) {
        User newUser = this.userRepository.save(user);
        return newUser;
    }

    public void deleteAnUser(long id) {
        this.userRepository.deleteById(id);
    }
}
