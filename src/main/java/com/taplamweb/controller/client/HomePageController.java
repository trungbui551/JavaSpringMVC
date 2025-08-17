package com.taplamweb.controller.client;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.taplamweb.domain.Product;
import com.taplamweb.domain.User;
import com.taplamweb.domain.dto.RegisterDTO;
import com.taplamweb.service.ProductService;
import com.taplamweb.service.UserService;

import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomePageController {
    private final ProductService productService;
    private final UserService userService;
    private PasswordEncoder passwordEncoder;

    public HomePageController(ProductService productService, UserService userService, PasswordEncoder passwordEncoder) {
        this.productService = productService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;

    }

    @GetMapping("/")
    public String getMethodName(Model model) {
        List<Product> productList = this.productService.getAllProducts();
        model.addAttribute("pros", productList);
        return "client/homepage/show";
    }

    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("newRegisterDTO", new RegisterDTO());
        return "client/auth/register";
    }

    @PostMapping("/register")
    public String handleRegiserPage(@ModelAttribute("newRegisterDTO") @Valid RegisterDTO it,
            BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "client/auth/register";
        }

        // List<FieldError> errors = bindingResult.getFieldErrors();
        // for (FieldError e : errors) {
        // System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>." + e.getField() + "-" +
        // e.getDefaultMessage());
        // }
        String password = this.passwordEncoder.encode(it.getPassword());
        User user = this.userService.registerDTOtoUser(it);
        user.setPassWord(password);
        user.setRole(this.userService.getRoleByName("USER"));
        user.setAddress("Chưa cập nhật");
        user.setPhone("chưa cập nhật");
        this.userService.handleSaveUser(user);

        return "redirect:/login";
    }

    @GetMapping("/login")
    public String getLoginPage(Model model) {

        return "client/auth/login";
    }

    @GetMapping("/access-deny")
    public String getDenyPage() {
        return "client/auth/deny";
    }

}
