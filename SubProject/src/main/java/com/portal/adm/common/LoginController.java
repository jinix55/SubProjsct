package com.portal.adm.common;

import java.util.Enumeration;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.portal.adm.member.model.MemberModel;
import com.portal.common.Constant;
import com.portal.common.annotation.NoLogging;
import com.portal.config.security.mapper.SecurityMapper;

import lombok.extern.slf4j.Slf4j;

/**
 * 스프링 시큐리티 로그인등의 페이지를 커스텀하기 위한 컨트롤러
 */
@Controller
@Slf4j
public class LoginController {
	
	@Resource(name = "securityMapper")
	private SecurityMapper securityMapper;
	
	/**
	 * 로그인
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/login", method= {RequestMethod.GET,RequestMethod.POST})
	public String login(HttpServletRequest request, HttpServletResponse response, Model model) {
		/*
		 * 로그인
		 *     골드넷 베너 진입 시 SSO 처리
		 *     포털 주소 직접 입력으로 진입 시 DB 로그인
		 * 골드넷 베너 진입
		 *     골드넷 CI에서 SSO 서버로 토큰 요청 후 응답된 SSO URL을 브라우저 호출
		 *     브라우저에서 SSO 서버 접근 후 분석포털 /login?SSO=Y 로 접근
		 *     세션에 사용자 정보 없으면 SSO 서버 호출
		 *     SSO 서버 인증 후 분석포털 /login?SSO=Y 호출
		 *     세션에 사용자 정보 있으면 login form submit 하여 spring security 로그인 처리
		 *     세션에 사용자 정보 없으면 로그인 페이지 노출
		 * SSO 인증 후 포털 spring security 로그인 처리 중 오류 시 SSO 로그인 /lgn 반복 호출
		 *     spring security exception 없는 경우만 SSO 성공 확인
		 *     SSO 인증 실패 메시지가 있으면 화면 전달, 없으면 SSO 인증 시도 처리로 SSO 반복 호출 막음
		 */
		log.debug("call /login");
		ssoLogin(request, model);
		
		return "/login";
	}
	
	/**
	 * 비밀번호 변경
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/login/pwdChange", method= {RequestMethod.GET,RequestMethod.POST})
	public String pwdChange(HttpServletRequest request, HttpServletResponse response, Model model) {
		log.debug("call /login/pwdChange");
		
		MemberModel member = new MemberModel();
		member.setUserId(request.getParameter("userId"));
		member.setPassword(request.getParameter("userPwdOld"));
		member.setNewPassword(request.getParameter("userPwdNew"));
		
		securityMapper.updateUserPassword(member);
		
		return "/login";
	}
	
	/**
	 * 비밀번호 초기화
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/login/pwdChangeInit", method= {RequestMethod.GET,RequestMethod.POST})
	public String pwdChangeInit(HttpServletRequest request, HttpServletResponse response, Model model) {
		log.debug("call /login/pwdChangeInit");
		
		MemberModel member = new MemberModel();
		member.setUserId(request.getParameter("userId"));
		member.setNewPassword("rt12#$");
		
		securityMapper.updatePasswordInit(member);
		
		return "/login";
	}
	
	public Model ssoLogin(HttpServletRequest request, Model model) {
//		// Spring Security 인증 실패 시 실패 메시지 추출
		Object obj = request.getSession().getAttribute("SPRING_SECURITY_LAST_EXCEPTION");
		if (obj != null && obj instanceof Exception) {
			Exception e = (Exception) obj;
			model.addAttribute("result",e.getMessage());
			request.getSession().removeAttribute("SPRING_SECURITY_LAST_EXCEPTION");
		} else {
//			// 세션에서 사용자 정보 조회 : SSO 인증 성공이면 사용자 정보 있음
//			HttpSession session = request.getSession();
//			Object userInfo = session.getAttribute(Env.DEFAULT_SESSION_USERID);
//			String userId = null;
//			if (userInfo != null) {
//				userId = userInfo.toString();
//				// 사용자 정보가 있으면 JSP로 전달
//				if (StringUtils.isNotBlank(userId)) {
//					model.addAttribute("userInfo",userId);
//				}
//			}
//			
//			// SSO=Y 이면 SSO 인증 시도
//			if (StringUtils.equalsIgnoreCase("Y",request.getParameter("SSO"))) {
//				// SSO 인증 실패 시 실패 메시지 추출
//				String ssoMsg = request.getParameter("SsoReturnValue");
//				if (StringUtils.isNotBlank(ssoMsg)) {
//					log.debug(ssoMsg);
//					model.addAttribute("result",ssoMsg);
//				} else {
//					// 세션에서 사용자 정보를 가져왔으면 SSO 인증 시도를 하지 않음
//					if (StringUtils.isBlank(userId)) {
//						WebAgent agent = new WebAgent();
//						try {
//							agent.requestAuthentication(request, response);
//						} catch (Exception e) {
//							model.addAttribute("result",securityMapper.selectLoginMessage(Constant.LoginMessage.SSO_CONNECT_FAIL));
//						}
//					}
//				}
//			}
		}
		return model;
	}
	
//	@NoLogging
//	@RequestMapping(value="/ssologin", method= {RequestMethod.GET,RequestMethod.POST})
//	public String ssologin(HttpServletRequest request, HttpServletResponse response, Model model) {
//		
//		HttpSession session = request.getSession();
//		
//		Enumeration<String> keys = session.getAttributeNames();
//		while (keys.hasMoreElements()) {
//			String key = keys.nextElement();
//			log.debug("##################### SSO SESSION - {} : {}",key,session.getAttribute(key));
//		}
//		Object userInfo = session.getAttribute(Env.DEFAULT_SESSION_USERID);
//		if (userInfo != null) {
//			String userId = userInfo.toString();
//			model.addAttribute("userInfo",userId);
//			log.debug("SSO LOGIN TEST : {}",userId);
//		} else {
//			log.debug("SSO LOGIN RESULT IS NULL");
//		}
//		
//		String ssoMsg = request.getParameter("SsoReturnValue");
//		if (StringUtils.isNotBlank(ssoMsg)) {
//			log.debug(ssoMsg);
//			model.addAttribute("result",ssoMsg);
//		}
//		
//		return "/login";
//	}
}
