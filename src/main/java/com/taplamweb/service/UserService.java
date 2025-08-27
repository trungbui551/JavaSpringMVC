package com.taplamweb.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.taplamweb.domain.Role;
import com.taplamweb.domain.User;
import com.taplamweb.domain.dto.RegisterDTO;
import com.taplamweb.repository.RoleRepository;
import com.taplamweb.repository.UserRepository;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;

    public String handleHello() {
        return "Hello From Service";
    }

    public UserService(UserRepository userRepository, RoleRepository roleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
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

    public Role getRoleByName(String name) {
        return this.roleRepository.findByName(name);
    }

    public User registerDTOtoUser(RegisterDTO registerDTO) {
        User user = new User();
        user.setFullName(registerDTO.getFirstName() + " " + registerDTO.getLastName());
        user.setEmail(registerDTO.getEmail());
        user.setPassWord((registerDTO.getPassword()));
        return user;
    }

    public boolean checkExistsEmail(String Email) {
        return this.userRepository.existsByEmail(Email);
    }

    public User getUserByEmail(String email) {
        return this.userRepository.findOneByEmail(email);
    }
}
