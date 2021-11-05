package com.portal.adm.holiday;

import java.time.LocalDateTime;
import java.time.LocalTime;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.portal.adm.holiday.model.HolidayModel;
import com.portal.adm.holiday.service.HolidayService;
import com.portal.adm.member.model.MemberModel;
import com.portal.config.security.AuthUser;

/**
 * 사용자관리/사용자관리 컨트롤러
 */
@RequestMapping("/system")
@Controller
public class HolidayController {

    @Resource
    private HolidayService service;
    
    /**
     * 사용자관리 페이지로 이동한다.
     *
     * @param model
     * @param String 
     * @return
     */
    @GetMapping("/holiday")
    public String list(@ModelAttribute HolidayModel criteria, Model model) {
    		System.out.println("get totalCount : "+service.selectHolidayListCount(criteria));
    		model.addAttribute("list", service.selectHolidayList(criteria));
    	
    		criteria.setTotalCount(service.selectHolidayListCount(criteria));
    		model.addAttribute("pages", criteria);
        return "holiday/holidayMgt";
    }

    @PostMapping("/holiday")
    public String list(@ModelAttribute HolidayModel criteria, RedirectAttributes attributes, Model model) {
    	System.out.println("post totalCount : "+service.selectHolidayListCount(criteria));
		model.addAttribute("list", service.selectHolidayList(criteria));
		criteria.setTotalCount(service.selectHolidayListCount(criteria));
		model.addAttribute("pages", criteria);
        return "holiday/holidayMgt";
    }
    

    @PostMapping("/holiday/detail/{solarDate}")
    @ResponseBody
    public HolidayModel select(@PathVariable String solarDate) {

    	HolidayModel holidayModel = new HolidayModel();
    	holidayModel.setSolarDate(solarDate);

        return service.selectHolidayOne(solarDate);
        		
    }
    
    @PostMapping("/holiday/update")
    public ResponseEntity<String> update(@ModelAttribute HolidayModel holidayModel){
        try {
        	holidayModel.setSolarDate(holidayModel.getSolarDateView());
        	holidayModel.setHoliType(holidayModel.getHoliTypeView());
            holidayModel.setHoliNm(holidayModel.getHoliNmView());
            holidayModel.setUseYn(holidayModel.getUseYnView());
            holidayModel.setMemo(holidayModel.getMemo());
            

            String result = service.save(holidayModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }
    
    @PostMapping("/holiday/insert")
    public ResponseEntity<String> insert(@ModelAttribute HolidayModel holidayModel){

    	 try {
    		 holidayModel.setSolarDate(holidayModel.getSolarDateView());
         	 holidayModel.setHoliType(holidayModel.getHoliTypeView());
             holidayModel.setHoliNm(holidayModel.getHoliNmView());
             holidayModel.setUseYn(holidayModel.getUseYnView());
             holidayModel.setMemo(holidayModel.getMemo());
             

             String result = service.insert(holidayModel);

             return new ResponseEntity<>(result, HttpStatus.OK);
         } catch (Exception e) {
             return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
         }
     }
    
    @PostMapping("/holiday/update/active")
    @ResponseBody
    public ResponseEntity<String> active(@ModelAttribute HolidayModel holidayModel ,HttpServletRequest request){
    	
        try {
        	holidayModel.setSolarDate(request.getParameter("solarDate"));
        	holidayModel.setUseYn(request.getParameter("useYn"));
            

            String result = service.holidayActive(holidayModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }
}