package vn.hoidanit.laptopshop.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderDetail;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.CartDetailRepository;
import vn.hoidanit.laptopshop.repository.CartRepository;
import vn.hoidanit.laptopshop.repository.OrderDetailRepository;
import vn.hoidanit.laptopshop.repository.OrderRepository;

@Service
public class CartService {
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public CartService(CartRepository cartRepository, CartDetailRepository cartDetailRepository,
            OrderDetailRepository orderDetailRepository, OrderRepository orderRepository) {
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
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

    public void updateCartDetailsBeforeCheckout(List<CartDetail> cartDetails) {
        for (CartDetail cd : cartDetails) {
            CartDetail oldCartDetail = this.cartDetailRepository.findById(cd.getId());
            if (oldCartDetail != null) {
                oldCartDetail.setQuantity(cd.getQuantity());
                this.cartDetailRepository.save(oldCartDetail);
            }
        }
    }

    public void handlePlaceOrder(Order order, HttpSession session) {
        // get User and Cart

        User user = new User();
        long id = (long) session.getAttribute("id");
        user.setId(id);

        Cart cart = this.cartRepository.findByUser(user);
        // set Order's properties
        order.setUser(user);
        order.setOrderTime(LocalDateTime.now());
        order.setStatus("PENDING");
        // no need to set List<OrderDetail> for Order

        // set OrderDetails
        if (cart != null) {
            List<CartDetail> cartDetails = cart.getCartDetails();
            if (cartDetails != null) {
                double totalPrice = 0;
                for (CartDetail cd : cartDetails) {
                    totalPrice += cd.getQuantity() * cd.getProduct().getPrice();
                }
                order.setTotalPrice(totalPrice);
                order = this.orderRepository.save(order);
                // create order detail
                for (CartDetail cd : cartDetails) {
                    OrderDetail od = new OrderDetail();
                    od.setOrder(order);
                    od.setProduct(cd.getProduct());
                    od.setQuantity(cd.getQuantity());
                    this.orderDetailRepository.save(od);
                }

                // delete cart detail
                for (CartDetail cd : cartDetails) {
                    this.cartDetailRepository.deleteById(cd.getId());
                }
                // update sum, cartdetails for Cart
                cart.setSum(0);
                cart.setCartDetails(new ArrayList<CartDetail>());
                this.cartRepository.save(cart);
                // this.cartRepository.deleteById(cart.getId());
                // update cart Sum
                session.setAttribute("cartSum", 0);
            }
        }
    }
}
