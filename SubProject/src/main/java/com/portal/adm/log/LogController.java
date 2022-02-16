package com.portal.adm.log;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.portal.adm.code.service.CodeService;
import com.portal.adm.log.model.LogModel;
import com.portal.adm.log.service.LogService;
import com.portal.adm.member.service.MemberService;
import com.portal.adm.role.service.RoleService;
import com.portal.common.paging.Criteria;

/**
 * 사용자관리/로그관리 컨트롤러
 */
@RequestMapping("/log")
@Controller
public class LogController {

    @Resource
    private LogService logService;
   
    @Resource
    private MemberService memberService;

    @Resource
    private CodeService codeService;

    @Resource
    private RoleService roleService;

    /**
     * 로그관리 페이지로 이동한다.
     *
     * @param model
     * @return
     */
    @GetMapping("/loginHst")
    public String getLoginLog(@ModelAttribute LogModel logModel, Model model) {
        model.addAttribute("logs", logService.selectMgrLoginList(logModel));
        logModel.setTotalCount(logService.selectMgrLoginCount(logModel));
        model.addAttribute("pages", logModel);

        return "log/loginHst";
    }

    @PostMapping("/loginHst")
    public String postLoginLog(@ModelAttribute LogModel logModel, @RequestParam String startDate, @RequestParam String endDate, RedirectAttributes attributes) {

//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
//
//        if(!StringUtils.isEmpty(startDate)) {
//            criteria.setStartDt(startDate);
//        }
//        if(!StringUtils.isEmpty(endDate)) {
//            criteria.setEndDt(endDate);
//        }
//
//        attributes.addFlashAttribute("criteria", criteria);

        return "redirect:/log/loginHst";
    }
    
    /**
     * 로그관리 페이지로 이동한다.
     *
     * @param model
     * @return
     */
    @GetMapping("/jobHst")
    public String getJobHstLog(@ModelAttribute LogModel logModel, Model model) {
    model.addAttribute("logs", logService.selectJobLogList(logModel));
    logModel.setTotalCount(logService.selectJobLogCount(logModel));
    model.addAttribute("pages", logModel);
    	
    	return "log/jobHst";
    }
    
    @PostMapping("/jobHst")
    public String postJobHstLog(@ModelAttribute LogModel criteria, @RequestParam String startDate, @RequestParam String endDate, RedirectAttributes attributes) {
    	
//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
//
//        if(!StringUtils.isEmpty(startDate)) {
//            criteria.setStartDt(startDate);
//        }
//        if(!StringUtils.isEmpty(endDate)) {
//            criteria.setEndDt(endDate);
//        }
//
//        attributes.addFlashAttribute("criteria", criteria);
    	
    	return "redirect:/log/jobHst";
    }
}
