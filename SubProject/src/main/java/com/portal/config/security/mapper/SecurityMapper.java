package com.portal.config.security.mapper;

import java.util.Map;

import com.portal.adm.alarm.model.AlarmModel;
import com.portal.adm.member.model.MemberModel;
import com.portal.adm.menu.model.MenuModel;
import com.portal.common.annotation.ConnMapperFirst;

@ConnMapperFirst
public interface SecurityMapper {

	MemberModel selectUser(MemberModel model);
	
	int updateLastLogDt(String userId);
	
	String selectLoginMessage(String codeId);
	
	MenuModel selectMenuWithAuth(Map<String,String> param);
	
	MemberModel selectUserPassCheck(Map<String,String> param);
	
	MemberModel selectUserCheck(Map<String,String> param);
	
	int updateUserPassword(MemberModel model);
		
	int updatePasswordFail(Map<String,String> param);
	
	int updatePasswordInit(MemberModel model);

}
