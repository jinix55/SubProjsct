package com.portal.adm.role;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.portal.adm.company.service.CompanyService;
import com.portal.adm.menu.model.MenuModel;
import com.portal.adm.menu.service.MenuService;
import com.portal.adm.role.model.RoleModel;
import com.portal.adm.role.service.RoleService;
import com.portal.common.IdUtil;
import com.portal.config.security.AuthUser;

import lombok.extern.slf4j.Slf4j;

/**
 * 사용자관리 / 권한관리 컨트롤러
 */
@RequestMapping("/system")
@Controller
@Slf4j
public class RoleController {

    @Resource
    private RoleService roleService;
    
    @Resource
    private CompanyService companyService;
    
    @Resource
    private MenuService menuService;
    
    @Resource
    private IdUtil idUtil;

    /**
     * 권한 관리 페이지로 이동한다.
     *
     * @param criteria 페이징 처리 관련 모델
     * @param model
     * @return
     */
    @GetMapping("/role")
    public String list(@ModelAttribute RoleModel roleModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	
    	// 모든 회사 조회
        model.addAttribute("companys", companyService.selectListAll());
    	
    	roleModel.setCompanyCode(authUser.getMemberModel().getCompanyCode());
    	roleModel.setAuthId(authUser.getMemberModel().getAuthId());
    	
        model.addAttribute("roles", roleService.selectList(roleModel));
        roleModel.setTotalCount(roleService.selectListCount(roleModel));
        model.addAttribute("pages", roleModel);
        
        
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

        return "role/groupMgt";
    }

    /**
     * 권한관리 페이지로 이동한다. 페이징시에 파라미터 노출을 하지 않기 위해서 redirect하기 위한 기능
     * @param criteria      // 페이징 모델
     * @param attributes    // 권한 페이지로 모델을 전달하기 위한 속성
     * @return
     */
    @PostMapping("/role")
    public String list(@ModelAttribute RoleModel roleModel, RedirectAttributes attributes) {

        attributes.addFlashAttribute("criteria", roleModel);

        return "redirect:/system/role";
    }

    /**
     * 권한 모델을 저장한다. 권한이 존재하면 업데이트 없으면 신규생성한다.
     *
     * @param roleModel
     * @return      Insert/Update/Fail을 페이지로 리턴하며 alert메시지 처리
     */
    @PostMapping("/role/insert")
    @ResponseBody
    public String insert(@ModelAttribute RoleModel roleModel, @AuthenticationPrincipal AuthUser authUser) {
    	if(roleModel.getAuthId().equals("") || roleModel.getAuthId() == null) {
    		roleModel.setAuthId(idUtil.getAuthId());
    	}
        try {
            roleModel.setRgstId(authUser.getMemberModel().getUserId());
            roleModel.setModiId(authUser.getMemberModel().getUserId());
            roleModel.setCompanyCode(authUser.getMemberModel().getCompanyCode());

            log.debug(authUser.getMemberModel().toString());

            if(SecurityContextHolder.getContext().getAuthentication().getPrincipal() instanceof AuthUser) {
                AuthUser customAuthUser = (AuthUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

                log.debug(customAuthUser.getMemberModel().toString());
            }

            return roleService.save(roleModel);
        } catch (Exception e) {
            return "fail";
        }
    }

    /**
     * 권한 모델을 삭제한다.
     *
     * @param roleModel
     * @return      Delete/Fail을 페이지로 리턴하며 alert메시지 처리
     */
    @PostMapping("/role/delete")
    @ResponseBody
    public String delete(@ModelAttribute RoleModel roleModel, @AuthenticationPrincipal AuthUser authUser) {

        try {
            roleModel.setRgstId(authUser.getMemberModel().getUserId());
            roleModel.setModiId(authUser.getMemberModel().getUserId());

            return roleService.delete(roleModel);
        } catch (Exception e) {
            return "fail";
        }
    }

    @PostMapping("/role/detail/{roleId}")
    @ResponseBody
    public RoleModel select(@PathVariable String roleId) {

        RoleModel roleModel = new RoleModel();
        roleModel.setAuthId(roleId);

        return roleService.select(roleModel);
    }
    
	/**
	 * 권한별 메뉴 조회
	 * @param request
	 * @param 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/role/{authId}/popup", method=RequestMethod.POST)
	public Map<String,Object> menuAuth(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser, @PathVariable String authId) {
		
		log.info("========== in role popup ==========");
		
		Map<String,Object> result = new HashMap<String, Object>();
		boolean res = false;
		
		List<MenuModel> menuAuths = menuService.selectMenuListWithAuth(authId);
		
		if(menuAuths != null) {
			res = true;
			result.put("menuAuths", menuAuths);
		}
		result.put("result", res);
		return result;
	}
}
