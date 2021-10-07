package com.portal.adm.member;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

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
import com.portal.adm.dept.service.DeptService;
import com.portal.adm.member.model.MemberCriteria;
import com.portal.adm.member.model.MemberModel;
import com.portal.adm.member.service.MemberService;
import com.portal.adm.role.model.RoleModel;
import com.portal.adm.role.service.RoleService;
import com.portal.config.security.AuthUser;

/**
 * 사용자관리/사용자관리 컨트롤러
 */
@RequestMapping("/admin")
@Controller
public class MemberController {

    @Resource
    private MemberService memberService;

    @Resource
    private CodeService codeService;

    @Resource
    private RoleService roleService;
    
    @Resource
    private DeptService deptService;
    
    /**
     * 사용자관리 페이지로 이동한다.
     *
     * @param model
     * @return
     */
    @GetMapping("/member")
    public String list(@ModelAttribute MemberCriteria criteria, Model model, @AuthenticationPrincipal AuthUser authUser) {

        // 화면 표시용 코드 셋팅
        // 회사구분 코드
        model.addAttribute("codeCompanyCdList", codeService.selectGroupIdAllList("COMPANY_CODE"));
        // 사용여부 코드
        model.addAttribute("codeUseYnList", codeService.selectGroupIdAllList("USE_YN"));
        
        // 기간 사용 적용 여부 코드
        model.addAttribute("dateLimitYnList", codeService.selectGroupIdAllList("DATE_LIMIT_YN"));    
        
        // 검색구분 코드
        model.addAttribute("codeMemSearchCdList", codeService.selectGroupIdAllList("USER_SEARCH_CODE"));

        // 권한코드 조회
        model.addAttribute("roles", roleService.selectAllList());

        // 관리자권한코드 조회
        RoleModel role =  new RoleModel();
        model.addAttribute("mgrRoles", roleService.selectMgrSysAuthAllList(role));

        criteria.setCompanyCode(authUser.getMemberModel().getCompanyCode());
        criteria.setAuthId(authUser.getMemberModel().getAuthId());
        
        model.addAttribute("members", memberService.selectMemberList(criteria));
        criteria.setTotalCount(memberService.selectMemberListCount(criteria));
        model.addAttribute("pages", criteria);

        return "member/member";
    }

    @PostMapping("/member")
    public String list(@ModelAttribute MemberCriteria criteria, RedirectAttributes attributes, Model model, @AuthenticationPrincipal AuthUser authUser) {

        attributes.addFlashAttribute("criteria", criteria);

        // 화면 표시용 코드 셋팅
        // 회사구분 코드
        model.addAttribute("codeCompanyCdList", codeService.selectGroupIdAllList("COMPANY_CODE"));
        // 사용여부 코드
        model.addAttribute("codeUseYnList", codeService.selectGroupIdAllList("USE_YN"));
        
        // 기간 사용 적용 여부 코드
        model.addAttribute("dateLimitYnList", codeService.selectGroupIdAllList("DATE_LIMIT_YN"));   
        
        // 검색구분 코드
        model.addAttribute("codeMemSearchCdList", codeService.selectGroupIdAllList("USER_SEARCH_CODE"));

        // 권한코드 조회
        model.addAttribute("roles", roleService.selectAllList());

        // 관리자권한코드 조회
        RoleModel role =  new RoleModel();
        model.addAttribute("mgrRoles", roleService.selectMgrSysAuthAllList(role));
        
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
    public MemberModel select(@PathVariable String memberId) {

        MemberModel memberModel = new MemberModel();
        memberModel.setUserId(memberId);

        return memberService.selectMember(memberModel);
    }

    @PostMapping("/member/update")
    public ResponseEntity<String> update(@RequestParam String startDate, @RequestParam String endDate,
                                       @ModelAttribute MemberModel memberModel,
                                       @AuthenticationPrincipal AuthUser authUser) {

        try {
            if(!StringUtils.isEmpty(startDate)) {
                memberModel.setStartDt(LocalDateTime.parse(startDate + "T" + LocalTime.now().toString()));
            }
            if(!StringUtils.isEmpty(endDate)) {
                memberModel.setEndDt(LocalDateTime.parse(endDate+"T"+LocalTime.now().toString()));
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
    public ResponseEntity<String> insert(@RequestParam String startDate, @RequestParam String endDate,
                                       @ModelAttribute MemberModel memberModel,
                                       @AuthenticationPrincipal AuthUser authUser) {

        try {
            if(!StringUtils.isEmpty(startDate)) {
                memberModel.setStartDt(LocalDateTime.parse(startDate + "T" + LocalTime.now().toString()));
            }
            if(!StringUtils.isEmpty(endDate)) {
                memberModel.setEndDt(LocalDateTime.parse(endDate+"T"+LocalTime.now().toString()));
            }

            memberModel.setRgstId(authUser.getMemberModel().getUserId());
            memberModel.setModiId(authUser.getMemberModel().getUserId());

            String result = memberService.insert(memberModel);

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
        // 부서 조회
        model.addAttribute("depts", deptService.selectDeptClList());

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
}