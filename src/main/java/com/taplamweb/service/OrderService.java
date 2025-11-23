package com.taplamweb.service;

import java.util.ArrayList;
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

    public List<Object[]> getRevenueByMonth() {
        List<Object[]> data = this.orderRepository.getRevenueByMonth();
        List<Object[]> result = new ArrayList<>();

        for (Object[] objects : data) {
            Number yearNum = (Number) objects[1];
            Number monthNum = (Number) objects[0];
            Number revenue = (Number) objects[2]; // có thể là Double hoặc BigDecimal
            if (monthNum == null || yearNum == null || revenue == null) {
                System.out.println("Skipping NULL record");
                continue;
            }
            int year = yearNum != null ? yearNum.intValue() : 0;
            int month = monthNum != null ? monthNum.intValue() : 0;
            double total = revenue != null ? revenue.doubleValue() : 0.0;
            String lable = "Tháng " + month + "/" + year;
            result.add(new Object[] { lable, total });
        }
        return result;
    }

    public List<Order> getListOrderForDashBoard() {
        return this.orderRepository.findAllByOrderByOrderDateDesc();
    }

}
