package com.portal.adm.menu;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartRequest;

import com.portal.adm.menu.model.MenuModel;
import com.portal.adm.menu.service.MenuService;
import com.portal.common.IdUtil;
import com.portal.config.security.AuthUser;

/**
 * 시스템관리 / 메뉴관리 컨트롤러
 *
 */
@RequestMapping("/menu")
@Controller
public class MenuController {

	@Resource
	private MenuService menuService;
	
	@Resource
    private IdUtil idUtil;

	/**
	 * 메뉴관리 페이지로 이동한다.
	 *
	 * @param model
	 * @return
	 */
	@GetMapping("/menu")
	public String menu(Model model, @AuthenticationPrincipal AuthUser authUser) {
		List<MenuModel> list = menuService.selectList(authUser.getMemberModel().getAuthId());
		String rootMenuId = null;
		for (MenuModel menu : list) {
			if (menu.getLv() == 0) {
				rootMenuId = menu.getMenuId();
				break;
			}
		}
		model.addAttribute("menus", list);
		model.addAttribute("rootMenuId", rootMenuId);
		return "menu/menuMgt";
	}
	
	/**
	 * 메뉴관리 페이지로 이동한다.
	 *
	 * @param model
	 * @return
	 */
	@PostMapping("/menu")
	public String menuPost(Model model, @AuthenticationPrincipal AuthUser authUser) {
		List<MenuModel> list = menuService.selectList(authUser.getMemberModel().getAuthId());
		String rootMenuId = null;
		for (MenuModel menu : list) {
			if (menu.getLv() == 0) {
				rootMenuId = menu.getMenuId();
				break;
			}
		}
		model.addAttribute("menus", list);
		model.addAttribute("rootMenuId", rootMenuId);
		return "menu/menuMgt";
	}

	/**
	 * 메뉴관리 모델을 저장한다.
	 *
	 * @param menuModel 메뉴모델
	 * @param authUser
	 * @return
	 */
	@PostMapping("/menu/insert")
	public String insert(@ModelAttribute MenuModel menuModel, @AuthenticationPrincipal AuthUser authUser) {

		try {
			menuModel.setRgstId(authUser.getMemberModel().getUserId());
			menuModel.setModiId(authUser.getMemberModel().getUserId());
			menuModel.setMenuId(idUtil.getMenuId());
			long count = menuService.save(menuModel);
			
			// 메뉴 등록시 담당관리자 권한 자동 등록 
			menuModel.setAuthUseYn("Y");
			menuModel.setRgstId(authUser.getUsername());
			menuModel.setModiId(authUser.getUsername());
			menuModel.setAuthId(authUser.getMemberModel().getAuthId());
			
			long menuAuths = menuService.updateMenuListWithAuth(menuModel);
			
			// 담당관리자 권한 등록 성공 이후 등록자가 최고관리자가 아닐경우 최고관리자 등록
			if(menuAuths > 0 && !StringUtils.equals(authUser.getMemberModel().getAuthId(),"au2000000")) {
				menuModel.setAuthId("au2000000");
				menuService.updateMenuListWithAuth(menuModel);	
			}

			return "redirect:/menu/menuMgt";
		} catch (Exception e) {
			return "forward:/menu/menuMgt";
		}
	}

	/**
	 * 메뉴관리 모델을 저장한다.
	 *
	 * @param menuModel 메뉴모델
	 * @param authUser
	 * @return
	 */
	@PostMapping("/menu/update")
	public String save(@ModelAttribute MenuModel menuModel, @AuthenticationPrincipal AuthUser authUser) {

		try {
			menuModel.setRgstId(authUser.getMemberModel().getUserId());
			menuModel.setModiId(authUser.getMemberModel().getUserId());

			long count = menuService.save(menuModel);

			return "redirect:/menu/menu";
		} catch (Exception e) {
			return "forward:/menu/menu";
		}
	}

	/**
	 * 메뉴모델을 삭제한다.
	 *
	 * @param menuModel
	 * @param authUser
	 * @return
	 */
	@PostMapping("/menu/delete")
	public String delete(@ModelAttribute MenuModel menuModel, @AuthenticationPrincipal AuthUser authUser) {

		try {
			menuModel.setRgstId(authUser.getMemberModel().getUserId());
			menuModel.setModiId(authUser.getMemberModel().getUserId());

			long count = menuService.delete(menuModel);

			return "redirect:/menu";
		} catch (Exception e) {
			return "forward:/menu";
		}
	}

	/**
	 * 메뉴검색 팝업으로 이동한다.
	 *
	 * @param model
	 * @return
	 */
	@GetMapping("/menu/popup")
	public String menuPopup(Model model) {

		model.addAttribute("menus", menuService.selectList());

		return "popup/upperMenuPopup";
	}
}
