package com.portal.adm.packagingCode;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.portal.adm.packagingCode.model.PackagingCodeModel;
import com.portal.adm.packagingCode.service.PackagingCodeService;
import com.portal.config.security.AuthUser;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템관리 / 환경부 코드관리 컨트롤러
 */
@Slf4j
@RequestMapping("/system")
@Controller
public class PackagingCodeController {

    @Resource
    private PackagingCodeService packagingCodeService;
    
    /**
     * 환경부 코드관리 페이지로 이동
     *
     * @param model
     * @return
     */
    @RequestMapping(value="/packagingCode", method= {RequestMethod.GET,RequestMethod.POST})
    public String packagingCode(@ModelAttribute PackagingCodeModel packagingCodeModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	String largeCategory = "GROUP_ID";
    	if(packagingCodeModel.getGroupId() == null || StringUtils.equals(packagingCodeModel.getGroupId(),"")) {
    		largeCategory = "GROUP_ID";
    	}else {
    		largeCategory = packagingCodeModel.getGroupId();
    	}
    	
    	List<PackagingCodeModel> largeModels = new ArrayList<PackagingCodeModel>();
    	List<PackagingCodeModel> middleModels = new ArrayList<PackagingCodeModel>();
    	packagingCodeModel.setUpCompanyCode(authUser.getMemberModel().getCompanyCode());
    	
    	// 대분류 리스트
    	packagingCodeModel.setGroupId(largeCategory);
		packagingCodeModel.setAuthId(authUser.getMemberModel().getAuthId());
        largeModels = packagingCodeService.selectGroupIdList(packagingCodeModel);
        model.addAttribute("largeCodeList", largeModels);
        
        
        //  중분류 리스트
        if(largeModels.size() > 0) {
        	String middleCategory = "";
        	String middleCategoryNm = "";
        	if(packagingCodeModel.getMiddleCategory() == null || StringUtils.equals(packagingCodeModel.getMiddleCategory(), "") ||
        			packagingCodeModel.getMiddleCategory().equals(packagingCodeModel.getLargeCategory())) {
        		middleCategory = largeModels.get(0).getCodeId();
        		middleCategoryNm = largeModels.get(0).getCodeNm();
        	}else {
        		middleCategory = packagingCodeModel.getMiddleCategory();
        	}
        	model.addAttribute("setMiddleCategory", middleCategory);
        	model.addAttribute("setMiddleCategoryNm", middleCategoryNm);
        	packagingCodeModel.setGroupId(middleCategory);
        	middleModels = packagingCodeService.selectGroupIdList(packagingCodeModel);
        	model.addAttribute("middleCodeList", middleModels);
        }
    	
		model.addAttribute("setLargeCategory", packagingCodeModel.getLargeCategory());
		model.addAttribute("setSmallCategory", packagingCodeModel.getSmallCategory());
    	
        return "packagingCode/packagingCode";
    }


    /**
     * 환경부 코드 내용 목록을 조회한다.
     *
     * @param groupCd
     * @return
     */
    @RequestMapping(value="/packagingCode/detail/{codeId}", method= {RequestMethod.GET,RequestMethod.POST})
    public ResponseEntity<List<PackagingCodeModel>> codesForGroupCd(@ModelAttribute PackagingCodeModel packagingCodeModel, @PathVariable("codeId") String codeId, @AuthenticationPrincipal AuthUser authUser) {
    	packagingCodeModel.setGroupId(codeId);
    	packagingCodeModel.setUpCompanyCode(authUser.getMemberModel().getCompanyCode());
    	List<PackagingCodeModel> detailCodeList = packagingCodeService.selectList(packagingCodeModel);
    	
    	return new ResponseEntity<>(detailCodeList, HttpStatus.OK);
    }
    
    
    

