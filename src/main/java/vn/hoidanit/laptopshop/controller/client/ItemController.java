package vn.hoidanit.laptopshop.controller.client;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.service.CartService;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class ItemController {
    private final ProductService productService;
    private final CartService cartService;
    private final UserService userService;

    public ItemController(ProductService productService, CartService cartService, UserService userService) {
        this.productService = productService;
        this.cartService = cartService;
        this.userService = userService;
    }

    @GetMapping("/product/{id}")
    public String getProductDetail(Model model, @PathVariable("id") long id) {
        model.addAttribute("product", this.productService.getProductById(id));
        return "client/product/detail";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable("id") long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        this.productService.addProductToCart(id, email, session);
        return "redirect:/";
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        User user = new User();
        long userId = (long) session.getAttribute("id");
        user.setId(userId);
        Cart cart = this.cartService.getCartByUser(user);
        List<CartDetail> cartDetails = cart.getCartDetails();

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice = cd.getProduct().getPrice() * cd.getQuantity();
        }
        model.addAttribute("cartProducts", cart == null ? new ArrayList<CartDetail>() : cartDetails);
        model.addAttribute("totalPrice", totalPrice);

        return "client/cart/show";
    }

    @PostMapping("/cart/delete-product/{id}")
    public String deleteProductFromCart(@PathVariable("id") long cartDetailId, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        this.cartService.deleteCartDetail(cartDetailId, session);
        return "redirect:/cart";
    }

}
