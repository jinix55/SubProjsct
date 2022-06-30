package com.portal.config.security;

import java.util.HashSet;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import com.portal.adm.member.model.MemberModel;
import com.portal.common.Constant;
import com.portal.config.security.mapper.SecurityMapper;

import lombok.extern.slf4j.Slf4j;

/**
 * 스프링 시큐리티의 username에 따른 사용자를 조회하기 위한 커스텀 서비스 클래스
 */
@Slf4j
@Component
public class AuthUserDetailsService implements UserDetailsService {

	@Resource(name = "securityMapper")
	private SecurityMapper mapper;

	@Autowired
	private HttpServletRequest request;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		AuthUser authUser = null;
		MemberModel reqModel = new MemberModel();
		
		// login.jsp 에서 SSO 갔다오고 난 후에 /ssologin 에서 SSO 인증 확인하고 login.jsp 에서 바로 form submit 호출 하여 스프링 시큐리티 시작
		boolean isSso = StringUtils.equalsIgnoreCase("Y", request.getParameter("sso"));
		if (StringUtils.isNotBlank(username)) {
			// 사용자 정보 DB 조회
	    	
	    	reqModel.setCompanyCode(username.split("@")[0]);
	    	reqModel.setUserId(username.split("@")[1]);
			MemberModel member = mapper.selectUser(reqModel);
			if (member != null) {
				// 계정 활성 : useYn
				if (StringUtils.equals("N", member.getUseYn())) {
					throw new UsernameNotFoundException(mapper.selectLoginMessage(Constant.LoginMessage.ACCOUNT_DISABLE));
				}
				//계정 잠김 : lastLogDt
//				if (StringUtils.equals("Y", member.getLockYn())) {
//					throw new UsernameNotFoundException(mapper.selectLoginMessage(Constant.LoginMessage.ACCOUNT_LOCK));
//				}
				// 계정 만료 : startDt ~ endDt
//				if (StringUtils.equals("Y", member.getExpiredYn())) {
//					throw new UsernameNotFoundException(mapper.selectLoginMessage(Constant.LoginMessage.ACCOUNT_EXPIRE));
//				}
				log.info("member : {}",member.toString());
				// 권한
				if (StringUtils.isNotBlank(member.getAuthCode())) {
					Set<GrantedAuthority> authorities = new HashSet<GrantedAuthority>();
					authorities.add(new SimpleGrantedAuthority(StringUtils.joinWith("_", "ROLE",member.getAuthCode())));
					authUser = new AuthUser(member, authorities, isSso);
				} else {
					throw new UsernameNotFoundException(mapper.selectLoginMessage(Constant.LoginMessage.AUTH_FAIL));
				}
			}
		}
		if (authUser == null) {
			throw new UsernameNotFoundException(mapper.selectLoginMessage(Constant.LoginMessage.USER_NOT_FOUND));
		}
		return authUser;
	}

}
