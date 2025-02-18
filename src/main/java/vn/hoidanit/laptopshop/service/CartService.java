package vn.hoidanit.laptopshop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.CartDetailRepository;
import vn.hoidanit.laptopshop.repository.CartRepository;

@Service
public class CartService {
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;

    public CartService(CartRepository cartRepository, CartDetailRepository cartDetailRepository) {
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
    }

    public Cart getCartByUser(User user) {
        return this.cartRepository.findByUser(user);
    }

    public void deleteCartDetail(long id, HttpSession session) {
        CartDetail cartDetail = this.cartDetailRepository.findById(id);
        if (cartDetail == null) {
            return;
        }
        this.cartDetailRepository.deleteById(id);
        // update cart sum
        Cart cart = cartDetail.getCart();
        if (cart != null) {
            cart.setSum(cart.getSum() - 1);
            this.cartRepository.save(cart);
            session.setAttribute("cartSum", cart.getSum());
        }
    }

}
