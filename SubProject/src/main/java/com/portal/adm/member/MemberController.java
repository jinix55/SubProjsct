package com.portal.adm.member;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.portal.adm.role.model.RoleModel;
import com.portal.adm.role.service.RoleService;
import com.portal.config.security.AuthUser;
import com.portal.config.security.mapper.SecurityMapper;

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

    @Resource(name = "securityMapper")
	private SecurityMapper securityMapper;
    
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
    public String list(HttpServletRequest request, @RequestParam String companyCode, @ModelAttribute MemberCriteria criteria, @ModelAttribute MemberModel memberModel, Model model, @AuthenticationPrincipal AuthUser authUser) {

        // 모든 권한 조회
    	List<RoleModel> roles = roleService.selectAllList();
        
        // 모든 회사 조회
//        model.addAttribute("companys", companyService.selectListAll());

        if("au2000001".equals(authUser.getMemberModel().getAuthId())) {
        	model.addAttribute("companyCode", companyCode);
        	model.addAttribute("roles", roles.stream().filter(r -> r.getAuthId().equals("au2000002")).collect(Collectors.toList()));
        	criteria.setCompanyCode(companyCode);
        }else {
        	model.addAttribute("roles", roles.stream().filter(r -> r.getAuthId().equals("au2000003")).collect(Collectors.toList()));
        	criteria.setCompanyCode(authUser.getMemberModel().getCompanyCode());
        	model.addAttribute("companyCode", authUser.getMemberModel().getCompanyCode());
        }
        criteria.setAuthId(authUser.getMemberModel().getAuthId());
        model.addAttribute("members", memberService.selectMemberList(criteria));
        criteria.setTotalCount(memberService.selectMemberListCount(criteria));
        model.addAttribute("pages", criteria);

        return "member/member";
    }

    @PostMapping("/member")
    public String list(@ModelAttribute MemberCriteria criteria, @ModelAttribute MemberModel memberModel, RedirectAttributes attributes, Model model, @AuthenticationPrincipal AuthUser authUser) {

        attributes.addFlashAttribute("criteria", criteria);

     // 모든 권한 조회
    	List<RoleModel> roles = roleService.selectAllList();
        
        // 모든 회사 조회
//        model.addAttribute("companys", companyService.selectListAll());

        if("au2000001".equals(authUser.getMemberModel().getAuthId())) {
        	model.addAttribute("companyCode", criteria.getCompanyCode());
        	model.addAttribute("roles", roles.stream().filter(r -> r.getAuthId().equals("au2000002")).collect(Collectors.toList()));
        	criteria.setCompanyCode(criteria.getCompanyCode());
        }else {
        	model.addAttribute("roles", roles.stream().filter(r -> r.getAuthId().equals("au2000003")).collect(Collectors.toList()));
        	criteria.setCompanyCode(authUser.getMemberModel().getCompanyCode());
        	model.addAttribute("companyCode", authUser.getMemberModel().getCompanyCode());
        }

        criteria.setCompanyCode(authUser.getMemberModel().getCompanyCode());
        criteria.setAuthId(authUser.getMemberModel().getAuthId());
        
        model.addAttribute("members", memberService.selectMemberList(criteria));
        criteria.setTotalCount(memberService.selectMemberListCount(criteria));
        model.addAttribute("pages", criteria);
        
//        return "redirect:/admin/member";
        return "member/member";
    }

    @GetMapping("/member/detail/{companyCode}/members")
    @ResponseBody
    public List<MemberModel> getMembers(@PathVariable String companyCode, @ModelAttribute MemberCriteria criteria, @ModelAttribute MemberModel memberModel, @AuthenticationPrincipal AuthUser authUser) {
    	if("au2000001".equals(authUser.getMemberModel().getAuthId())) {
        	criteria.setCompanyCode(companyCode);
        }else {
        	criteria.setCompanyCode(authUser.getMemberModel().getCompanyCode());
        }
    	return memberService.selectMemberAllList(criteria);
    }
    
    @PostMapping("/member/detail/{memberId}/{companyCode}")
    @ResponseBody
    public MemberModel selectPopup(@PathVariable String memberId, @PathVariable String companyCode, Model model) {
    	MemberModel memberModel = new MemberModel();
    	memberModel.setUserId(memberId+"@"+companyCode);
    	return memberService.selectMember(memberModel);
    }
    
    @PostMapping("/member/detail/popup/{memberId}/{companyCode}")
    @ResponseBody
    public String select(@PathVariable String memberId, @PathVariable String companyCode, Model model) {
        MemberModel memberModel = new MemberModel();
        if(!StringUtils.equals(memberId, "")) {
        	memberModel.setUserId(memberId+"@"+companyCode);
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
//			log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
		}
		String subdomain = request.getServerName().split("\\.")[0];
        try {
            if(!StringUtils.isEmpty(request.getParameter("dateFrom"))) {
                memberModel.setStartDt(LocalDateTime.parse(request.getParameter("dateFrom") + "T" + LocalTime.now().toString()));
            }
            if(!StringUtils.isEmpty(request.getParameter("dateTo"))) {
                memberModel.setEndDt(LocalDateTime.parse(request.getParameter("dateTo")+"T"+LocalTime.now().toString()));
            }

            memberModel.setRgstId(authUser.getMemberModel().getUserId());
            memberModel.setModiId(authUser.getMemberModel().getUserId());
            //저장시 회사코드와 같이 적용
            memberModel.setUserId(memberModel.getUserId()+"@"+memberModel.getCompanyCode());	
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
    	model.addAttribute("memberInfo",memberService.selectMember(authUser.getMemberModel()));
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
    	
    	model.addAttribute("memberInfo",memberService.selectMember(authUser.getMemberModel()));
    	
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
        try {
            memberModel.setRgstId(authUser.getMemberModel().getUserId());
            memberModel.setModiId(authUser.getMemberModel().getUserId());

			String result = memberService.updateMember(memberModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }
    
    /**
	 * 비밀번호 변경
	 * @param request
	 * @param model
	 * @return
	 */
	@PostMapping("/pwdChange")
	public ResponseEntity<String> pwdChange(HttpServletRequest request, @ModelAttribute MemberModel memberModel, @AuthenticationPrincipal AuthUser authUser, Model model) {
		try {
			String result = "정상적으로 비밀번호 변경되었습니다.";
			Map<String,String> param = new HashMap<String,String>();
			param.put("userId", request.getParameter("ch_userId"));
			if(!param.get("userId").equals(authUser.getMemberModel().getUserId())) {
				return new ResponseEntity<>("본인 비밀번호만 변경 가능합니다.", HttpStatus.NOT_ACCEPTABLE);
			}
			param.put("password", request.getParameter("ch_pwdOld"));
			MemberModel member = new MemberModel();
			member = securityMapper.selectUserPassCheck(param);
			if(member != null){
				member.setUserId(request.getParameter("ch_userId"));
				member.setPassword(request.getParameter("ch_pwdOld"));
				member.setNewPassword(request.getParameter("ch_pwdNew"));
				securityMapper.updateUserPassword(member);
			}else{
				result = "사용자 또는 비밀번호가 틀립니다.";
			}
			return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
	}
}