package com.taplamweb.service;

import com.taplamweb.domain.User;
import com.taplamweb.domain.VerificationToken;
import com.taplamweb.domain.dto.RegisterDTO;
import com.taplamweb.exceptions.UserAlreadyExistException;

public interface IUserService {

    User registerNewUserAccount(RegisterDTO userDto)
            throws UserAlreadyExistException;

    User getUser(String verificationToken);

    void saveRegisteredUser(User user);

    void createVerificationToken(User user, String token);

    VerificationToken getVerificationToken(String VerificationToken);

    User registerNewUserAccountUser(RegisterDTO userDto) throws UserAlreadyExistException;
}