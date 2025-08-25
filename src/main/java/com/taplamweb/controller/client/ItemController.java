package com.taplamweb.controller.client;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
        List<CartDetail> listCart = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        double totalPrice = 0;

        for (CartDetail cartDetail : listCart) {
            totalPrice += cartDetail.getPrice() * cartDetail.getQuantity();
        }
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("cartDetail", listCart);
        model.addAttribute("cart", cart);
        return "client/cart/show";
    }

    @PostMapping("/delete-cart-detail/{id}")
    public String deleteCartDetail(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long cartdt_id = id;
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        CartDetail cartDetail = this.productService.getCartDetailById(cartdt_id);
        Cart cart = this.productService.getCartByUser(user);
        if (cart != null) {
            this.productService.deleteCardDetail(cartDetail);

            if (cart.getSum() == 0) {
                this.productService.deleteCard(cart);
            }
            cart.setSum(cart.getSum() - 1);
            session.setAttribute("sum", cart.getSum());
        }

        return "redirect:/cart";
    }

    // Khi bấm vào nút check out
    @PostMapping("/confirm-checkout")
    public String getCheckOutPage(@ModelAttribute("cart") Cart cart) {
        List<CartDetail> cartDetails = cart == null ? new ArrayList<>() : cart.getCartDetails();
        // Update số lượng
        this.productService.HandleCartUpdateBeforeCheckout(cartDetails);
        return "redirect:/checkout";
    }

    // Render ra giao diện checkout (form)
    @GetMapping("/checkout")
    public String getCheckOutPage(Model model, HttpServletRequest request) {
        User currentUser = new User();
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);
        Cart cart = this.productService.getCartByUser(currentUser);
        List<CartDetail> listCart = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        double totalPrice = 0;

        for (CartDetail cartDetail : listCart) {
            totalPrice += cartDetail.getPrice() * cartDetail.getQuantity();
        }
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("cartDetail", listCart);
        model.addAttribute("cart", cart);
        return "client/cart/checkout";
    }

    @PostMapping("/place-order")
    public String handlePlaceOrder(HttpServletRequest request,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone,
            @RequestParam("totalPrice") double totalPrice) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        long id = (long) session.getAttribute("id");
        user.setId(id);
        this.productService.handlePlaceOrder(user, session, receiverName, receiverPhone, receiverAddress, totalPrice);
        return "redirect:/thanks";
    }

    @GetMapping("/thanks")
    public String getThanksPage() {
        return "client/cart/thanks";
    }
}
