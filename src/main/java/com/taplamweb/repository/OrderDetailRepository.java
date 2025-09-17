package com.taplamweb.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.taplamweb.domain.Order;
import com.taplamweb.domain.OrderDetail;
import java.util.List;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {

    List<OrderDetail> findByOrder(Order order);

    void delete(OrderDetail entity);

}
