package com.taplamweb.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.taplamweb.domain.Order;
import com.taplamweb.domain.OrderDetail;
import com.taplamweb.domain.User;
import com.taplamweb.repository.OrderDetailRepository;
import com.taplamweb.repository.OrderRepository;

@Service
public class OrderService {
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public OrderService(OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    public List<Order> getAllOrders() {
        return this.orderRepository.findAll();
    }

    public List<OrderDetail> getOrderDetails(Order order) {
        return this.orderDetailRepository.findByOrder(order);
    }

    public Order getOrderById(long id) {
        return this.orderRepository.findById(id);
    }

    public void deleteOrder(long id) {
        Order order = this.orderRepository.findById(id);
        List<OrderDetail> orderDetail = this.orderDetailRepository.findByOrder(order);

        if (orderDetail != null) {
            for (OrderDetail orderDetail2 : orderDetail) {
                if (orderDetail2 != null) {
                    this.orderDetailRepository.delete(orderDetail2);
                }
            }
        }
        this.orderRepository.delete(order);
    }

    public List<Order> getOrderListByUser(User user) {
        return this.orderRepository.findByUser(user);
    }
}
