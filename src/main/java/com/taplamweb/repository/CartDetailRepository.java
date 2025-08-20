package com.taplamweb.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.taplamweb.domain.Cart;
import com.taplamweb.domain.CartDetail;
import com.taplamweb.domain.Product;
import java.util.List;

@Repository
public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {
    boolean existsByCartAndProduct(Cart cart, Product product);

    List<CartDetail> findByCart(Cart cart);

    CartDetail findByCartAndProduct(Cart cart, Product product);
}
