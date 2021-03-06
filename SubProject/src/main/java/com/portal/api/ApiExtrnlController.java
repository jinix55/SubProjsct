package com.portal.api;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartRequest;

import com.portal.adm.code.model.CodeModel;
import com.portal.adm.code.service.CodeService;
import com.portal.adm.company.model.CompanyModel;
import com.portal.adm.company.service.CompanyService;
import com.portal.adm.environmentCode.model.EnvironmentCodeModel;
import com.portal.adm.environmentCode.service.EnvironmentCodeService;
import com.portal.adm.file.service.FileService;
import com.portal.adm.product.model.ProdPackagingDetailApiModel;
import com.portal.adm.supplier.model.SupplierModel;
import com.portal.adm.supplier.service.SupplierService;
import com.portal.api.model.ApiExtrnlModel;
import com.portal.api.service.ApiExtrnlService;
import com.portal.common.IdUtil;
import com.portal.common.annotation.NoLogging;
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
    
    @Resource
    private IdUtil idUtil;
    
    @Resource
    private EnvironmentCodeService environmentCodeService;

	@Resource
	private SupplierService supplierService;
	
    @Resource
    private CodeService codeService;
    
    @Resource
    private CompanyService companyService;
    
    @Resource(name="fileService")
	private FileService service;
 
    /**
	 * 포장 api 발송
	 * @param extrnlId
	 * @return
	 */
    @RequestMapping(value="/call/sendMail" , method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String sendMail(HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser, @ModelAttribute ProdPackagingDetailApiModel prodPackagingDetailModel) {
    	ApiExtrnlModel extrnlModel = new ApiExtrnlModel();
    	
    	
    	
    	//임시 데이터(셋팅 되어야 할 목록)
        String fromCompanyNm = authUser.getMemberModel().getCompanyNm();		// 보내는 회사 명
        String fromCompanyCode = authUser.getMemberModel().getCompanyCode();		// 보내는 회사 코드
        
        String toCompanyNm = prodPackagingDetailModel.getSupplierNm();				// 받는 회사 명
        String toCompanyCode = prodPackagingDetailModel.getSupplierId();				// 받는 회사 코드
        String managerNm = prodPackagingDetailModel.getManagerNm();					// 받는 사람(담당자 명)
		String managerId = prodPackagingDetailModel.getManagerId();// 받는 사암 ID(담당자 ID)
        String managerMail = prodPackagingDetailModel.getManagerMail();					// 받는 사람(담당자 메일)
        String uuid = "";
        
        extrnlModel.setToCompanyNm(toCompanyNm);
        extrnlModel.setToCompanyCode(toCompanyCode);
        extrnlModel.setFromCompanyNm(fromCompanyNm);
        extrnlModel.setFromCompanyCode(fromCompanyCode);
        extrnlModel.setManagerId(managerId);
        extrnlModel.setManagerNm(managerNm);
        extrnlModel.setManagerMail(managerMail);
        extrnlModel.setPackagingId(prodPackagingDetailModel.getPackagingDetailId());
        extrnlModel.setRgstId(authUser.getMemberModel().getUserId());
        extrnlModel.setModiId(authUser.getMemberModel().getUserId());
        
        uuid = mailUtil.gmailSend(request,extrnlModel);
        
        extrnlModel.setApiKey(uuid);
        
        apiExtrnlService.insert(extrnlModel);
        
        
        return "success";
    }
    
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
        String toCompanyNm = "KAMILL";				// 받는 회사 명
        String toCompanyCode = "KM";				// 받는 회사 코드
        String fromCompanyNm = "(주)알티데이터랩";		// 보내는 회사 명
        String fromCompanyCode = "RTDATALAB";		// 보내는 회사 코드
        String managerNm = "아이유";					// 받는 사람(담당자 명)
        String managerId = "MNG1";					// 받는 사암 ID(담당자 ID)
        String managerMail = "";					// 받는 사람(담당자 메일)
        String uuid = "";
        
        if(email.equals("1")) {
        	managerMail = "jinix55@gmail.com";	// 받는 사람(담당자 메일)
        }else if(email.equals("2")) {
        	managerMail = "joyriver316@gmail.com";	// 받는 사람(담당자 메일)	
        }else{
        	managerMail = email;
        }
        
        extrnlModel.setToCompanyNm(toCompanyNm);
        extrnlModel.setToCompanyCode(toCompanyCode);
        extrnlModel.setFromCompanyNm(fromCompanyNm);
        extrnlModel.setFromCompanyCode(fromCompanyCode);
        extrnlModel.setManagerId(managerId);
        extrnlModel.setManagerNm(managerNm);
        extrnlModel.setManagerMail(managerMail);
        extrnlModel.setPackagingId(idUtil.getPackagingId());
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
        extrnlModel.setApiKey(apiKey);
        extrnlModel = apiExtrnlService.select(extrnlModel);
        
        model.addAttribute("model", extrnlModel);
        
        List<EnvironmentCodeModel> dayList = new ArrayList<EnvironmentCodeModel>();
        List<EnvironmentCodeModel> largeEnv = new ArrayList<EnvironmentCodeModel>();
        List<CodeModel> middleEnv = new ArrayList<CodeModel>();
        
        if(extrnlModel != null) {
        	
        	// 보낸 회사 정보
        	CompanyModel companyModels = companyService.selectCompanyCode(extrnlModel.getFromCompanyCode());
        	
        	ProdPackagingDetailApiModel prodPackagingDetailModel = new ProdPackagingDetailApiModel();
        	prodPackagingDetailModel.setPackagingDetailId(extrnlModel.getPackagingId());
        	prodPackagingDetailModel = apiExtrnlService.selectProdApiInfo(prodPackagingDetailModel);
        	
//        	dayList = environmentCodeService.selectCodeDayList();
//        	
        	EnvironmentCodeModel environmentCodeModel = new EnvironmentCodeModel();
//        	
//        	environmentCodeModel.setRevisionMonth(dayList.get(0).getRevisionMonth());
//        	environmentCodeModel.setRevisionYear(dayList.get(0).getRevisionYear());
        	
        	// 재질 유형 정보
        	environmentCodeModel.setGroupId("GROUP_ID");
        	largeEnv = environmentCodeService.selectGroupIdList(environmentCodeModel);
        	
        	// 부위 구분 정보
//        	environmentCodeModel.setGroupId(prodPackagingModel.getMatType());
//        	middleEnv = environmentCodeService.selectGroupIdList(environmentCodeModel);
        	CodeModel codeModel = new CodeModel();
        	codeModel.setGroupId("PROD_PART_TYPE");
        	middleEnv = codeService.selectGroupIdList(codeModel);
        	prodPackagingDetailModel.setApiKey(apiKey);
        	// 공급업체 담당자 정보
        	List<SupplierModel> managersModel = supplierService.selectSupplierManagers(prodPackagingDetailModel.getSupplierId());
        	
        	model.addAttribute("packagingModel",prodPackagingDetailModel);
        	model.addAttribute("largeEnv",largeEnv);
        	model.addAttribute("middleEnv",middleEnv);
        	model.addAttribute("managers",managersModel);
        	model.addAttribute("company",companyModels);
        	return "/api/emailCf";
        }else {
        	model.addAttribute("resultCode","fail");
        	return "/api/expired";
        }
    }
    
    /**
     * 포장 api 요청 처리
     * @param extrnlId
     * @return
     */
    @RequestMapping(value="/setProdPackaging/update" , method= {RequestMethod.GET,RequestMethod.POST}, produces=MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public String updatePackagingData(HttpServletRequest request, ProdPackagingDetailApiModel prodPackagingModel,Model model,  MultipartRequest multipart) {
    	return apiExtrnlService.upload(request, multipart, prodPackagingModel);
    }
    
	/**
	 * 포장 api 완료
	 * @param 
	 * @return
	 */
    @RequestMapping(value="/update/success" , method= {RequestMethod.GET,RequestMethod.POST})
    public String updateSuccess(HttpServletRequest request) {
    	return "/api/success";
    }
    
    /**
	 * 포장 api 완료
	 * @param 
	 * @return
	 */
    @RequestMapping(value="/company/{companyCode}/logo" , method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody	
    public String getCompanyLogo(HttpServletRequest request, @PathVariable("companyCode") String companyCode) {
    	return apiExtrnlService.selectCompanyLogoByCompanyCode(companyCode);
    }
    
    /**
	 * Tableau view Download
	 * @param request
	 * @return
	 */
	@NoLogging
	@RequestMapping(value="/company/file/view/{uuid}", method=RequestMethod.GET)
	public ResponseEntity<ByteArrayResource> viewUrl(HttpServletRequest request, @PathVariable String uuid) {
		ResponseEntity<ByteArrayResource> result = service.getView(request, uuid);
		return result;
	}
}
