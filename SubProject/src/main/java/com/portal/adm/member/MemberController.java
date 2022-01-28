package com.portal.adm.member;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.portal.adm.code.service.CodeService;
import com.portal.adm.company.service.CompanyService;
import com.portal.adm.member.model.MemberCriteria;
import com.portal.adm.member.model.MemberModel;
import com.portal.adm.member.service.MemberService;
import com.portal.adm.role.service.RoleService;
import com.portal.config.security.AuthUser;

import lombok.extern.slf4j.Slf4j;

/**
 * 사용자관리/사용자관리 컨트롤러
 */
@RequestMapping("/member")
@Controller
@Slf4j
public class MemberController {

    @Resource
    private MemberService memberService;

    @Resource
    private CodeService codeService;

    @Resource
    private RoleService roleService;
    
    @Resource
    private CompanyService companyService;
    
    /**
     * 사용자관리 페이지로 이동한다.
     *
     * @param model
     * @return
     */
    @GetMapping("/member")
    public String list(@ModelAttribute MemberCriteria criteria, @ModelAttribute MemberModel memberModel, Model model, @AuthenticationPrincipal AuthUser authUser) {

    	log.info("============= > "+criteria.getSearchKey());
    	log.info("============= > "+criteria.getSearchValue());
    	
        // 모든 권한 조회
        model.addAttribute("roles", roleService.selectAllList());
        
        // 모든 회사 조회
        model.addAttribute("companys", companyService.selectListAll());

        criteria.setCompanyCode(authUser.getMemberModel().getCompanyCode());
        criteria.setAuthId(authUser.getMemberModel().getAuthId());
        model.addAttribute("members", memberService.selectMemberList(criteria));
        criteria.setTotalCount(memberService.selectMemberListCount(criteria));
        model.addAttribute("pages", criteria);

        return "member/member";
    }

    @PostMapping("/member")
    public String list(@ModelAttribute MemberCriteria criteria, @ModelAttribute MemberModel memberModel, RedirectAttributes attributes, Model model, @AuthenticationPrincipal AuthUser authUser) {

    	log.info(" member post memberModel ==>  {} ",memberModel.toString());
    	log.info(" member post criteria ==>  {} ",criteria.toString());
    	log.info(" member post model ==>  {} ",model.toString());
        log.info("============= > "+criteria.getSearchKey());
        log.info("============= > "+criteria.getSearchValue());
        attributes.addFlashAttribute("criteria", criteria);

        // 모든 권한 조회
        model.addAttribute("roles", roleService.selectAllList());
        
        // 모든 회사 조회
        model.addAttribute("companys", companyService.selectListAll());

        criteria.setCompanyCode(authUser.getMemberModel().getCompanyCode());
        criteria.setAuthId(authUser.getMemberModel().getAuthId());
        
        model.addAttribute("members", memberService.selectMemberList(criteria));
        criteria.setTotalCount(memberService.selectMemberListCount(criteria));
        model.addAttribute("pages", criteria);
        
//        return "redirect:/admin/member";
        return "member/member";
    }

    @PostMapping("/member/detail/{memberId}")
    @ResponseBody
    public MemberModel selectPopup(@PathVariable String memberId, Model model) {
    	log.info("================== select memberId ================");
    	MemberModel memberModel = new MemberModel();
    	memberModel.setUserId(memberId);
    	return memberService.selectMember(memberModel);
    }
    
    @PostMapping("/member/detail/popup/{memberId}")
    @ResponseBody
    public String select(@PathVariable String memberId, Model model) {
    	log.info("================== select memberId ================");
        MemberModel memberModel = new MemberModel();
        if(!StringUtils.equals(memberId, "")) {
        	memberModel.setUserId(memberId);
        	memberModel = memberService.selectMember(memberModel);
        }
        
        if(memberModel == null) {
        	return memberId;
        }else {
        	return "none";
        }
        
    }

