package com.taplamweb.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.taplamweb.domain.User;
import com.taplamweb.domain.VerificationToken;

public interface VerificationTokenRepository
        extends JpaRepository<VerificationToken, Long> {

    VerificationToken findByToken(String token);

    VerificationToken findByUser(User user);
}
