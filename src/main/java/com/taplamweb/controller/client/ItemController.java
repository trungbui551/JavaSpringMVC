package com.taplamweb.controller.client;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.taplamweb.domain.Cart;
import com.taplamweb.domain.CartDetail;
import com.taplamweb.domain.Product;
import com.taplamweb.domain.User;
import com.taplamweb.service.ProductService;
import com.taplamweb.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ItemController {
    private final ProductService productService;
    private final UserService userService;

    public ItemController(ProductService productService, UserService userService) {
        this.productService = productService;
        this.userService = userService;
    }

    @GetMapping("/product/{id}")
    public String GetItemPage(Model model, @PathVariable long id) {
        Product product = this.productService.getProductById(id);
        List<Product> productList = this.productService.getAllProducts();
        model.addAttribute("pro", product);
        model.addAttribute("pros", productList);
        model.addAttribute("id", id);
        return "client/product/detail";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long productId = id;
        String email = (String) session.getAttribute("email");
        this.productService.handleAddProductToCart(email, productId, session);
        return "redirect:/";
    }

    @GetMapping("/cart")
    public String getCartDetail(Model model, HttpSession session) {
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        Cart cart = this.productService.getCartByUser(user);
        List<CartDetail> listCart = this.productService.getCartDetailsByCart(cart);
        double totalPrice = 0;

        for (CartDetail cartDetail : listCart) {
            totalPrice += cartDetail.getPrice() * cartDetail.getQuantity();
        }
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("cartDetail", listCart);
        return "client/cart/show";
    }
}
