package com.portal.config.security;

import java.util.HashSet;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.portal.adm.member.model.MemberModel;
import com.portal.common.Constant;
import com.portal.config.security.mapper.SecurityMapper;

/**
 * 스프링 시큐리티의 username에 따른 사용자를 조회하기 위한 커스텀 서비스 클래스
 * 외부 인증 서버에서 확인 하기 전에 시스템의 데이터베이스에서 사용자 조회
 */
@Service
public class AuthUserDetailServices implements UserDetailsService {

    @Resource
    private SecurityMapper mapper;

    // 사용자 정보를 조회하여 CustomAuthUser를 생성
    @Override
    public UserDetails loadUserByUsername(String username)  {

    	MemberModel reqModel = new MemberModel();
    	reqModel.setCompanyCode(username.split("@")[0]);
    	reqModel.setUserId(username.split("@")[1]);
    	MemberModel model = mapper.selectUser(reqModel);

        if (model == null) {
            throw new UsernameNotFoundException("1|"+mapper.selectLoginMessage(Constant.LoginMessage.DB_LOGIN_NOT_MATCH));
        }
        
        Set<GrantedAuthority> authorities = new HashSet<GrantedAuthority>();
        if (StringUtils.isNotBlank(model.getAuthCode())) {
        	authorities.add(new SimpleGrantedAuthority("ROLE_"+model.getAuthCode()));
        }

        return new AuthUser(model, authorities,false);
    }
}
