package vn.hoidanit.laptopshop.service.specification;

import java.util.ArrayList;
import java.util.List;

import org.springframework.boot.autoconfigure.rsocket.RSocketProperties.Server.Spec;
import org.springframework.data.jpa.domain.Specification;

import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaBuilder.In;
import jakarta.persistence.criteria.Expression;
import jakarta.persistence.criteria.Predicate;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.Product_;

public class ProductSpecs {
    // public static Specification<Product> nameLike(String name) {
    // return (root, query, criteriaBuilder) ->
    // criteriaBuilder.like(root.get(Product_.NAME), "%" + name + "%");
    // }

    // public static Specification<Product> priceGE(double minPrice) {
    // return (root, query, criteriaBuilder) ->
    // criteriaBuilder.ge(root.get(Product_.PRICE),
    // minPrice);
    // }

    // public static Specification<Product> priceLE(double maxPrice) {
    // return (root, query, criteriaBuilder) ->
    // criteriaBuilder.le(root.get(Product_.PRICE), maxPrice);
    // }

    // public static Specification<Product> priceBetween(List<List<Double>> prices)
    // {
    // return (root, query, criteriaBuilder) -> {
    // if(prices == null || prices.isEmpty()){
    // return criteriaBuilder.conjunction();
    // }
    // Predicate[] predicates = new Predicate[prices.size()];
    // for (int i = 0; i < prices.size(); i++) {
    // predicates[i] = criteriaBuilder.between(root.get(Product_.PRICE),
    // prices.get(i).get(0),
    // prices.get(i).get(1));
    // }
    // return criteriaBuilder.or(predicates);
    // };
    // }
    public static Specification<Product> priceBetween(List<String> prices) {
        if (prices == null || prices.isEmpty())
            return Specification.where(null);
        return (root, query, criteriaBuilder) -> {
            Predicate disjunctPredicate = criteriaBuilder.disjunction();
            for (String p : prices) {
                switch (p) {
                    case "tren-20-trieu":
                        disjunctPredicate = criteriaBuilder.or(
                                criteriaBuilder.greaterThan(root.get(Product_.PRICE), 20000000d), disjunctPredicate);
                        break;
                    case "15-20-trieu":
                        disjunctPredicate = criteriaBuilder.or(
                                criteriaBuilder.between(root.get(Product_.PRICE), 15000000d, 20000000d),
                                disjunctPredicate);
                        break;
                    case "10-15-trieu":
                        disjunctPredicate = criteriaBuilder.or(
                                criteriaBuilder.between(root.get(Product_.PRICE), 10000000d, 15000000d),
                                disjunctPredicate);
                        break;
                    case "duoi-10-trieu":
                        disjunctPredicate = criteriaBuilder
                                .or(criteriaBuilder.lessThan(root.get(Product_.PRICE), 10000000d), disjunctPredicate);
                        break;
                }
            }
            return disjunctPredicate;
        };

    }
    // public static Specification<Product> fromMake(String make) {
    // return (root, query, criteriaBuilder) ->
    // criteriaBuilder.equal(root.get(Product_.FACTORY), make);

    // }

    public static Specification<Product> fromMakes(List<String> makes) {
        return (root, query, criteriaBuilder) -> {
            if (makes == null || makes.isEmpty())
                return criteriaBuilder.conjunction();
            return criteriaBuilder.in(root.get(Product_.FACTORY)).value(makes);
            // In<Object> extends Predicate
        };

    }

    public static Specification<Product> withTargets(List<String> targets) {
        return (root, query, criteriaBuilder) -> {
            if (targets == null || targets.isEmpty())
                return criteriaBuilder.conjunction();
            return criteriaBuilder.in(root.get(Product_.TARGET)).value(targets);
        };
    }
    // public static Specification<Product> fromMake(String make, List<String>
    // makes){
    // return (root, query, criteriaBuilder) -> criteriaBuilder.in(make);
    // }
}