    @PostMapping("/member/update")
    public ResponseEntity<String> update(HttpServletRequest request,
                                       @ModelAttribute MemberModel memberModel,
                                       @AuthenticationPrincipal AuthUser authUser) {

        try {
            if(!StringUtils.isEmpty(request.getParameter("dateFrom"))) {
                memberModel.setStartDt(LocalDateTime.parse(request.getParameter("dateFrom") + "T" + LocalTime.now().toString()));
            }
            if(!StringUtils.isEmpty(request.getParameter("dateTo"))) {
                memberModel.setEndDt(LocalDateTime.parse(request.getParameter("dateTo")+"T"+LocalTime.now().toString()));
            }

            memberModel.setRgstId(authUser.getMemberModel().getUserId());
            memberModel.setModiId(authUser.getMemberModel().getUserId());

            String result = memberService.save(memberModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }
    
    @PostMapping("/member/insert")
    public ResponseEntity<String> insert(HttpServletRequest request,
                                       @ModelAttribute MemberModel memberModel,
                                       @AuthenticationPrincipal AuthUser authUser) {
		for (String key : request.getParameterMap().keySet()) {
			log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
		}
        try {
            if(!StringUtils.isEmpty(request.getParameter("dateFrom"))) {
                memberModel.setStartDt(LocalDateTime.parse(request.getParameter("dateFrom") + "T" + LocalTime.now().toString()));
            }
            if(!StringUtils.isEmpty(request.getParameter("dateTo"))) {
                memberModel.setEndDt(LocalDateTime.parse(request.getParameter("dateTo")+"T"+LocalTime.now().toString()));
            }

            memberModel.setRgstId(authUser.getMemberModel().getUserId());
            memberModel.setModiId(authUser.getMemberModel().getUserId());

            String result = memberService.insert(memberModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }
    
    @PostMapping("/member/delete")
    public ResponseEntity<String> delete(HttpServletRequest request,
                                       @ModelAttribute MemberModel memberModel,
                                       @AuthenticationPrincipal AuthUser authUser) {
		for (String key : request.getParameterMap().keySet()) {
			log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
		}
        try {

            memberModel.setModiId(authUser.getMemberModel().getUserId());

            String result = memberService.delete(memberModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }
    
    @GetMapping("/member/popup")
    public String popupList(@ModelAttribute MemberCriteria criteria, Model model) {

        // 화면 표시용 코드 셋팅
        // 회사구분 코드
        model.addAttribute("codeCompanyCdList", codeService.selectGroupIdAllList("COMPANY_CODE"));
        // 사용여부 코드
        model.addAttribute("codeUseYnList", codeService.selectGroupIdAllList("USE_YN"));        
        // 검색구분 코드
        model.addAttribute("codeMemSearchCdList", codeService.selectGroupIdAllList("USER_SEARCH_CODE"));

        // 권한코드 조회
        model.addAttribute("roles", roleService.selectAllList());

        model.addAttribute("members", memberService.selectMemberList(criteria));
        criteria.setTotalCount(memberService.selectMemberListCount(criteria));
        model.addAttribute("pages", criteria);

        return "popup/memberPopup";
    }
    
    @PostMapping("/member/popup")
    public String popupList(@ModelAttribute MemberCriteria criteria, RedirectAttributes attributes) {
        attributes.addFlashAttribute("criteria", criteria);
        return "redirect:/admin/member/popup";
    }    
    
    /**
     * 사용자 정보 조회(ajax)
     * @param criteria
     * @return
     */
    @RequestMapping(value="/member/list/popup", method=RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> memberSelect(@ModelAttribute MemberCriteria criteria) {
    	Map<String,Object> result = new HashMap<String, Object>();
		boolean res = false;
		
		List<MemberModel> members = memberService.selectMemberAllList(criteria);
		
		if(members != null) {
			res = true;
			result.put("members", members);
		}
		result.put("result", res);
    	
        return result;
    }
    
    //계정 잠김 해제
    @PostMapping("/member/update/unlock/{memberId}")
    @ResponseBody
    public long unlockAccount(@PathVariable String memberId) {

        MemberModel memberModel = new MemberModel();
        memberModel.setUserId(memberId);

        return memberService.unlockAccount(memberModel);
    }    
    
    /**
     * 사용자관리 페이지로 이동한다.
     *
     * @param model
     * @return
     */
    @GetMapping("/pwdChange")
    public String pwdChange(@ModelAttribute MemberCriteria criteria, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	log.info("==================== pwdChange in ===================");
    	
    	return "user/pwdChange";
    }
    
    /**
     * 사용자관리 페이지로 이동한다.
     *
     * @param model
     * @return
     */
    @GetMapping("/userInfoChange")
    public String userInfoChange(@ModelAttribute MemberCriteria criteria, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	log.info("==================== userInfoChange in ===================");
    	
    	return "user/userInfoChange";
    }
    
    /**
     * 사용자관리 페이지로 이동한다.
     *
     * @param model
     * @return
     */
    @PostMapping("member/update/userInfoChange")
    public ResponseEntity<String> updateUserInfo(@ModelAttribute MemberModel memberModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	log.info("==================== updateUserInfo in ===================");
        try {
            memberModel.setRgstId(authUser.getMemberModel().getUserId());
            memberModel.setModiId(authUser.getMemberModel().getUserId());

            String result = memberService.updateMember(memberModel);
            authUser.getMemberModel().setEmail(memberModel.getEmail());
            authUser.getMemberModel().setPhone(memberModel.getPhone());
            
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }
}