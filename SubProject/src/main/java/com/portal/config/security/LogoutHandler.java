package com.portal.config.security;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import com.portal.adm.log.service.LogService;
import com.portal.common.CommonUtil;
import com.portal.common.Constant;
import com.portal.common.logging.LogUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LogoutHandler implements LogoutSuccessHandler {

	@Resource
	private LogService logService;
	
	@Resource
	private CommonUtil commonUtil;
	
	@Resource
	private LogUtil logUtil;
	
	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		
		if (authentication != null) {
			if (authentication.getPrincipal() instanceof AuthUser) {
				AuthUser authUser = (AuthUser) authentication.getPrincipal();
				Map<String,Object> params = new HashMap<>();
				params.put(Constant.LOG.CLIENT_IP, commonUtil.getClientIP(request));
				params.put(Constant.LOG.SERVER_IP, commonUtil.getServerIP());
				params.put(Constant.LOG.CONTROLLER_NM, "LogoutHandler");
				params.put(Constant.LOG.METHOD_NM, "onLogoutSuccess");
				params.put(Constant.LOG.PARAMS, new JSONObject());
				params.put(Constant.LOG.REQUEST_URI, request.getRequestURI());
				params.put(Constant.LOG.HTTP_METHOD, request.getMethod());
				params.put(Constant.LOG.USER_INFO, authUser.getMemberModel());
				
				logService.insert(logUtil.convertLogData(params));
			}
		}
		
		//request.getRequestDispatcher("/login").forward(request, response);
		response.sendRedirect("/login");
	}
}
