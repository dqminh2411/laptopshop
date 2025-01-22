package vn.hoidanit.laptopshop;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;

@RestController
public class HelloController {
    @GetMapping("/")
    public String index() {
        return "Hello World from Spring Boot! I'm Minh";
    }

    @GetMapping("/user")
    public String getUserPage() {
        return "this is user page";
    }

    @GetMapping("/admin")
    public String getAdminPage() {
        return "this is admin page";
    }
}
