package com.portal.common.tiles;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.tiles.Attribute;
import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import com.portal.adm.menu.model.MenuModel;
import com.portal.adm.menu.service.MenuService;
import com.portal.config.security.AuthUser;

/**
 * 타일즈에서 상단 GNB 공통 로딩을 처리하기 위한 Custome View Preparer
 *
 * 메뉴에서 최상단 메뉴(upper_menu_id)가 0인 항목을 가지고 와서 layout/폴더의 gnb.jsp에서 TOP메뉴 목록을 출력하기
 * 위한 용도로 사용
 */
@Component
public class MenuPreparer implements ViewPreparer {

	@Resource
	private MenuService menuService;

	@Override
	public void execute(Request request, AttributeContext attributeContext) {
		if (SecurityContextHolder.getContext().getAuthentication() != null) {
			if (SecurityContextHolder.getContext().getAuthentication().getPrincipal() instanceof AuthUser) {
				AuthUser authUser = (AuthUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				List<MenuModel> menuModelList = menuService.selectTopMenuListWithAuth(authUser.getMemberModel().getAuthId());
				if (menuModelList == null) {
					menuModelList = new ArrayList<MenuModel>();
				}
				attributeContext.putAttribute("topMenuList", new Attribute(menuModelList), true);
			}
		}
	}
}
