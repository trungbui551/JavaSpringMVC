package com.taplamweb.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.taplamweb.domain.Order;
import com.taplamweb.domain.User;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    Order findById(long id);

    List<Order> findByUser(User user);
}
