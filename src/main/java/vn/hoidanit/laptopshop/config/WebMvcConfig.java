package vn.hoidanit.laptopshop.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@Configuration
@EnableWebMvc
public class WebMvcConfig implements WebMvcConfigurer {
    @Bean
    public ViewResolver viewResolver() {
        final InternalResourceViewResolver bean = new InternalResourceViewResolver();
        bean.setViewClass(JstlView.class);
        bean.setPrefix("/WEB-INF/view/");
        bean.setSuffix(".jsp");
        bean.setOrder(1);
        return bean;
    }

    // @Bean
    // public ViewResolver htmViewResolver() {
    // final InternalResourceViewResolver bean = new InternalResourceViewResolver();
    // bean.setPrefix("/WEB-INF/view/");
    // bean.setSuffix(".html");
    // bean.setOrder(2);
    // return bean;
    // }

    // @Override
    // public void addResourceHandlers(ResourceHandlerRegistry registry) {
    // registry.addResourceHandler("/WEB-INF/view/**").addResourceLocations("/WEB-INF/view/");
    // }

    // may be not needed
    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.viewResolver(viewResolver());
        // registry.viewResolver(htmViewResolver());
    }

    @Override
    // Spring understands /resources = /webapp/resources
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // an url with pattern "/css/**" will access resources from "/resources/css/"

        registry.addResourceHandler("/css/**").addResourceLocations("/resources/css/");
        registry.addResourceHandler("/images/**").addResourceLocations("/resources/images/");
    }
}
