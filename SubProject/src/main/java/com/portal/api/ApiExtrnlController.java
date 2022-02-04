package com.portal.api;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.portal.api.mapper.ApiExtrnlMapper;
import com.portal.api.model.ApiExtrnlModel;
import com.portal.api.service.ApiExtrnlService;
import com.portal.config.security.AuthUser;
import com.portal.mail.MailUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템관리 / 포장 api 요청 처리 컨트롤러
 *
 */
@RequestMapping("/api/v1")
@Controller
@Slf4j
public class ApiExtrnlController {

    @Resource
    private ApiExtrnlService apiExtrnlService;
    
    @Resource
    private MailUtil mailUtil;

 
	/**
	 * 포장 api 발송
	 * @param extrnlId
	 * @return
	 */
    @RequestMapping(value="/callTest/{email}" , method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String apiMailSend(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser, @PathVariable String email) {
    	ApiExtrnlModel extrnlModel = new ApiExtrnlModel();
    	
    	//임시 데이터(셋팅 되어야 할 목록)
        String toCompanyNm = "KAMILL";				// 보내는 회사 명
        String toCompanyCode = "KM";				// 보내는 회사 코드
        String fromCompanyNm = "PPLUS";				// 받는 회사 명
        String fromCompanyCode = "PL";				// 받는 회사 코드
        String managerNm = "홍길동";					// 받는 사람(담당자 명)
        String managerId = "mng1";					// 받는 사암 ID(담당자 ID)
        String managerMail = "";	// 받는 사람(담당자 메일)
        String uuid = "";
        
        if(email.equals("1")) {
        	managerMail = "jinix55@gmail.com";	// 받는 사람(담당자 메일)
        }else if(email.equals("2")) {
        	managerMail = "joyriver316@gmail.com";	// 받는 사람(담당자 메일)	
        }else{
        	managerMail = email;
        }
        
        log.info("managerMail >> "+managerMail);
        
        extrnlModel.setToCompanyNm(toCompanyNm);
        extrnlModel.setToCompanyCode(toCompanyCode);
        extrnlModel.setFromCompanyNm(fromCompanyNm);
        extrnlModel.setFromCompanyCode(fromCompanyCode);
        extrnlModel.setManagerId(managerId);
        extrnlModel.setManagerNm(managerNm);
        extrnlModel.setManagerMail(managerMail);
        extrnlModel.setRgstId(authUser.getMemberModel().getUserId());
        extrnlModel.setModiId(authUser.getMemberModel().getUserId());
        
        uuid = mailUtil.gmailSend(request,extrnlModel);
        
        extrnlModel.setApiKey(uuid);
        
        apiExtrnlService.insert(extrnlModel);
        
        return "success";
    }
    
	/**
	 * 포장 api 요청 처리
	 * @param extrnlId
	 * @return
	 */
    @RequestMapping(value="/setProdPackaging/{apiKey}" , method= {RequestMethod.GET,RequestMethod.POST})
    public String apiSelect(HttpServletRequest request, Model model, @PathVariable("apiKey") String apiKey) {

        ApiExtrnlModel extrnlModel = new ApiExtrnlModel();
        System.out.println("apiKey : "+apiKey);
        extrnlModel.setApiKey(apiKey);
        extrnlModel = apiExtrnlService.select(extrnlModel);
        
        model.addAttribute("model", extrnlModel);
        
        if(extrnlModel != null) {
        	return "/api/emailCf";
        }else {
        	return "/api/expired";
        }
    }
    
}
