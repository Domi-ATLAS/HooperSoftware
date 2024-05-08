/* package HooperSoftware.TFG.configuration;

import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfiguration;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.User.UserBuilder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import javax.sql.DataSource;


@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig extends WebSecurityConfiguration{
    
    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
        http
		.authorizeHttpRequests((authorize) -> authorize
			.requestMatchers("/resources/**","/webjars/**","/h2-console/**","/css/**","/fonts/**","/images/**","/autocomplete/**","/js/**","/stand/**","/start/**","/statistics/**","/","/welcome","/webapp/**","/WEB-INF/**","/lobby","/manual/**").permitAll()
            .requestMatchers("/login/**").permitAll()
            .requestMatchers("/players/new/**").permitAll()
            .requestMatchers("/h2-console/**").permitAll()
            .requestMatchers("/game/onlineGame/**").authenticated()
            .requestMatchers("/game/**").permitAll()
            .requestMatchers("/administration/**").hasAuthority("admin")
            .requestMatchers("/players/profile/**","/players/edit","/players/changePassword").authenticated()
            .requestMatchers("/statistics/**").permitAll()
			.anyRequest().denyAll()
		)
		.formLogin(login -> login
                .loginPage("/login")
				.defaultSuccessUrl("/")
				.permitAll()
                .failureUrl("/login?error=true"))
		.logout(logout -> logout
            .logoutRequestMatcher(new AntPathRequestMatcher("/logout")) 
            .invalidateHttpSession(true) 
            .deleteCookies("JSESSIONID") 
            .logoutSuccessUrl("/welcome")
            .permitAll()); 
        return http.build();
    }

    @Bean
	PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
	}
	
    @Bean
    UserDetailsManager jdbcUserDetailsManager(DataSource dataSource) {
        JdbcUserDetailsManager userDetailsManager = new JdbcUserDetailsManager(dataSource);
        userDetailsManager.setUsersByUsernameQuery("select username, password, enabled from player where username = ?");
        userDetailsManager.setAuthoritiesByUsernameQuery("select username, authority from authorities where username = ?");
        return userDetailsManager;
    }

    
    protected void configure(AuthenticationManagerBuilder auth) throws Exception{

        UserBuilder users = User.withDefaultPasswordEncoder();

        auth.inMemoryAuthentication()
            .withUser("user").password("1234").roles("USER")
            .and()
            .withUser("admin").password("1234").roles("USER", "ADMIN");
    }

    protected void configure(HttpSecurity http) throws Exception{

        http.authorizeRequests().anyRequest().authenticated()
            .and()
            .formLogin()
            .loginPage("/login")
            .loginProcessingUrl("/welcome")
            .permitAll()
            .and()
            .logout()
            .permitAll();
    }

}
 */