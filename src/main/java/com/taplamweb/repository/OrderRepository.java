package com.taplamweb.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.taplamweb.domain.Order;
import com.taplamweb.domain.User;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    Order findById(long id);

    List<Order> findByUser(User user);

    @Query("SELECT MONTH(o.orderDate) as m, YEAR(o.orderDate) as y, SUM(o.totalPrice) FROM Order o GROUP BY YEAR(o.orderDate), MONTH(o.orderDate) ORDER BY YEAR(o.orderDate), MONTH(o.orderDate)")
    List<Object[]> getRevenueByMonth();
}
