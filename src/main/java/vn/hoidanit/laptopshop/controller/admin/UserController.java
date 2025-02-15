package vn.hoidanit.laptopshop.controller.admin;

import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.UserRepository;

import java.util.Optional;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.hoidanit.laptopshop.service.FileService;
import vn.hoidanit.laptopshop.service.UserService;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletContext;
import jakarta.validation.Valid;

@Controller
public class UserController {
    private final UserService userService;
    private final FileService fileService;
    private final PasswordEncoder passwordEncoder;

    public UserController(UserService userService, FileService fileService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.fileService = fileService;
        this.passwordEncoder = passwordEncoder;
    }

    @RequestMapping("/admin/user")
    public String getUsersTablePage(Model model) {
        model.addAttribute("users", this.userService.getAllUsers());
        return "admin/user/show";
    }

    @GetMapping("/admin/user/create")
    public String getCreateUserPage(Model model) {
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    @PostMapping(value = "/admin/user/create")
    public String createUserPage(Model model,
            @ModelAttribute("newUser") @Valid User newUser,
            BindingResult bindingResult,
            @RequestParam("avatarFile") MultipartFile avatarFile) {
        // validate
        if (bindingResult.hasErrors()) {
            for (FieldError e : bindingResult.getFieldErrors()) {
                System.out.println(e.getObjectName() + "-" + e.getField() + ":" + e.getDefaultMessage());
            }
            return "admin/user/create";
        }

        String avatarFileName = this.fileService.handleSaveUploadFile(avatarFile, "avatars");
        String hashedPassword = this.passwordEncoder.encode(newUser.getPassword());

        newUser.setAvatar(avatarFileName);
        newUser.setPassword(hashedPassword);
        newUser.setRole(this.userService.getRoleByName(newUser.getRole().getName()));
        // System.out.println("new User: " + newUser);// newUser has id = 0 although in
        // DB the id is an auto-incremented
        // positive value.
        // when id=0 or id = null, it means a new user is saved to DB
        User savedUser = this.userService.handleSaveUser(newUser);
        // this savedUser has the id in DB
        // System.out.println(savedUser);
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/{id}")
    public String getUserDetail(Model model, @PathVariable long id) {
        User user = this.userService.getUserById(id);
        model.addAttribute("user", user);
        return "admin/user/detail";
    }

    @GetMapping("/admin/user/update/{id}")
    public String getUpdateUserPage(Model model, @PathVariable long id) {
        User user = this.userService.getUserById(id);
        model.addAttribute("user", user);
        return "admin/user/update";
    }

    @PostMapping(value = "/admin/user/update")
    public String updateUser(@ModelAttribute("user") User user) {
        User updatedUser = this.userService.getUserById(user.getId());
        if (updatedUser != null) {
            updatedUser.setAddress(user.getAddress());
            updatedUser.setFullName(user.getFullName());
            updatedUser.setPhone(user.getPhone());
            updatedUser.setAvatar(user.getAvatar());
            updatedUser.setRole(this.userService.getRoleByName(user.getRole().getName()));

            this.userService.handleSaveUser(updatedUser);
        }
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/delete/{id}")
    public String getDeleteUserPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("deletedUser", new User());
        return "admin/user/delete";
    }

    @PostMapping("/admin/user/delete")
    public String deleteUser(@ModelAttribute("deletedUser") User deletedUser) {
        this.userService.deleteUserById(deletedUser.getId());
        return "redirect:/admin/user";
    }
}
