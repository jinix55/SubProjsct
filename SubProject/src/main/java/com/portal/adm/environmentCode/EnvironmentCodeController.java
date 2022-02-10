package com.portal.adm.environmentCode;

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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.portal.adm.environmentCode.model.EnvironmentCodeModel;
import com.portal.adm.environmentCode.service.EnvironmentCodeService;
import com.portal.config.security.AuthUser;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템관리 / 환경부 코드관리 컨트롤러
 */
@Slf4j
@RequestMapping("/system")
@Controller
public class EnvironmentCodeController {

    @Resource
    private EnvironmentCodeService environmentCodeService;
    
    /**
     * 환경부 코드관리 페이지로 이동
     *
     * @param model
     * @return
     */
    @RequestMapping(value="/environmentCode", method= {RequestMethod.GET,RequestMethod.POST})
    public String environmentCode(@ModelAttribute EnvironmentCodeModel environmentCodeModel, Model model, @AuthenticationPrincipal AuthUser authUser) {
    	System.out.println("===================environmentCode==================");
    	System.out.println("=== environmentCodeModel => : "+environmentCodeModel);
    	String largeCategory = "GROUP_ID";
    	if(environmentCodeModel.getLargeCategory() == null || environmentCodeModel.getGroupId() == null || StringUtils.equals(environmentCodeModel.getGroupId(),"")) {
    		largeCategory = "GROUP_ID";
    	}
		model.addAttribute("setLargeCategory", environmentCodeModel.getLargeCategory());
    	
    	if(environmentCodeModel.getRevision() != null) {
    		environmentCodeModel.setRevision(environmentCodeModel.getRevision().replace("-", ""));
    		model.addAttribute("setRevision", environmentCodeModel.getRevision().replace("-", ""));
    	}
    	List<EnvironmentCodeModel> dayList = new ArrayList<EnvironmentCodeModel>();
    	List<EnvironmentCodeModel> largeModels = new ArrayList<EnvironmentCodeModel>();
    	List<EnvironmentCodeModel> middleModels = new ArrayList<EnvironmentCodeModel>();
    	List<EnvironmentCodeModel> smallModels = new ArrayList<EnvironmentCodeModel>();
    	
    	dayList = environmentCodeService.selectCodeDayList();
    	if(dayList.size() > 0) {
    		for(int i = 0 ; i < dayList.size() ; i++) {
    			dayList.get(i).setRevision(dayList.get(i).getRevisionYear()+dayList.get(i).getRevisionMonth());
    		}
    	}
    	model.addAttribute("dayList", dayList);
    	model.addAttribute("defaultDay", dayList.get(0).getRevisionYear()+"-"+dayList.get(0).getRevisionMonth());
    	
    	if(environmentCodeModel.getRevision() == null || StringUtils.equals(environmentCodeModel.getRevision(),"") ) {
    		if(environmentCodeModel.getRevisionMonth() == null || StringUtils.equals(environmentCodeModel.getRevisionMonth(), "") 
    				|| environmentCodeModel.getRevisionYear() == null || StringUtils.equals(environmentCodeModel.getRevisionYear(), "") ) {
    			environmentCodeModel.setRevisionMonth(dayList.get(0).getRevisionMonth());
    			environmentCodeModel.setRevisionYear(dayList.get(0).getRevisionYear());
    			environmentCodeModel.setRevision(dayList.get(0).getRevisionYear()+dayList.get(0).getRevisionMonth());
    			model.addAttribute("setRevision", environmentCodeModel.getRevision());
    		}
    	}else {
    		String[] revision = environmentCodeModel.getRevision().split("-");
    		if(revision.length > 1) {
    			environmentCodeModel.setRevisionYear(revision[0]);
    			environmentCodeModel.setRevisionMonth(revision[1]);
    		}else {
    			environmentCodeModel.setRevisionYear(environmentCodeModel.getRevision().substring(0, 4));
    			environmentCodeModel.setRevisionMonth(environmentCodeModel.getRevision().substring(4, 6));
    		}
    	}
    	
    	System.out.println("=== environmentCodeModel 222=> : "+environmentCodeModel);
    	// 재질 리스트
    	environmentCodeModel.setGroupId(largeCategory);
		environmentCodeModel.setAuthId(authUser.getMemberModel().getAuthId());
		
		System.out.println("=== environmentCodeModel 333=> : "+environmentCodeModel);
		
        largeModels = environmentCodeService.selectGroupIdList(environmentCodeModel);
        model.addAttribute("largeCodeList", largeModels);
        
    	if(largeModels.size() > 0) {
    		if(environmentCodeModel.getLargeCategory() == null){
    			largeModels.get(0).setGroupId(largeModels.get(0).getCodeId());
    		}else {
    			largeModels.get(0).setGroupId(environmentCodeModel.getLargeCategory());
    		}
    		middleModels = environmentCodeService.selectGroupIdList(largeModels.get(0));
    		model.addAttribute("middleCodeList", middleModels);
    		model.addAttribute("middlePages", environmentCodeModel);
    	}
    	
    	
        // 부위 리스트
        if(middleModels.size() > 0) {
        	String middleCategory = "";
        	if((environmentCodeModel.getMiddleCategory() == null || StringUtils.equals(environmentCodeModel.getMiddleCategory(), "")) ||
        			environmentCodeModel.getMiddleCategory().equals(environmentCodeModel.getLargeCategory())) {
        		middleCategory = middleModels.get(0).getCodeId();
        	}else {
        		middleCategory = environmentCodeModel.getMiddleCategory();
        	}
        	model.addAttribute("setMiddleCategory", environmentCodeModel.getLargeCategory());
        	environmentCodeModel.setGroupId(middleCategory);
        	smallModels = environmentCodeService.selectGroupIdList(environmentCodeModel);
        	environmentCodeModel.setTotalCount(environmentCodeService.selectGroupIdListCount(environmentCodeModel));
        	model.addAttribute("smallCodeList", smallModels);
        }
        
        return "environmentCode/environmentCode";
    }


