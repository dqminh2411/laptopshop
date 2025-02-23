package vn.hoidanit.laptopshop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.CartDetailRepository;
import vn.hoidanit.laptopshop.repository.CartRepository;
import vn.hoidanit.laptopshop.repository.ProductRepository;

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

    public void saveProduct(Product product) {
        this.productRepository.save(product);
    }

    public List<Product> getAllProducts() {
        return this.productRepository.findAll();
    }

    public Product getProductById(long id) {
        return this.productRepository.findById(id);
    }

    public String getProductImageSrc(String imageName) {
        if (imageName == "")
            return "";
        return "/images/products/" + imageName;
    }

    public void deleteProduct(long id) {
        this.productRepository.deleteById(id);
    }

    public void addProductToCart(long productId, String email, int quantity, HttpSession session) {

        User user = this.userService.getUserByEmail(email);
        if (user != null) {
            // check if user's cart exists
            Cart cart = this.cartRepository.findByUser(user);
            if (cart == null) {
                Cart newCart = new Cart();
                newCart.setUser(user);
                newCart.setSum(0);
                cart = this.cartRepository.save(newCart);
            }
            // save cart details

            Product product = this.productRepository.findById(productId);
            if (product != null) {
                // check if the product is already in cart
                CartDetail cartDetail = this.cartDetailRepository.findByCartAndProduct(cart, product);
                if (cartDetail == null) {
                    cartDetail = new CartDetail();
                    cartDetail.setCart(cart);
                    cartDetail.setProduct(product);
                    cartDetail.setQuantity(quantity);
                    // update cart sum
                    cart.setSum(cart.getSum() + 1);
                    this.cartRepository.save(cart);

                    // set cartSum to session
                    session.setAttribute("cartSum", cart.getSum());
                } else {
                    cartDetail.setQuantity(cartDetail.getQuantity() + quantity);
                }

                this.cartDetailRepository.save(cartDetail);

            }
        }
    }

}
