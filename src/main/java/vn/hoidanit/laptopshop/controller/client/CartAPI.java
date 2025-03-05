package vn.hoidanit.laptopshop.controller.client;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.service.ProductService;

class CartRequestDTO {
    private int quantity;
    private long productId;

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public long getProductId() {
        return productId;
    }

    public void setProductId(long productId) {
        this.productId = productId;
    }

}

@RestController
public class CartAPI {
    private final ProductService productService;

    public CartAPI(ProductService productService) {
        this.productService = productService;
    }

    @PostMapping("/api/add-product-to-cart")
    public ResponseEntity<Integer> addProductToCart(@RequestBody() CartRequestDTO cartRequestDTO,
            HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        this.productService.addProductToCart(cartRequestDTO.getProductId(), (String) session.getAttribute("email"),
                cartRequestDTO.getQuantity(), session);
        int sum = (int) session.getAttribute("cartSum");
        System.out.println("sum=" + sum);
        return ResponseEntity.ok().body(sum);

    }
}
