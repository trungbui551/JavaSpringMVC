package com.taplamweb.controller.client;

import java.util.Calendar;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.context.MessageSource;
import org.springframework.data.domain.Page;
import org.springframework.data.repository.query.Param;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.taplamweb.domain.Product;
import com.taplamweb.domain.User;
import com.taplamweb.domain.VerificationToken;
import com.taplamweb.domain.dto.RegisterDTO;
import com.taplamweb.event.OnRegistrationCompleteEvent;
import com.taplamweb.event.OnResetPasswordEvent;
import com.taplamweb.service.IUserService;
import com.taplamweb.service.ProductService;
import com.taplamweb.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
public class HomePageController {
    private final ProductService productService;
    private final UserService userService;
    private PasswordEncoder passwordEncoder;
    ApplicationEventPublisher eventPublisher;
    private IUserService service;
    @Autowired
    private MessageSource messages;

    public HomePageController(ProductService productService, UserService userService, PasswordEncoder passwordEncoder,
            ApplicationEventPublisher eventPublisher, IUserService service) {
        this.productService = productService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.eventPublisher = eventPublisher;
        this.service = service;
    }

    @GetMapping("/")
    public String getMethodName(Model model, @Param("keyword") String keyword,
            @RequestParam(name = "pageNo", defaultValue = "1") Integer pageNo) {
        Page<Product> productlist = this.productService.getALL(pageNo);
        if (keyword != null) {
            productlist = this.productService.searchProduct(keyword, pageNo);
            model.addAttribute("keyword", keyword);
        }
        int totalPages = productlist.getTotalPages();
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("pros", productlist.getContent());
        return "client/homepage/show";
    }

    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("newRegisterDTO", new RegisterDTO());
        return "client/auth/register";
    }

    @PostMapping("/register")
    public String handleRegiserPage(@ModelAttribute("newRegisterDTO") @Valid RegisterDTO it,
            BindingResult bindingResult, HttpServletRequest request) {
        if (bindingResult.hasErrors()) {
            return "client/auth/register";
        }
        String password = this.passwordEncoder.encode(it.getPassword());
        User user = this.userService.registerDTOtoUser(it);
        user.setPassWord(password);
        user.setRole(this.userService.getRoleByName("USER"));
        user.setAddress("Chưa cập nhật");
        user.setPhone("chưa cập nhật");
        user.setEnabled(false);
        this.userService.handleSaveUser(user);

        String appUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();

        eventPublisher.publishEvent(new OnRegistrationCompleteEvent(user,
                request.getLocale(), appUrl));
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

    @GetMapping("/regitrationConfirm")
    public String confirmRegistration(WebRequest request, Model model, @RequestParam("token") String token) {

        Locale locale = request.getLocale();

        VerificationToken verificationToken = service.getVerificationToken(token);
        if (verificationToken == null) {
            String message = messages.getMessage("auth.message.invalidToken", null, locale);
            model.addAttribute("message", message);
            return "redirect:/badUser?lang=" + locale.getLanguage();
        }

        User user = verificationToken.getUser();
        Calendar cal = Calendar.getInstance();
        if ((verificationToken.getExpiryDate().getTime() - cal.getTime().getTime()) <= 0) {
            String messageValue = messages.getMessage("auth.message.expired", null, locale);
            model.addAttribute("message", messageValue);
            return "redirect:/badUser?lang=" + locale.getLanguage();
        }

        user.setEnabled(true);
        service.saveRegisteredUser(user);
        return "redirect:/login?lang=" + request.getLocale().getLanguage();
    }

    // forgot password controller
    @GetMapping("/forgotPassword")
    public String getForgotPassWordController(Model model) {

        return "client/auth/fillEmail";
    }

    @PostMapping("/handle-password")
    public String getHandlePasswordPage(HttpServletRequest request, @RequestParam("username") String email,
            Model model) {

        boolean check = this.userService.checkExistsEmail(email);
        System.out.println("Email: " + email + " Check: \n" + check);
        if (check == false) {
            String error = "Tài khoản không tồn tại";
            model.addAttribute("error", error);
            return "redirect:/forgotPassword";
        }
        String appUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
        User user = this.userService.getUserByEmail(email);
        eventPublisher.publishEvent(new OnResetPasswordEvent(user,
                request.getLocale(), appUrl));
        return "client/auth/emailCheck";
    }

    @GetMapping("/userConfirm")
    public String userConfirm(WebRequest request, Model model, @RequestParam("token") String token) {

        Locale locale = request.getLocale();

        VerificationToken verificationToken = service.getVerificationToken(token);
        if (verificationToken == null) {
            String message = messages.getMessage("auth.message.invalidToken", null, locale);
            model.addAttribute("message", message);
            System.out.println("------------------------------- NULL");
            return "redirect:/badUser?lang=" + locale.getLanguage();

        }

        User user = verificationToken.getUser();
        Calendar cal = Calendar.getInstance();
        if ((verificationToken.getExpiryDate().getTime() - cal.getTime().getTime()) <= 0) {
            String messageValue = messages.getMessage("auth.message.expired", null, locale);
            model.addAttribute("message", messageValue);
            System.out.println("------------------------------- Hết Hạn");
            return "redirect:/badUser?lang=" + locale.getLanguage();
        }
        return "redirect:/resetPassword?token=" + token;
    }

    @GetMapping("/resetPassword")
    public String getResetPasswordPage(@RequestParam("token") String token, Model model) {
        model.addAttribute("token", token);
        return "client/auth/resetPassword";
    }

    @PostMapping("/resetPassword")
    public String postMethodName(@RequestParam("token") String token,
            @RequestParam("password") String password,
            Model model) {
        String password1 = passwordEncoder.encode(password);
        VerificationToken verificationToken = service.getVerificationToken(token);
        if (verificationToken == null) {
            return "redirect:/badUser"; // Token không hợp lệ
        }

        User user = verificationToken.getUser();
        if (user != null) {
            String encodedPassword = passwordEncoder.encode(password);
            User user1 = this.userService.getUserByEmail(user.getEmail());
            user1.setPassWord(encodedPassword);

            return "redirect:/login?resetSuccess";
        } else {
            return "redirect:/badUser";
        }
    }

    @GetMapping("/emailCheck")
    public String getEmailCheck() {
        return "client/auth/emailCheck";
    }

    @GetMapping("/badUser")
    public String getBadUser() {
        return "client/auth/badUser";
    }
}