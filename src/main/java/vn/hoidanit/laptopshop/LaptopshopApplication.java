package vn.hoidanit.laptopshop;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

// @SpringBootApplication
@SpringBootApplication(exclude = org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class)
public class LaptopshopApplication {

	public static void main(String[] args) {
		ApplicationContext appCon = SpringApplication.run(LaptopshopApplication.class, args);
		// int cnt = 0;
		// System.out.println("List of Beans:");
		// for (String s : appCon.getBeanDefinitionNames()) {
		// 	System.out.println(s);
		// 	++cnt;
		// }
		// System.out.println(cnt);
	}

}
