package com.taplamweb.controller.admin;

import java.util.List;

import org.eclipse.tags.shaded.org.apache.xpath.operations.Mod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.taplamweb.domain.Product;
import com.taplamweb.domain.Role;
import com.taplamweb.service.ProductService;
import com.taplamweb.service.UploadService;

import jakarta.validation.Valid;

@Controller
public class ProductController {
    private final UploadService uploadService;
    private final ProductService productService;

    public ProductController(UploadService uploadService, ProductService productService) {
        this.uploadService = uploadService;
        this.productService = productService;
    }

    @RequestMapping("/admin/product/create")
    public String getCreateProductPage(Model model, @ModelAttribute("newProduct") Product hary) {
        {
            model.addAttribute("newProduct", hary);

            return "admin/product/create";

        }

    }

    @PostMapping(value = "/admin/product/create")
    public String createProductPage(Model model, @Valid @ModelAttribute("newProduct") Product laptop,
            BindingResult newUseBindingResult,
            @RequestParam("trungImg") MultipartFile file) {

        List<FieldError> errors = newUseBindingResult.getFieldErrors();
        for (FieldError e : errors) {
            System.out.println(">>>>>>" + e.getField() + "-" + e.getDefaultMessage());
        }
        if (newUseBindingResult.hasErrors()) {
            return "admin/product/create";
        }
        String productImg = this.uploadService.handleSaverUploadFile(file, "product");

        laptop.setImage(productImg);

        this.productService.handleSaveProduct(laptop);
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product")
    public String getProductManagerPage(Model model) {
        List<Product> pros = this.productService.getAllProducts();

        model.addAttribute("pros", pros);
        return "admin/product/show";
    }

    @GetMapping("/admin/product/update/{id}")
    public String getProductUpdatePage(Model model, @Valid @PathVariable long id) {
        Product pro = this.productService.getProductById(id);
        model.addAttribute("product", pro);
        System.out.println(">>>>>>>>>>>>>>>>>>>>>" + pro.toString());
        model.addAttribute("id", id);
        return "admin/product/update";
    }

    @PostMapping("/admin/product/update")
    public String postUpdateProduct(Model model, @ModelAttribute("product") Product hoidanit,
            BindingResult newUseBindingResult,
            @RequestParam("newimg") MultipartFile file) {
        List<FieldError> errors = newUseBindingResult.getFieldErrors();
        if (newUseBindingResult.hasErrors()) {
            return "admin/product/update";
        }

        Product currentProduct = this.productService.getProductById(hoidanit.getId());
        System.out.println(currentProduct.toString());
        if (currentProduct != null) {
            if (!file.isEmpty()) {
                String img = this.uploadService.handleSaverUploadFile(file, "product");
                currentProduct.setImage(img);
            }

            System.out.println("---------------------------------------------------" + hoidanit.getFactory());
            currentProduct.setDetailDesc(hoidanit.getDetailDesc());
            currentProduct.setFactory(hoidanit.getFactory());
            currentProduct.setShortDesc(hoidanit.getShortDesc());
            currentProduct.setPrice((hoidanit.getPrice()));
            currentProduct.setSold(hoidanit.getSold());
            currentProduct.setTarget(hoidanit.getTarget());
            this.productService.handleSaveProduct(currentProduct);
        }
        return "redirect:/admin/product";
    }
}