package com.taplamweb.service;

import java.util.Collection;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.taplamweb.domain.Role;
import com.taplamweb.domain.User;
import com.taplamweb.domain.VerificationToken;
import com.taplamweb.domain.dto.RegisterDTO;
import com.taplamweb.exceptions.UserAlreadyExistException;
import com.taplamweb.repository.RoleRepository;
import com.taplamweb.repository.UserRepository;
import com.taplamweb.repository.VerificationTokenRepository;

@Service
public class UserService implements IUserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private VerificationTokenRepository tokenRepository;

    public String handleHello() {
        return "Hello From Service";
    }

    public UserService(UserRepository userRepository, RoleRepository roleRepository,
            VerificationTokenRepository tokenRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.tokenRepository = tokenRepository;
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

    @Override
    public User registerNewUserAccountUser(RegisterDTO userDto)
            throws UserAlreadyExistException {

        if (emailExist(userDto.getEmail())) {
            throw new UserAlreadyExistException(
                    "There is an account with that email adress: "
                            + userDto.getEmail());
        }

        User user = new User();
        user.setFullName(userDto.getFirstName() + userDto.getLastName());
        user.setPassWord(userDto.getPassword());
        user.setEmail(userDto.getEmail());
        user.setEnabled(false);
        return userRepository.save(user);
    }

    private Collection<? extends GrantedAuthority> getAuthorities(String role) {
        return Collections.singletonList(new SimpleGrantedAuthority(role));
    }

    private boolean emailExist(String email) {
        return userRepository.findByEmail(email) != null;
    }

    @Override
    public User getUser(String verificationToken) {
        User user = tokenRepository.findByToken(verificationToken).getUser();
        return user;
    }

    @Override
    public VerificationToken getVerificationToken(String VerificationToken) {
        return tokenRepository.findByToken(VerificationToken);
    }

    @Override
    public void saveRegisteredUser(User user) {
        userRepository.save(user);
    }

    @Override
    public void createVerificationToken(User user, String token) {
        VerificationToken existingToken = tokenRepository.findByUser(user);

        if (existingToken != null) {
            // Nếu đã có, chỉ cần cập nhật token và ngày hết hạn
            existingToken.setToken(token);
            tokenRepository.save(existingToken);
        } else {
            // Nếu chưa có, tạo một token mới
            VerificationToken myToken = new VerificationToken(token, user);
            tokenRepository.save(myToken);
        }
    }

}
