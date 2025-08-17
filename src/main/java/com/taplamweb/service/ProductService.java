package com.taplamweb.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.taplamweb.domain.Product;
import com.taplamweb.domain.User;
import com.taplamweb.repository.ProductRepository;

@Service
public class ProductService {
    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;

    }

    public Product handleSaveProduct(Product product) {
        Product newProduct = this.productRepository.save(product);
        return newProduct;
    }

    public List<Product> getAllProducts() {
        return this.productRepository.findAll();
    }

    public Product getProductById(long id) {
        return this.productRepository.findById(id);
    }
}
