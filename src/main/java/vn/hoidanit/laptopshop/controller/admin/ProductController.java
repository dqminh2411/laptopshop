package vn.hoidanit.laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.FileService;

@Controller
public class ProductController {

    private final ProductService productService;
    private final FileService fileService;

    public ProductController(ProductService productService, FileService fileService) {
        this.productService = productService;
        this.fileService = fileService;
    }

    @GetMapping("/admin/product")
    public String getProductsPage(Model model) {
        model.addAttribute("products", this.productService.getAllProducts());
        return "admin/product/show";
    }

    @GetMapping("/admin/product/create")
    public String getCreateProductPage(Model model) {
        model.addAttribute("newProduct", new Product());
        return "admin/product/create";
    }

    @PostMapping("/admin/product/create")
    public String createProduct(@ModelAttribute("newProduct") @Valid Product newProduct, BindingResult bindingResult,
            @RequestParam("productImage") MultipartFile productImage) {
        if (bindingResult.hasErrors()) {
            for (FieldError e : bindingResult.getFieldErrors()) {
                System.out.println(e.getField() + ":" + e.getDefaultMessage());
            }

            return "/admin/product/create";
        }
        newProduct.setSold(0);
        newProduct.setImage(this.fileService.handleSaveUploadFile(productImage, "products"));
        this.productService.saveProduct(newProduct);
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/{id}")
    public String getProductDetail(Model model, @PathVariable("id") long id) {
        Product product = this.productService.getProductById(id);
        model.addAttribute("product", product);
        model.addAttribute("productImageSrc", this.productService.getProductImageSrc(product.getImage()));
        return "admin/product/detail";
    }

    @GetMapping("/admin/product/update/{id}")
    public String getUpdateProductPage(Model model, @PathVariable("id") long id) {
        Product product = this.productService.getProductById(id);
        model.addAttribute("product", product);
        model.addAttribute("productImageSrc", this.productService.getProductImageSrc(product.getImage()));

        return "admin/product/update";
    }

    @PostMapping("/admin/product/update")
    public String updateProduct(@ModelAttribute("product") @Valid Product product, BindingResult bindingResult,
            @RequestParam("productImage") MultipartFile productImg) {

        // validate
        if (bindingResult.hasErrors()) {
            return "admin/product/update";
        }

        Product updatedProduct = this.productService.getProductById(product.getId());
        if (updatedProduct != null) {
            if (!productImg.isEmpty()) {
                this.fileService.deleteImageFile(updatedProduct.getImage(), "products");
                updatedProduct.setImage(this.fileService.handleSaveUploadFile(productImg, "products"));
            }
            updatedProduct.setDetailDesc(product.getDetailDesc());
            updatedProduct.setFactory(product.getFactory());
            updatedProduct.setName(product.getName());
            updatedProduct.setPrice(product.getPrice());
            updatedProduct.setQuantity(product.getQuantity());
            updatedProduct.setShortDesc(product.getShortDesc());
            updatedProduct.setTarget(product.getTarget());
            this.productService.saveProduct(updatedProduct);
        }
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/delete/{id}")
    public String getDeleteProductPage(Model model, @PathVariable("id") long id) {
        model.addAttribute("product", this.productService.getProductById(id));
        return "admin/product/delete";
    }

    @PostMapping("/admin/product/delete")
    public String deleteProduct(@ModelAttribute("product") Product deletedProduct) {
        this.productService.deleteProduct(deletedProduct.getId());
        return "redirect:/admin/product";
    }
}
