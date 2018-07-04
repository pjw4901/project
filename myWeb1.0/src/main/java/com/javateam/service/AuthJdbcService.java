package com.javateam.service;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.javateam.vo.Users;

@Repository("authJdbcService")
public class AuthJdbcService {
	
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
	}
	
	public boolean hasUserid(String userid) {
		
		System.out.println("hasUserid");
		
		boolean flag = false;
		
		String sql = "SELECT * FROM users WHERE userid=?";
		
		try{
			
			Users user = (Users)this.jdbcTemplate.queryForObject(sql,
															new Object[]{userid},
															new BeanPropertyRowMapper<Users>(Users.class));
			
			flag = user != null ? true : false;
			
		}catch(Exception e){
			flag = false;
			
		}
		
		return flag;
	}
	
    public void insertUsers(Users users) {
    	
    	String sql  = "INSERT INTO users VALUES (?,?,?,?,?,1,?)";
    	String sql2 = "INSERT INTO users_role VALUES "
    				+ "(?,?,?)";
    	
    	this.jdbcTemplate.update(sql, 
    							 new Object[] { users.getUserid(), 
											    users.getUsername(),
											    users.getUserpw(),
											    users.getRole(),
											    users.getUserjoin(),
											    users.getLolname()});
    	
    	this.jdbcTemplate.update(sql2, 
    							 new Object[] { users.getUserid(),
											    users.getUserpw(),
											    users.getRole() });
    	
    }

}
