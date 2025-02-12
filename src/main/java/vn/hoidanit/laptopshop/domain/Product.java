package vn.hoidanit.laptopshop.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Positive;

@Entity
@Table(name = "products")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @NotBlank(message = "Tên sản phẩm không đc để trống")
    private String name;

    private String image;

    @NotBlank(message = "Mô tả ngắn không đc để trống")
    private String shortDesc;
    @NotBlank(message = "Mô tả không đc để trống")
    @Column(columnDefinition = "MEDIUMTEXT")
    private String detailDesc;

    @NotBlank(message = "Nhà sản xuất không đc để trống")

    private String factory;

    @NotBlank(message = "Mục đích không đc để trống")
    private String target;

    @Positive(message = "số lượng phải lớn hơn 0")
    private long quantity;

    private long sold;

    @Positive(message = "Giá cả phải lớn hơn 0")
    private double price;

    // not necessary
    // @OneToMany(mappedBy = "product")
    // private List<OrderDetail> orderDetails;

    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getImage() {
        return image;
    }

    public String getShortDesc() {
        return shortDesc;
    }

    public String getDetailDesc() {
        return detailDesc;
    }

    public String getFactory() {
        return factory;
    }

    public String getTarget() {
        return target;
    }

    public long getQuantity() {
        return quantity;
    }

    public long getSold() {
        return sold;
    }

    public double getPrice() {
        return price;
    }

    public void setId(long id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public void setShortDesc(String shortDesc) {
        this.shortDesc = shortDesc;
    }

    public void setDetailDesc(String detailDesc) {
        this.detailDesc = detailDesc;
    }

    public void setFactory(String factory) {
        this.factory = factory;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public void setQuantity(long quantity) {
        this.quantity = quantity;
    }

    public void setSold(long sold) {
        this.sold = sold;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Product [id=" + id + ", name=" + name + ", image=" + image + ", shortDesc=" + shortDesc
                + ", detailDesc=" + detailDesc + ", factory=" + factory + ", target=" + target + ", quantity="
                + quantity + ", sold=" + sold + ", price=" + price + "]";
    }

}