package com.xt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xt.domain.Account;
import com.xt.persistence.AccountMapper;

@Service
public class AccountService {

  @Autowired
  private AccountMapper accountMapper;

  public Account getAccountByUsername(String username) {
    return accountMapper.getAccountByUsername(username);
  }
  
  public Account getAccountByUserId(int userId){
	  return accountMapper.getAccountByUserId(userId);
  }

  public List<Account> getAccountListByKeywords(Map<String,Object> map){
		return accountMapper.getAccountListByKeywords(map);
  }
  
  public int insertUser(Map<String,Object> map){
	  return accountMapper.insertAccount(map);
  }
  
  public int updateUser(Map<String,Object> map){
	  return accountMapper.updateAccountByUserId(map);
  }
  
  public int deleteUser(int userId){
	  return accountMapper.deleteAccountByUserId(userId);
  }
  
  
  public int getAccountCount(Map<String, Object> map){
	  return accountMapper.getAccountCount(map);
  }
}
