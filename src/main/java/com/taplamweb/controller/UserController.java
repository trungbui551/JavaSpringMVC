package com.taplamweb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.taplamweb.domain.User;
import com.taplamweb.service.UserService;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class UserController {
    private UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping("/trangchu")
    public String getHomePage(Model model) {
        System.out.println("trangchu is running");
        String test = this.userService.handleHello();
        model.addAttribute("hello", test);

        return "hello";
    }

    @RequestMapping("/admin/user")
    public String getUserPage(Model model) {
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    @RequestMapping(value = "/admin/user/create1", method = RequestMethod.POST)
    public String createUserPage(Model model, @ModelAttribute("newUser") User hoidanit) {
        System.out.println(hoidanit);
        return "hello";
    }

}
// @RestController
// public class UserContoller {
// private UserService userService;

// @GetMapping("/")
// public String getHomePage() {
// return this.userService.handleHello();
// }
// }
