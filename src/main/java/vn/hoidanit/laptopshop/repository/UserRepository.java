package vn.hoidanit.laptopshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Repository;

import vn.hoidanit.laptopshop.domain.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    // User save(User user);
    List<User> findAllByEmail(String email);

    User findById(long id);

    void deleteById(long id);

    boolean existsByEmail(String email);

    User findByEmail(String email);

    @NonNull
    Page<User> findAll(@NonNull Pageable pageable);
}
