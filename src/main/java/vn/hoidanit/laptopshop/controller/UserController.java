package vn.hoidanit.laptopshop.controller;

import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.UserRepository;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class UserController {
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping("/")
    public String getHomePage(Model model) {
        String test = this.userService.handleHello();
        model.addAttribute("helloString", test);
        System.out.println("First user by email:");
        System.out.println(this.userService.getFirstUserByEmail("nklinh@gmail.com"));

        System.out.println("All users by email:");
        System.out.println(this.userService.getAllUsersByEmail("nklinh@gmail.com"));

        return "hello";
    }

    @RequestMapping("/admin/user")
    public String getUsersTablePage() {
        return "admin/user/users-table";
    }

    @RequestMapping("/admin/user/create")
    public String getCreateUserPage(Model model) {
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    @RequestMapping(value = "/admin/user/create", method = RequestMethod.POST)
    public String createUserPage(Model model, @ModelAttribute("newUser") User newUser) {
        // System.out.println("new User: " + newUser);// newUser has id = 0 although in
        // DB the id is an auto-incremented
        // positive value.
        // when id=0 or id = null, it means a new user is saved to DB
        User savedUser = this.userService.handleSaveUser(newUser);
        // this savedUser has the id in DB
        // System.out.println(savedUser);
        return "hello";
    }
}
