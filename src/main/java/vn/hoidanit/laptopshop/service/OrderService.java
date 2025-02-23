package vn.hoidanit.laptopshop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderDetail;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.OrderDetailRepository;
import vn.hoidanit.laptopshop.repository.OrderRepository;

@Service
public class OrderService {
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public OrderService(OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    public List<Order> getAllOrders() {
        return this.orderRepository.findAll();
    }

    public Order getOrderById(long id) {
        return this.orderRepository.findById(id);
    }

    public void updateOrder(long id, String status) {
        Order order = this.orderRepository.findById(id);
        if (order != null) {
            order.setStatus(status);
            this.orderRepository.save(order);
        }
    }

    public void deleteOrderById(long id) {
        Order order = this.orderRepository.findById(id);
        if (order != null) {
            // delete order details
            List<OrderDetail> orderDetails = order.getOrderDetails();
            if (orderDetails != null) {
                for (OrderDetail od : orderDetails) {
                    this.orderDetailRepository.deleteById(od.getId());
                }
            }
            this.orderRepository.deleteById(order.getId());
        }

    }

    public List<Order> getOrdersByUser(User user) {
        return this.orderRepository.findByUser(user);
    }
}