    /**
     * 환경부 코드 내용 목록을 조회한다.
     *
     * @param groupCd
     * @return
     */
    @RequestMapping(value="/environmentCode/detail/{codeId}", method= {RequestMethod.GET,RequestMethod.POST})
    public ResponseEntity<List<EnvironmentCodeModel>> codesForGroupCd(@ModelAttribute EnvironmentCodeModel environmentCodeModel, @PathVariable("codeId") String codeId) {
    	
    	environmentCodeModel.setGroupId(environmentCodeModel.getSmallCategory());
    	if(environmentCodeModel.getRevision() != null && !StringUtils.equals(environmentCodeModel.getRevision(), "")) {
    		String[] revision = environmentCodeModel.getRevision().split("-");
    		environmentCodeModel.setRevisionYear(revision[0]);
    		environmentCodeModel.setRevisionMonth(revision[1]);
    	}
    	List<EnvironmentCodeModel> detailCodeList = environmentCodeService.selectList(environmentCodeModel);
    	
    	return new ResponseEntity<>(detailCodeList, HttpStatus.OK);
    }
    
    
    
    /**
     * 그룹코드 목록을 조회한다.
     *
     * @param groupCd
     * @return
     */
    @RequestMapping(value="/environmentCode/detail/select/{codeId}", method= {RequestMethod.GET,RequestMethod.POST})
    public ResponseEntity<EnvironmentCodeModel> codesForCodeId(@ModelAttribute EnvironmentCodeModel environmentCodeModel, @PathVariable("codeId") String codeId) {
    	environmentCodeModel.setGroupId(environmentCodeModel.getGroupId());
    	if(environmentCodeModel.getDeRevision() != null && !StringUtils.equals(environmentCodeModel.getDeRevision(), "")) {
    		String[] revision = environmentCodeModel.getDeRevision().split("-");
    		environmentCodeModel.setRevisionYear(revision[0]);
    		environmentCodeModel.setRevisionMonth(revision[1]);
    	}
    	environmentCodeModel.setCodeId(codeId);
        EnvironmentCodeModel detailCodeList = environmentCodeService.select(environmentCodeModel);
        return new ResponseEntity<>(detailCodeList, HttpStatus.OK);
    }
    

