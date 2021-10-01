package com.portal.config.security;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import com.portal.adm.log.mapper.LogMapper;
import com.portal.adm.log.model.LogModel;
import com.portal.adm.log.service.LogService;
import com.portal.common.CommonUtil;
import com.portal.common.Constant;
import com.portal.common.logging.LogUtil;
import com.portal.config.security.mapper.SecurityMapper;

public class LoginSuccessLoggingAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	
	@Resource
	private CommonUtil commonUtil;
	
	@Resource
	private LogUtil logUtil;
	
	@Resource
	private LogService logService;
	
	@Resource
	private SecurityMapper mapper;
	
	@Resource
	private LogMapper logMapper;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws ServletException, IOException {
		Map<String,Object> params = new HashMap<>();
		AuthUser customAuthUser = null;
		Object token = null;
		
		if (SecurityContextHolder.getContext().getAuthentication().getPrincipal() instanceof AuthUser) {
			customAuthUser = (AuthUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		} else {
			token = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		}
		
		params.put(Constant.LOG.CLIENT_IP, commonUtil.getClientIP(request));
		params.put(Constant.LOG.SERVER_IP,  commonUtil.getServerIP());
		params.put(Constant.LOG.CONTROLLER_NM, "LoginSuccessLoggingAuthenticationSuccessHandler");
		params.put(Constant.LOG.METHOD_NM, "onAuthenticationSuccess");
		params.put(Constant.LOG.PARAMS, getParams(request));
		params.put(Constant.LOG.LOG_TIME, LocalDateTime.now());
		params.put(Constant.LOG.REQUEST_URI, request.getRequestURI());
		params.put(Constant.LOG.HTTP_METHOD, request.getMethod());
		if (customAuthUser != null) {
			params.put(Constant.LOG.USER_INFO, customAuthUser.getMemberModel());
			// 로그인 이력 저장
			LogModel model = new LogModel();
			model.setUserId(customAuthUser.getMemberModel().getUserId());
			model.setUserNm(customAuthUser.getMemberModel().getUserNm());
			model.setAuthId(customAuthUser.getMemberModel().getAuthId());
			model.setAuthNm(customAuthUser.getMemberModel().getAuthNm());
			model.setPstnCode(customAuthUser.getMemberModel().getPstnCode());
			model.setPstnNm(customAuthUser.getMemberModel().getPstnNm());
			model.setDeptCode(customAuthUser.getMemberModel().getDeptCode());
			model.setDeptNm(customAuthUser.getMemberModel().getDeptNm());
			model.setServerIp(commonUtil.getServerIP());
			model.setClientIp(commonUtil.getClientIP(request));
			
			logMapper.insertLogin(model);
			logService.insert(logUtil.convertLogData(params));
			
			// 사용자 마지막 로그 일시 업데이트
			mapper.updateLastLogDt(customAuthUser.getMemberModel().getUserId());
			// 사용자 접속 IP
			customAuthUser.getMemberModel().setClientIp(params.get(Constant.LOG.CLIENT_IP).toString());
		} else if (token != null) {
			params.put(Constant.LOG.USER_INFO, token.toString());
		}
		
		
		super.onAuthenticationSuccess(request, response, authentication);
	}
	
	/**
	 * request 에 담긴 정보를 JSONObject 형태로 반환한다.
	 * @parma request
	 */
	private JSONObject getParams(HttpServletRequest request) {
		JSONObject jsonObject = new JSONObject();
		Enumeration<String> params = request.getParameterNames();
		while (params.hasMoreElements()) {
			String param = params.nextElement();
			if(!param.equals("userPwd")) {
				String replaceParam = param.replaceAll("\\.", "-");
				jsonObject.put(replaceParam, request.getParameter(param));
			}
		}
		return jsonObject;
	}
}
