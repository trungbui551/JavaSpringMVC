package com.taplamweb.repository;

import org.springframework.stereotype.Repository;
import com.taplamweb.domain.Product;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    Product save(Product product);

    Product findById(long id);
}