    /**
     * 환경부 코드를 저장한다. 카테고리 기준으로 그룹ID와 코드ID가 동일한 데이터가 존재하면 업데이트 없으면 신규 등록한다.
     *
     * @param environmentCodeModel
     * @return
     */
    @PostMapping("/environmentCode/insert/{category}")
    @ResponseBody
    public ResponseEntity<String> save(@ModelAttribute EnvironmentCodeModel environmentCodeModel, HttpServletRequest request, @PathVariable("category") String category, @AuthenticationPrincipal AuthUser authUser) {
    	try {
            for (String key : request.getParameterMap().keySet()) {
            	log.debug("===== request.Parameter" + key + " :" + request.getParameter(key));
            }
            
            System.out.println("== category => "+category);
            System.out.println("== environmentCodeModel => "+environmentCodeModel);
            
            String groupId = "";
    		String codeId = "";
    		String codeNm = "";
    		String codeKey = "";
    		String codeDsc = "";
    		String codeUseYn = "Y";
    		String revisionYear = "";
    		String revisionMonth = "";
    		int ordSeq = -1;
    		
            if(category.equals("middle")) {
            	groupId = environmentCodeModel.getMidGroupId();
            	codeId = environmentCodeModel.getMidCodeId();
            	codeNm = environmentCodeModel.getMidCodeNm();
            	codeKey = environmentCodeModel.getMidCodeKey();
            	codeDsc = environmentCodeModel.getMidCodeDsc();
            	ordSeq = environmentCodeModel.getMidOrdSeq();
            	String[] revision = environmentCodeModel.getMidRevision().split("-");
            	revisionYear = revision[0];
            	revisionMonth = revision[1];
            }else if(category.equals("small")) {
            	groupId = environmentCodeModel.getSmlGroupId();
            	codeId = environmentCodeModel.getSmlCodeId();
            	codeNm = environmentCodeModel.getSmlCodeNm();
            	codeKey = environmentCodeModel.getSmlCodeKey();
            	codeDsc = environmentCodeModel.getSmlCodeDsc();
            	ordSeq = environmentCodeModel.getSmlOrdSeq();
            	String[] revision = environmentCodeModel.getSmlRevision().split("-");
            	revisionYear = revision[0];
            	revisionMonth = revision[1];
            }else if(category.equals("detail")) {
            	groupId = environmentCodeModel.getDeGroupId();
            	codeId = environmentCodeModel.getDeCodeId();
            	codeNm = environmentCodeModel.getDeCodeNm();
            	codeKey = environmentCodeModel.getDeCodeKey();
            	codeDsc = environmentCodeModel.getDeCodeDsc();
            	ordSeq = environmentCodeModel.getDeOrdSeq();
            	String[] revision = environmentCodeModel.getDeRevision().split("-");
            	revisionYear = revision[0];
            	revisionMonth = revision[1];
            }
            
            environmentCodeModel.setCodeId(codeId);
            environmentCodeModel.setCodeNm(codeNm);
            environmentCodeModel.setCodeDsc(codeDsc);
            environmentCodeModel.setUseYn(codeUseYn);
            environmentCodeModel.setCodeKey(codeKey);
            environmentCodeModel.setOrdSeq(ordSeq);
            environmentCodeModel.setRevisionYear(revisionYear);
            environmentCodeModel.setRevisionMonth(revisionMonth);
            
            if(groupId != null && !StringUtils.equals(groupId, "")) {
            	 environmentCodeModel.setGroupId(groupId);
            }else {
            	environmentCodeModel.setGroupId("GROUP_ID");
            }

            environmentCodeModel.setRgstId(authUser.getMemberModel().getUserId());
            environmentCodeModel.setModiId(authUser.getMemberModel().getUserId());
            
            System.out.println("== environmentCodeModel 222 => "+environmentCodeModel);

            String result = environmentCodeService.save(environmentCodeModel);

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
    @PostMapping("/environmentCode/delete")
    public ResponseEntity<String> codeDelete(@ModelAttribute EnvironmentCodeModel environmentCodeModel, HttpServletRequest request, @AuthenticationPrincipal AuthUser authUser) {
        try {
        	String revisionYear = "";
        	String revisionMonth = "";
        	String[] revision = environmentCodeModel.getDelRevision().split("-");
        	revisionYear = revision[0];
        	revisionMonth = revision[1];
        	environmentCodeModel.setGroupId(environmentCodeModel.getDelGroupId());
        	environmentCodeModel.setCodeId(environmentCodeModel.getDelCodeId());
        	environmentCodeModel.setRevisionYear(revisionYear);
        	environmentCodeModel.setRevisionMonth(revisionMonth);
        	environmentCodeModel.setRgstId(authUser.getMemberModel().getUserId());
        	environmentCodeModel.setModiId(authUser.getMemberModel().getUserId());
        	System.out.println("== groupDelete 222 => "+environmentCodeModel);
            String result = environmentCodeService.delete(environmentCodeModel);
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }

    /**
     * 환경부 코드를 삭제한다.
     *
     * @param environmentCodeModel
     * @return
     */
    @PostMapping("/environmentCode/delete/{codeId}")
    public ResponseEntity<String> delete(@ModelAttribute EnvironmentCodeModel environmentCodeModel, @AuthenticationPrincipal AuthUser authUser) {
        try {
            environmentCodeModel.setRgstId(authUser.getMemberModel().getUserId());
            environmentCodeModel.setModiId(authUser.getMemberModel().getUserId());

            String result = environmentCodeService.delete(environmentCodeModel);

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }
    }


}
