package com.taplamweb.controller.client;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.taplamweb.domain.Product;
import com.taplamweb.service.ProductService;

@Controller
public class ItemController {
    private final ProductService productService;

    public ItemController(ProductService productService) {
        this.productService = productService;
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
}
