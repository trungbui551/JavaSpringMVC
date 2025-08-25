package com.taplamweb.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.taplamweb.domain.Order;

public interface OrderRepository extends JpaRepository<Order, Long> {

}
