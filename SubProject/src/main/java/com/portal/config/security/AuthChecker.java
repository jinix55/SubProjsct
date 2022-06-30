package com.portal.config.security;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import com.portal.adm.menu.mapper.MenuMapper;
import com.portal.adm.menu.model.MenuModel;
import com.portal.common.Constant;
import com.portal.config.security.mapper.SecurityMapper;

import lombok.extern.slf4j.Slf4j;

/**
 * 스프링 시큐리티 설정
 * 권한을 동적으로 생성하는 경우 security config를 수정하고 재배포하여 처리하지 않도록 하기위해
 * 권한 체크를 HTTP 요청 시 DB에서 HTTP 요청 URI를 확인하여 처리
 */
@Slf4j
@Component
public class AuthChecker {

	@Resource(name="securityMapper")
	private SecurityMapper mapper;
	
    @Resource
    private MenuMapper menuMapper;

	
	public boolean check(HttpServletRequest request, Authentication authentication) {
		boolean result = false;
		
		Object principal = authentication.getPrincipal();
		if (principal != null && principal instanceof AuthUser) {
			//인증 사용자
			//인증 사용자의 권한, 요청 URL을 메뉴, 권한 테이블에서 조회하여 허용되는 권한이면 true 반환
			//  현재는 인증 사용자면 모두 접근 가능하도록 true 반환
			AuthUser user = (AuthUser) principal;
			String authCode = user.getMemberModel().getAuthCode();
			//if (StringUtils.isNotBlank(authCode) && StringUtils.equals(Constant.YES, user.getMemberModel().getAuthUseYn())) {
			{
				
				String uri = request.getRequestURI();
				/*
				 * log.info("▶▷▶▷ [printHttpServletRequest] Parameter Info START =========");
				 * System.out.println("request.getServerName() : " + request.getRequestURI());
				 * System.out.println("request.getServerName() : " + request.getServerName());
				 * System.out.println("request.getProtocol() : " + request.getProtocol());
				 * System.out.println("request.getServerPort() : " + request.getServerPort());
				 * System.out.println("request.getMethod() : " + request.getMethod());
				 * System.out.println("request.getPathInfo() : " + request.getPathInfo());
				 * System.out.println("request.getPathTranslated() : " +
				 * request.getPathTranslated());
				 * System.out.println("request.getServletPath() : " + request.getServletPath());
				 * System.out.println("request.getRealPath(\"/\") : " +
				 * request.getRealPath("/")); System.out.println("request.getQueryString() : " +
				 * request.getQueryString()); System.out.println("request.getRemoteHost() : " +
				 * request.getRemoteHost()); System.out.println("request.getRemoteAddr() : " +
				 * request.getRemoteAddr()); System.out.println("request.getAuthType() : " +
				 * request.getAuthType()); System.out.println("request.getRemoteUser() : " +
				 * request.getRemoteUser()); System.out.println("request.getContentType() : " +
				 * request.getContentType()); System.out.println("request.getContentLength() : "
				 * + request.getContentLength());
				 * System.out.println("request.getServerPort() : " + request.getServerPort());
				 * log.info("▶▷▶▷ [printHttpServletRequest] Parameter Info END =========\n");
				 */
//				if(uri.equals("") || uri == null) {
//			    	Map<String,String> param = new HashMap<>();
//			    	param.put("authId", authId);
//			    	uri = menuMapper.selectFirstMenuUrl(param);
//				}
				
				Matcher ignoreMatcher = Constant.UrlPattern.AUTH_IGNORE_PATTERN.matcher(uri);
				if (ignoreMatcher.find()) {
					// 인증 사용자 모두 요청 가능한 경우
					result = true;
				} else {
					// 인증 사용자의 권한에 따른 요청 가능 확인
					// detail, regist, modify : 화면
					// insert, update, delete : 동작
					String type = null;
					Matcher matcher = Constant.UrlPattern.AUTH_CHECK_PATTERN.matcher(uri);
					if (matcher.find()) {
						uri = uri.substring(0, matcher.start());
						type = matcher.group(0).replaceAll("^/|/$","");
//					}else {
//				    	Map<String,String> param = new HashMap<>();
//				    	param.put("authId", authId);
//				    	uri = menuMapper.selectFirstMenuUrl(param);
					}
					
					/* url 패턴은 아래 참조 (총 7개)
					 * 		~/기능명/list/
					 * 		~/기능명/detail 또는 ~/기능명/detail/{pk}
					 * 		~/기능명/regist  (권한맵핑정보의 insert_auth_yn="Y" 이면, regist도 true 리턴)
					 * 		~/기능명/insert
					 *  	~/기능명/modify 또는 ~/기능명/modify/{pk}  (권한맵핑정보의 update_auth_yn="Y" 이면, modify도 true 리턴)
					 *  	~/기능명/update
					 *  	~/기능명/delete 
					 */
					Map<String,String> param = new HashMap<String,String>();
					param.put("authCode", authCode);
					param.put("menuUrl", uri);
					MenuModel menu = mapper.selectMenuWithAuth(param);
					if (menu != null) {
						log.debug(menu.toString());
						if (StringUtils.isBlank(type)) {
							// 접근 가능한 메뉴인 경우
							result = true;
						} else {
							// 접근 가능한 메뉴의 하위 화면, 기능인 경우
							JSONObject attr = menu.getMenuAttr().optJSONObject("attr");
							if (attr != null) {
								if (attr.optBoolean(Constant.UrlPattern.AUTH_CHECK_TYPE.get(type), false)) {
									result = true;
								}
							}
						}
					}
				}
			}
		} else {
			//익명 사용자
			log.debug("user : {}",principal.toString());
		}
		return result;
	}
}
