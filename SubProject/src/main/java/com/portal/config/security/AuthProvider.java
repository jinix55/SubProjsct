package com.portal.config.security;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;

import com.portal.adm.member.model.MemberModel;
import com.portal.common.CommonUtil;
import com.portal.common.Constant;
import com.portal.config.props.UdbProps;
import com.portal.config.security.mapper.SecurityMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AuthProvider extends DaoAuthenticationProvider {

	@Resource(name = "udbProps")
	private UdbProps props;

	@Resource(name = "commonUtil")
	private CommonUtil util;

	@Resource(name = "securityMapper")
	private SecurityMapper mapper;
	
	@Autowired
	private HttpServletRequest request;

	@Override
	protected void additionalAuthenticationChecks(UserDetails userDetails, UsernamePasswordAuthenticationToken authentication) throws AuthenticationException {
		// DB 조회 정보
		AuthUser authUser = (AuthUser) userDetails;

		// 사용자 입력 ID, PW
		// ID : authentication.getName()
		// PW : authentication.getCredentials().toString()
		
		if (util.isProd()) {
			// 운영
			if (authUser.isSso()) {
				if (authUser.getAuthorities().size() > 0) {
					// SSO 인증 authUser
				} else {
					// 미인증 authUser
					throw new CredentialsExpiredException(mapper.selectLoginMessage(Constant.LoginMessage.SSO_LOGIN_FAIL));
				}
			} else {
				// DB 로그인
				if (checkDB(authentication.getName(), authentication.getCredentials().toString())) {
					//DB 인증 성공
				} else {
					//DB 인증 실패
					throw new LockedException(mapper.selectLoginMessage(Constant.LoginMessage.DB_LOGIN_FAIL));
				}
			}
		} else {
			// 개발 및 로컬
			// 외주 개발자 테스트 인 경우 MODI_SE = "R"
			log.info("=개발 및 로컬 security 1====");
//			if (StringUtils.equals("R", authUser.getMemberModel().getModiSe())) {
//				log.info("=개발 및 로컬 security 2==== : {}",authentication.getCredentials().toString());
//				if (!StringUtils.equals(authentication.getCredentials().toString(), "test")) {
//					if (checkDB(authentication.getName(), authentication.getCredentials().toString())) {
//						//DB 인증 성공
//					} else {
//						//DB 인증 실패
//						throw new LockedException(mapper.selectLoginMessage(Constant.LoginMessage.DB_LOGIN_FAIL));
//					}
////					throw new BadCredentialsException(mapper.selectLoginMessage(Constant.LoginMessage.LOGIN_FAIL));
//				}
//			} else {
			{
				log.info("=authUser.isSso()====");
				if (authUser.isSso()) {
					// SSO 로그인
					if (authUser.getAuthorities().size() > 0) {
						// SSO 인증 authUser
					} else {
						// 미인증 authUser
						log.info("=authUser.isSso()====");
						throw new CredentialsExpiredException(mapper.selectLoginMessage(Constant.LoginMessage.SSO_LOGIN_FAIL));
					}
				} else {
					// DB 로그인
					log.info("=authUser.isSso().else====");
					if (checkDB(authentication.getName(), authentication.getCredentials().toString())) {
						//DB 인증 성공
					} else {
						//DB 인증 실패
						throw new LockedException(mapper.selectLoginMessage(Constant.LoginMessage.DB_LOGIN_FAIL));
					}
				}
			}
		}
	}

	// DB 사용자 인증
	private boolean checkDB(String userId, String password) {
		boolean result = false;
		Map<String,String> map = new HashMap<String,String>();
		map.put("companyCode",userId.split("@")[0]);
		map.put("userId",userId.split("@")[1]);
		map.put("password",password);
		int errorNo = 0;
		String init = "";
		String msg = null;
		MemberModel model = null;
		
		/* errorCode
		 * 0 = 정상
		 * 1 = 사용자 또는 비밀번호 불일치
		 * 2 = 비밀번호 초기화 상태
		 * 3 = 비밀번호 5회 초과 상태
		 * 4 = 
		 * 9 = DB 연동 오류(기타)
		 */
		
		int errorCode = 0;
		
		try {
			// DB 사용자 로그인 확인
			model = mapper.selectUserPassCheck(map);
			
			if(model != null) {
				errorNo = model.getPassError();
				init = model.getPassInit();
				
				if (errorNo < 5 && StringUtils.equals(init, "N")) {
					//DB 인증 성공
					result = true;
				} else {
					if(StringUtils.equals(init, "Y")) {
						log.warn("비밇번호 초기화");
						errorCode = 2;
						msg = mapper.selectLoginMessage(Constant.LoginMessage.DB_LOGIN_INIT);
					}
					
					if(errorNo > 4) {
						log.warn("로그인 잠금");
						errorCode = 3;
						msg = mapper.selectLoginMessage(Constant.LoginMessage.DB_LOGIN_LOCK);
					}
				}
			}else {
				errorCode = 1;
				model = mapper.selectUserCheck(map);
				if(model.getUserId() != null) {
					int no = model.getPassError();
					if(model.getPassError() >= 5) {
						log.warn("비밀번호 5회이상 불일치");
						no = 5;
					}else {
						log.warn("비밀번호 5회미만 불일치");
						no++ ;
					}
					errorCode = 1;
					map.put("passError", String.valueOf(no));
					mapper.updatePasswordFail(map);
				}else {
					log.warn("사용자 불일치");
				}
				msg = mapper.selectLoginMessage(Constant.LoginMessage.DB_LOGIN_NOT_MATCH);
			}
		} catch (Exception e) {
			log.warn("사용자 로그인 DB 연동 중 오류 발생");
			log.warn(e.getMessage());
			if (StringUtils.isBlank(msg)) {
				errorCode = 9;
				msg = mapper.selectLoginMessage(Constant.LoginMessage.DB_CONNECT_FAIL);
			}
			
		}
		
		if(errorCode == 0) {
			result = true;
		}else {
			throw new LockedException(errorCode+"|"+msg);
		}
		
		return result;
	}
}
