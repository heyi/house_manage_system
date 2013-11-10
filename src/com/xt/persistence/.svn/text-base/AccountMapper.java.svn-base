package com.xt.persistence;


import java.util.List;
import java.util.Map;

import com.xt.domain.Account;


public interface AccountMapper {

  Account getAccountByUsername(String username);
  Account getAccountByUserId(int userId);
  int deleteAccountByUserId(int userId);
  
  List<Account> getAccountListByKeywords(Map<String, Object> map);
  int getAccountCount(Map<String, Object> map);
  
  int updateAccountByUserId(Map<String,Object> map);
  int insertAccount(Map<String, Object> map);
}
