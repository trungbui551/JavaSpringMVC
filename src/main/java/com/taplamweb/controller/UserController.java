package com.taplamweb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.taplamweb.service.UserService;

@Controller
public class UserController {
    private UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping("/trangchu")
    public String getHomePage(Model model) {
        String test = this.userService.handleHello();
        model.addAttribute("hello", test);

        return "hello";
    }

    @RequestMapping("/admin/user")
    public String getHomePage() {
        return "admin/user/create";
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
