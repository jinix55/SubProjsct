package com.portal.common.interceptor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.binding.BindingException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.portal.adm.menu.model.MenuModel;
import com.portal.adm.menu.service.MenuService;
import com.portal.common.Constant;
import com.portal.config.security.AuthUser;

import lombok.extern.slf4j.Slf4j;

/**
 * 호출되는 MenuURL을 기반으로 Submenu
 */
@Slf4j
public class MenuCheckInterceptor implements HandlerInterceptor {

	@Resource
	private MenuService menuService;

	/**
	 * 컨트롤러 호출후 호출된 URL을 기반으로 레프트메뉴에 대한 목록을 조회해서 페이지로 전달한다.
	 *
	 * @param request
	 * @param response
	 * @param handler
	 * @param modelAndView
	 * @throws Exception
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		if (modelAndView != null) {
			if (SecurityContextHolder.getContext().getAuthentication() != null) {
				if (SecurityContextHolder.getContext().getAuthentication().getPrincipal() instanceof AuthUser) {
					AuthUser authUser = (AuthUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
					
					// detail, regist, modify : 화면
					// insert, update, delete : 동작
					String uri = request.getRequestURI();
					Matcher matcher = Constant.UrlPattern.MENU_CHECK_PATTERN.matcher(uri);
					if (matcher.find()) {
						uri = uri.substring(0, matcher.start());
					}
					
					try {
						Map<String,Object> menuGpCnt = new  HashMap<String,Object>();
						String upperMenuId = menuService.selectUpperMenuIdForMenuUrl(uri);
						List<MenuModel> subMenuList = menuService.selectLeftMenuListWithAuth(upperMenuId,authUser.getMemberModel().getAuthId());
						String id = "";
						int cnt = 0;
						for(int i = 0 ; i < subMenuList.size() ; i++){
							if(StringUtils.equals(subMenuList.get(i).getMenuSe(),"A")) {
								id = subMenuList.get(i).getMenuId();
							} else {
								if(!StringUtils.equals(subMenuList.get(i).getUpMenuId(),id)) {
									id = "";
								}
							}
							if(StringUtils.equals(subMenuList.get(i).getUpMenuId(),id)) {
								cnt++;
								menuGpCnt.put(subMenuList.get(i).getUpMenuId(), cnt);
							}else {
								cnt = 0;
							}
						}
						modelAndView.addObject("subMenuList", subMenuList);
						modelAndView.addObject("menuGpCnt", menuGpCnt);
						modelAndView.addObject("myUri", request.getRequestURI());
					} catch (BindingException e) {
						log.warn("urlCheck Error {}", e.getMessage());
					}
				}
			}
		}
	}
}
