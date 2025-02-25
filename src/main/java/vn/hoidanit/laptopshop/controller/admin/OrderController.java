package vn.hoidanit.laptopshop.controller.admin;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.service.OrderService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class OrderController {
    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/admin/order")
    public String getOrdersPage(Model model, @RequestParam("page") Optional<String> pageOptional) {
        int pageNo = 1;
        try {
            if (pageOptional.isPresent()) {
                pageNo = Integer.parseInt(pageOptional.get());
            }
        } catch (Exception e) {
        }
        int pageSize = 5;
        Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
        Page<Order> page = this.orderService.getAllOrders(pageable);

        model.addAttribute("orders", page.getContent());
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("currentPage", pageNo);

        return "admin/order/show";
    }

    @GetMapping("/admin/order/{id}")
    public String getOrderDetail(@PathVariable("id") long id, Model model) {
        Order order = this.orderService.getOrderById(id);
        if (order != null) {
            model.addAttribute("order", order);
        }
        return "admin/order/detail";
    }

    @GetMapping("/admin/order/update/{id}")
    public String getOrderUpdatePage(@PathVariable("id") long id, Model model) {
        Order order = this.orderService.getOrderById(id);
        if (order != null) {
            model.addAttribute("order", order);
        }
        return "admin/order/update";
    }

    @PostMapping("/admin/order/update")
    public String updateOrder(@RequestParam("id") long id, @RequestParam("status") String status,
            RedirectAttributes redirectAttributes) {
        this.orderService.updateOrder(id, status);
        redirectAttributes.addFlashAttribute("message", "Cập nhật trạng thái đơn hàng thành công");
        return "redirect:/admin/order/update/" + id;
    }

    @GetMapping("/admin/order/delete/{id}")
    public String getDeleteOrderPage(@PathVariable("id") long id, Model model) {
        Order order = this.orderService.getOrderById(id);
        if (order != null) {
            model.addAttribute("order", order);
        }
        return "admin/order/delete";
    }

    @PostMapping("/admin/order/delete")
    public String deleteOrder(@ModelAttribute("order") Order order, RedirectAttributes redirectAttributes) {
        if (order != null) {
            this.orderService.deleteOrderById(order.getId());
            redirectAttributes.addFlashAttribute("message", "Bạn xoá đơn hàng thành công");
        }
        return "redirect:/admin/order";
    }
}