    /**
     * 환경부 코드를 저장한다. 카테고리 기준으로 그룹ID와 코드ID가 동일한 데이터가 존재하면 업데이트 없으면 신규 등록한다.
     *
     * @param packagingCodeModel
     * @return
     */
    @PostMapping("/packagingCode/insert/{category}")
    @ResponseBody
    public ResponseEntity<String> save(@ModelAttribute PackagingCodeModel packagingCodeModel, HttpServletRequest request, @PathVariable("category") String category, @AuthenticationPrincipal AuthUser authUser) {
    	try {
            for (String key : request.getParameterMap().keySet()) {
            	log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
            }
            
            String groupId = "";
    		String codeId = "";
    		String codeNm = "";
    		String codeKey = "";
    		String codeDsc = "";
    		String codeUseYn = "Y";
    		int ordSeq = -1;
    		
            if(category.equals("large")) {
            	groupId = packagingCodeModel.getLarGroupId();
            	codeId = packagingCodeModel.getLarCodeId();
            	codeNm = packagingCodeModel.getLarCodeNm();
            	codeKey = packagingCodeModel.getLarCodeKey();
            	codeDsc = packagingCodeModel.getLarCodeDsc();
            	ordSeq = packagingCodeModel.getLarOrdSeq();
            }else if(category.equals("middle")) {
            	groupId = packagingCodeModel.getMidGroupId();
            	codeId = packagingCodeModel.getMidCodeId();
            	codeNm = packagingCodeModel.getMidCodeNm();
            	codeKey = packagingCodeModel.getMidCodeKey();
            	codeDsc = packagingCodeModel.getMidCodeDsc();
            	ordSeq = packagingCodeModel.getMidOrdSeq();

            }else if(category.equals("small")) {
            	groupId = packagingCodeModel.getSmlGroupId();
            	codeId = packagingCodeModel.getSmlCodeId();
            	codeNm = packagingCodeModel.getSmlCodeNm();
            	codeKey = packagingCodeModel.getSmlCodeKey();
            	codeDsc = packagingCodeModel.getSmlCodeDsc();
            	ordSeq = packagingCodeModel.getSmlOrdSeq();
            }
            
            packagingCodeModel.setCodeId(codeId);
            packagingCodeModel.setCodeNm(codeNm);
            packagingCodeModel.setCodeDsc(codeDsc);
            packagingCodeModel.setUseYn(codeUseYn);
            packagingCodeModel.setCodeKey(codeKey);
            packagingCodeModel.setOrdSeq(ordSeq);
            packagingCodeModel.setUpCompanyCode(authUser.getMemberModel().getCompanyCode());
            if(groupId != null && !StringUtils.equals(groupId, "")) {
            	 packagingCodeModel.setGroupId(groupId);
            }else {
            	packagingCodeModel.setGroupId("GROUP_ID");
            }

            packagingCodeModel.setRgstId(authUser.getMemberModel().getUserId());
            packagingCodeModel.setModiId(authUser.getMemberModel().getUserId());
            
            String result = packagingCodeService.save(packagingCodeModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }

    /**
     * 코드그룹을 삭제한다.
     *
     * @param request
     * @return
     */
    @PostMapping("/packagingCode/delete")
    public ResponseEntity<String> codeDelete(@ModelAttribute PackagingCodeModel packagingCodeModel, HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
        try {
        	packagingCodeModel.setGroupId(packagingCodeModel.getDelGroupId());
        	packagingCodeModel.setCodeId(packagingCodeModel.getDelCodeId());
        	packagingCodeModel.setRgstId(authUser.getMemberModel().getUserId());
        	packagingCodeModel.setModiId(authUser.getMemberModel().getUserId());
        	packagingCodeModel.setUpCompanyCode(authUser.getMemberModel().getCompanyCode());
            String result = packagingCodeService.delete(packagingCodeModel);
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }

    /**
     * 환경부 코드를 삭제한다.
     *
     * @param packagingCodeModel
     * @return
     */
    @PostMapping("/packagingCode/delete/{codeId}")
    public ResponseEntity<String> delete(@ModelAttribute PackagingCodeModel packagingCodeModel, @AuthenticationPrincipal AuthUser authUser) {
        try {
            packagingCodeModel.setRgstId(authUser.getMemberModel().getUserId());
            packagingCodeModel.setModiId(authUser.getMemberModel().getUserId());
            packagingCodeModel.setUpCompanyCode(authUser.getMemberModel().getCompanyCode());
            String result = packagingCodeService.delete(packagingCodeModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }


}
