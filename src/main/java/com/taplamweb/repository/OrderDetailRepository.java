package com.taplamweb.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.taplamweb.domain.OrderDetail;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {

}
