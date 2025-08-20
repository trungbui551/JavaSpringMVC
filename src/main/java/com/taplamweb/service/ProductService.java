package com.taplamweb.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.taplamweb.domain.Cart;
import com.taplamweb.domain.CartDetail;
import com.taplamweb.domain.Product;
import com.taplamweb.domain.User;
import com.taplamweb.repository.CartDetailRepository;
import com.taplamweb.repository.CartRepository;
import com.taplamweb.repository.ProductRepository;

import jakarta.servlet.http.HttpSession;

@Service
public class ProductService {
    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;

    public ProductService(ProductRepository productRepository, CartRepository cartRepository,
            CartDetailRepository cartDetailRepository, UserService userService) {
        this.productRepository = productRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.userService = userService;
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

    public void handleAddProductToCart(String email, Long proId, HttpSession session) {
        User user = this.userService.getUserByEmail(email);
        if (user != null) {
            // check user da co cart hay chua
            Cart cart = this.cartRepository.findByUser(user);
            if (cart == null) {
                // tao moi card
                Cart meCart = new Cart();
                meCart.setId(proId);
                meCart.setUser(user);
                meCart.setSum(0);
                cart = this.cartRepository.save(meCart);

            }

            // save card detail

            // Find productById
            Optional<Product> productOp = this.productRepository.findById(proId);
            if (productOp.isPresent()) {
                Product product = productOp.get();
                // check san pham da tung duoc them vao gio hang day hay chua
                CartDetail oldCartDetail = this.cartDetailRepository.findByCartAndProduct(cart, product);
                if (oldCartDetail == null) {
                    oldCartDetail = new CartDetail();
                    oldCartDetail.setCart(cart);
                    oldCartDetail.setProduct(product);
                    oldCartDetail.setPrice(product.getPrice());
                    oldCartDetail.setQuantity(1);
                    int s = cart.getSum() + 1;

                    cart.setSum(s);

                    this.cartRepository.save(cart);
                    this.cartDetailRepository.save(oldCartDetail);
                    session.setAttribute("sum", s);
                } else {
                    oldCartDetail.setQuantity(oldCartDetail.getQuantity() + 1);
                    this.cartDetailRepository.save(oldCartDetail);
                }

            }

        }
    }

    public Cart getCartByUser(User user) {
        return this.cartRepository.findByUser(user);
    }

    public List<CartDetail> getCartDetailsByCart(Cart cart) {
        return this.cartDetailRepository.findByCart(cart);
    }
}
