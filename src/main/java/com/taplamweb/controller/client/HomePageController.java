package com.taplamweb.controller.client;

import org.springframework.data.domain.Page;
import org.springframework.data.repository.query.Param;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;

import com.taplamweb.domain.Product;
import com.taplamweb.service.ProductService;

import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomePageController {
    private final ProductService productService;

    public HomePageController(ProductService productService) {
        this.productService = productService;

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

}