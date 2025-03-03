package vn.hoidanit.laptopshop.controller.client;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.Product_;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.domain.dto.ProductCriteriaDTO;
import vn.hoidanit.laptopshop.service.CartService;
import vn.hoidanit.laptopshop.service.ProductService;

@Controller
public class ItemController {
    private final ProductService productService;
    private final CartService cartService;

    public ItemController(ProductService productService, CartService cartService) {
        this.productService = productService;
        this.cartService = cartService;
    }

    @GetMapping("/product/{id}")
    public String getProductDetail(Model model, @PathVariable("id") long id) {
        model.addAttribute("product", this.productService.getProductById(id));
        return "client/product/detail";
    }

    @PostMapping("/add-product-to-cart")
    public String addProductToCart(@RequestParam("id") long id, @RequestParam("quantity") int quantity,
            @RequestParam("srcPage") String srcPage,
            HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");

        this.productService.addProductToCart(id, email, quantity, session);

        if (srcPage.equals("/"))
            return "redirect:/";
        return "redirect:/product/" + id;

    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        User user = new User();
        long userId = (long) session.getAttribute("id");
        user.setId(userId);
        Cart cart = this.cartService.getCartByUser(user);
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getProduct().getPrice() * cd.getQuantity();
        }
        model.addAttribute("cartProducts", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("cart", cart);
        return "client/cart/show";
    }

    @PostMapping("/cart/delete-product/{id}")
    public String deleteProductFromCart(@PathVariable("id") long cartDetailId, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        this.cartService.deleteCartDetail(cartDetailId, session);
        return "redirect:/cart";
    }

    @PostMapping("/confirm-checkout")
    public String checkout(@ModelAttribute("cart") Cart cart) {
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        this.cartService.updateCartDetailsBeforeCheckout(cartDetails);
        return "redirect:/checkout";
    }

    @GetMapping("/checkout")
    public String getCheckoutPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User user = new User();
        user.setId((long) session.getAttribute("id"));
        Cart cart = this.cartService.getCartByUser(user);
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getProduct().getPrice() * cd.getQuantity();
        }
        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("order", new Order());
        return "client/cart/checkout";
    }

    @PostMapping("/place-order")
    public String placeOrder(@ModelAttribute("order") Order order, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        this.cartService.handlePlaceOrder(order, session);
        return "redirect:/order-success";
    }

    @GetMapping("/order-success")
    public String getOrderSuccessPage() {
        return "client/cart/order-success";
    }

    @GetMapping("/products")
    public String getProductsPage(Model model, ProductCriteriaDTO productCriteriaDTO, HttpServletRequest request) {
        int pageNo = 1;
        try {
            if (productCriteriaDTO.getPage() != null) {
                pageNo = Integer.parseInt(productCriteriaDTO.getPage());
            }
        } catch (Exception e) {
        }
        int pageSize = 6;
        Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
        if (productCriteriaDTO.getSort() != null) {
            String sort = productCriteriaDTO.getSort();
            if (sort.equals("gia-tang-dan")) {
                pageable = PageRequest.of(pageNo - 1, pageSize, Sort.by(Product_.PRICE).ascending());
            } else if (sort.equals("gia-giam-dan")) {
                pageable = PageRequest.of(pageNo - 1, pageSize, Sort.by(Product_.PRICE).descending());
            }
        }
        // Double minPrice = minPriceOptional.isPresent() ? minPriceOptional.get() : 0;
        // Double maxPrice = maxPriceOptional.isPresent() ? maxPriceOptional.get() :
        // 1000000000;
        // List<List<Double>> prices = new ArrayList<>();
        // prices.add(new ArrayList<Double>(List.of(0d, 1000000000d)));
        // if (priceOptional.isPresent()) {
        // List<String> a = priceOptional.get();
        // prices.clear();
        // double UNIT = 1000000;
        // for (String s : a) {
        // String[] tk = s.split("-");
        // prices.add(new ArrayList<Double>(
        // List.of(Double.parseDouble(tk[0]) * UNIT, Double.parseDouble(tk[2]) *
        // UNIT)));
        // }
        // }
        // List<String> makes = makeOptional.isPresent() ? makeOptional.get() : new
        // ArrayList<String>();
        // Page<Product> page = this.productService.getAllProductsWithSpec(pageable,
        // name);
        Page<Product> page = this.productService.getAllProductsWithSpec(pageable,
                productCriteriaDTO);

        // Page<Product> page = this.productService.getAllProducts(pageable);
        String qs = request.getQueryString();
        if (qs != null || !qs.isEmpty()) {
            qs.replace("page=" + pageNo, "");
        }
        model.addAttribute("products", page.getContent());
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("queryString", qs);

        return "client/product/show";
    }

    @GetMapping("/test")
    public String test(@RequestParam("tval") List<String> tval) {
        return "client/homepage/show";
    }

    @GetMapping("/test1")
    public String test1() {
        return "hello";
    }

}
