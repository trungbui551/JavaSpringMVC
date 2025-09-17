package com.taplamweb.controller.client;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.taplamweb.domain.Order;
import com.taplamweb.domain.User;
import com.taplamweb.service.OrderService;
import com.taplamweb.service.UserService;

@Controller
public class CartController {

    private OrderService orderService;
    private UserService userService;

    public CartController(OrderService orderService, UserService userService) {
        this.orderService = orderService;
        this.userService = userService;
    }

    @GetMapping("/client/history/{id}")
    public String getPurchaseHistory(@PathVariable long id, Model model) {
        User user = this.userService.getUsersByID(id);
        List<Order> orderList = this.orderService.getOrderListByUser(user);
        model.addAttribute("orderList", orderList);
        return "client/cart/history";
    }
}
