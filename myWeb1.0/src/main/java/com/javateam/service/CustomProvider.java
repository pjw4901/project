/**
 * 
 */
package com.javateam.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import com.javateam.vo.Role;
import com.javateam.vo.SecUser;

/**
 * @author ss
 *
 */

@Component
public class CustomProvider implements AuthenticationProvider, UserDetailsService {

	private static final Logger logger = LoggerFactory.getLogger(CustomProvider.class);
	
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public void setDataSource(DataSource dataSource){
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	@Override
	public SecUser loadUserByUsername(String userid){
		
		try{
			return (SecUser)jdbcTemplate.queryForObject("SELECT * FROM users WHERE userid=?",
														new Object[]{userid},
														new BeanPropertyRowMapper<SecUser>(SecUser.class));
		}catch(EmptyResultDataAccessException e){
			System.out.println("loaduserbyusername error");
			return null;
		}
		
		
		
	}
	
	private Role loadUserRole(String userid){
		try{
			return (Role)jdbcTemplate.queryForObject("SELECT user_id, role FROM users_role WHERE user_id=?",
													  new Object[]{userid},
													  new BeanPropertyRowMapper<Role>(Role.class));
		}catch(EmptyResultDataAccessException e){
			System.out.println("loaduserRole error !");
			return null;
			
		}
		
		
		
	}
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String username = authentication.getName();
		String password = (String) authentication.getCredentials();
		
		SecUser user = null;
		Collection<? extends GrantedAuthority> authorityes = null;
		
		try{
			user = this.loadUserByUsername(username);
			Role role = this.loadUserRole(username);
			
			List<Role> roles = new ArrayList<Role>();
			roles.add(role);
			user.setAuthorities(roles);
			
			BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
			
			if(passwordEncoder.matches(password, user.getPassword()))
				System.out.println("비밀번호 일치 ! ");
			else
				throw new BadCredentialsException("비밀번호가 일치하지 않습니다.");
			
			authorityes = user.getAuthorities();
			
		} catch(UsernameNotFoundException e) {
            logger.info(e.toString());
            throw new UsernameNotFoundException(e.getMessage());
        } catch(BadCredentialsException e) {
            logger.info(e.toString());
            throw new BadCredentialsException(e.getMessage());
        } catch(Exception e) {
            logger.info(e.toString());
            // throw new RuntimeException(e.getMessage());
            e.printStackTrace();
        }
		
		return new UsernamePasswordAuthenticationToken(user, password, authorityes);
		
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return true;
	}

	

}
