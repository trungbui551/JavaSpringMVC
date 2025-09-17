package com.taplamweb.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.taplamweb.domain.Order;
import com.taplamweb.domain.OrderDetail;
import com.taplamweb.domain.User;
import com.taplamweb.service.OrderService;

@Controller
public class OrderController {
    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/admin/order")
    public String getDashboardPage(Model model) {
        List<Order> orders = this.orderService.getAllOrders();
        model.addAttribute("orders", orders);
        return "admin/order/show";
    }

    @GetMapping("/admin/order/{id}")
    public String getOrderDetailPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        System.out.println("User Id= " + id);
        Order or = this.orderService.getOrderById(id);
        List<OrderDetail> ords = orderService.getOrderDetails(or);
        model.addAttribute("orderDetails", ords);
        return "admin/order/detail";
    }

    @GetMapping("/admin/order/delete/{id}")
    public String getDeleteOrderPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("order", new Order());
        return "admin/order/delete";
    }

    @PostMapping("/admin/order/delete")
    public String getDelete(Model model, @ModelAttribute("order") Order order) {
        this.orderService.deleteOrder(order.getId());
        return "redirect:/admin/order";

    }
}
