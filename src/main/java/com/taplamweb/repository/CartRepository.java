package com.taplamweb.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.taplamweb.domain.Cart;
import com.taplamweb.domain.User;
import java.util.List;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {
    Cart findByUser(User user);

    Cart findCartById(long id);
}
