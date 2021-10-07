package com.portal.adm.role;

import com.portal.adm.role.model.RoleModel;
import com.portal.adm.role.service.RoleService;
import com.portal.common.paging.Criteria;
import com.portal.config.security.AuthUser;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import java.security.Principal;

/**
 * 사용자관리 / 권한관리 컨트롤러
 */
@RequestMapping("/admin")
@Controller
@Slf4j
public class RoleController {

    @Resource
    private RoleService roleService;

    /**
     * 권한 관리 페이지로 이동한다.
     *
     * @param criteria 페이징 처리 관련 모델
     * @param model
     * @return
     */
    @GetMapping("/role")
    public String list(@ModelAttribute RoleModel roleModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	roleModel.setCompanyCode(authUser.getMemberModel().getCompanyCode());
    	roleModel.setAuthId(authUser.getMemberModel().getAuthId());
        model.addAttribute("roles", roleService.selectList(roleModel));
        roleModel.setTotalCount(roleService.selectListCount(roleModel));
        model.addAttribute("pages", roleModel);

        return "role/role";
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

        return "redirect:/admin/role";
    }

    /**
     * 권한 모델을 저장한다. 권한이 존재하면 업데이트 없으면 신규생성한다.
     *
     * @param roleModel
     * @return      Insert/Update/Fail을 페이지로 리턴하며 alert메시지 처리
     */
    @PostMapping("/role/insert")
    public ResponseEntity<String> insert(@ModelAttribute RoleModel roleModel, @AuthenticationPrincipal AuthUser authUser) {

        try {
            roleModel.setRgstId(authUser.getMemberModel().getUserId());
            roleModel.setModiId(authUser.getMemberModel().getUserId());
            roleModel.setCompanyCode(authUser.getMemberModel().getCompanyCode());

            log.debug(authUser.getMemberModel().toString());

            if(SecurityContextHolder.getContext().getAuthentication().getPrincipal() instanceof AuthUser) {
                AuthUser customAuthUser = (AuthUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

                log.debug(customAuthUser.getMemberModel().toString());
            }

            String result = roleService.save(roleModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }

    /**
     * 권한 모델을 삭제한다.
     *
     * @param roleModel
     * @return      Delete/Fail을 페이지로 리턴하며 alert메시지 처리
     */
    @PostMapping("/role/delete")
    public ResponseEntity<String> delete(@ModelAttribute RoleModel roleModel, @AuthenticationPrincipal AuthUser authUser) {

        try {
            roleModel.setRgstId(authUser.getMemberModel().getUserId());
            roleModel.setModiId(authUser.getMemberModel().getUserId());

            String result = roleService.delete(roleModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }

    @PostMapping("/role/detail/{roleId}")
    @ResponseBody
    public RoleModel select(@PathVariable String roleId) {

        RoleModel roleModel = new RoleModel();
        roleModel.setAuthId(roleId);

        return roleService.select(roleModel);
    }
}
