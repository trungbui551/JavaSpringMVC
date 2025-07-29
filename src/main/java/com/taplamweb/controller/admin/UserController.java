package com.taplamweb.controller.admin;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.lang.reflect.Method;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.taplamweb.domain.Role;
import com.taplamweb.domain.User;
import com.taplamweb.service.UploadService;
import com.taplamweb.service.UserService;

import jakarta.servlet.ServletContext;

import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
public class UserController {
    private UserService userService;
    private UploadService uploadService;
    private PasswordEncoder passwordEncoder;

    public UserController(UserService userService, UploadService uploadService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;

    }

    @RequestMapping("/")
    public String getHomePage(Model model) {
        System.out.println("trangchu is running");
        List<User> arrUsers = this.userService.getUsersByEmail("cc@gmail.com");
        System.out.println(arrUsers);
        model.addAttribute("hello", "test");

        return "hello";
    }

    @RequestMapping("/admin/user/create")
    public String getUserPage(Model model) {
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    @RequestMapping("/admin/user")
    public String getUserManagerPage(Model model) {
        List<User> users = this.userService.getAllUsers();
        System.out.println("this is list :" + users);
        model.addAttribute("users1", users);
        return "admin/user/show";
    }

    @RequestMapping("/admin/user/{id}")
    public String getUserDetailPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        System.out.println("User Id= " + id);
        User user1 = this.userService.getUsersByID(id);
        model.addAttribute("iuser", user1);
        return "admin/user/detail";
    }

    @RequestMapping("/admin/user/update/{id}")
    public String getUpdateUserPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        User user1 = this.userService.getUsersByID(id);
        model.addAttribute("newUser", user1);
        return "admin/user/update";
    }

    @PostMapping("/admin/user/update")
    public String postUpdateUser(Model model, @ModelAttribute("newUser") User hoidanit) {
        User currentUser = this.userService.getUsersByID(hoidanit.getId());
        if (currentUser != null) {
            currentUser.setAddress(hoidanit.getAddress());
            currentUser.setFullName(hoidanit.getFullName());
            currentUser.setPhone(hoidanit.getPhone());
            this.userService.handleSaveUser(currentUser);
        }
        return "redirect:/admin/user";
    }

    @RequestMapping("/admin/user/delete/{id}")
    public String getDeleteUserPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);

        model.addAttribute("user", new User());
        return "admin/user/delete";
    }

    @PostMapping("/admin/user/delete")
    public String deleteUserPage(Model model, @ModelAttribute("newUser") User harry) {
        this.userService.deleteAnUser(harry.getId());
        return "redirect:/admin/user";
    }

    @PostMapping(value = "/admin/user/create")
    public String createUserPage(Model model, @ModelAttribute("newUser") User hoidanit,
            @RequestParam("trungImg") MultipartFile file) {

        String avatarFile = this.uploadService.handleSaverUploadFile(file, "avatar");
        String passwordEnd = this.passwordEncoder.encode(hoidanit.getPassWord());
        hoidanit.setAvatar(avatarFile);
        hoidanit.setPassWord(avatarFile);
        System.out.println("Role: " + hoidanit.getRole().getName());
        // SaveRoles

        Role role = this.userService.getRoleByName(hoidanit.getRole().getName());
        hoidanit.setRole(role);
        this.userService.handleSaveUser(hoidanit);
        return "redirect:/admin/user";
    }

}
