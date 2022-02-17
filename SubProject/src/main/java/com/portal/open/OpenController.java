package com.portal.open;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.portal.adm.environmentCode.model.EnvironmentCodeModel;
import com.portal.adm.environmentCode.service.EnvironmentCodeService;

import lombok.extern.slf4j.Slf4j;

/**
 * open 화면 처리 컨트롤러
 *
 */
@RequestMapping("/open")
@Controller
@Slf4j
public class OpenController {
	
    @Resource
    private EnvironmentCodeService environmentCodeService;

	/**
	 * 포장 자가진단 공개 화면
	 * @param
	 * @return
	 */
    @RequestMapping(value="/selfDiagnosis" , method= {RequestMethod.GET,RequestMethod.POST})
    public String selfDiagnosis(HttpServletRequest request, @ModelAttribute EnvironmentCodeModel environmentCodeModel, Model model) {
    	List<EnvironmentCodeModel> dayList = new ArrayList<EnvironmentCodeModel>();
    	List<EnvironmentCodeModel> largeModels = new ArrayList<EnvironmentCodeModel>();
    	List<EnvironmentCodeModel> middleModels = new ArrayList<EnvironmentCodeModel>();
    	List<EnvironmentCodeModel> smallModels = new ArrayList<EnvironmentCodeModel>();
    	List<EnvironmentCodeModel> lastModels = new ArrayList<EnvironmentCodeModel>();
    	System.out.println("##### environmentCodeModel : "+environmentCodeModel.toString());
    	model.addAttribute("setLargeCategory", environmentCodeModel.getLargeCategory());
    	dayList = environmentCodeService.selectCodeDayList();
    	model.addAttribute("dayList", dayList.get(0));
    	
    	environmentCodeModel.setRevisionYear(dayList.get(0).getRevisionYear());
    	environmentCodeModel.setRevisionMonth(dayList.get(0).getRevisionMonth());
    	
    	String largeCategory = "GROUP_ID";
    	environmentCodeModel.setGroupId(largeCategory);
    	largeModels = environmentCodeService.selectGroupIdList(environmentCodeModel);
    	model.addAttribute("largeCodeList", largeModels);
    	System.out.println("##### largeModels : " + largeModels);
    	
    	System.out.println("##### environmentCodeModel.getLargeCategory() : " + environmentCodeModel.getLargeCategory());
    	if(environmentCodeModel.getLargeCategory() == null || environmentCodeModel.getLargeCategory().equals("")) {
    		largeCategory = largeModels.get(0).getCodeId();
    	}else {
    		largeCategory = environmentCodeModel.getLargeCategory();
    	}
    	environmentCodeModel.setGroupId(largeCategory);
    	middleModels = environmentCodeService.selectGroupIdList(environmentCodeModel);
    	model.addAttribute("middleCodeList", middleModels);
    	System.out.println("##### middleModels : " + middleModels);
    	
    	ArrayList<EnvironmentCodeModel> list = new ArrayList<EnvironmentCodeModel>();
    	for(EnvironmentCodeModel m : middleModels) {
    		environmentCodeModel.setGroupId(m.getCodeId());
    		smallModels = environmentCodeService.selectGroupIdList(environmentCodeModel);
    		list.addAll(smallModels);
    	}
    	
    	Collections.sort(list,new Comparator<EnvironmentCodeModel>() {
			@Override
			public int compare(EnvironmentCodeModel o1, EnvironmentCodeModel o2) {
				// TODO Auto-generated method stub
				return o1.getOrdSeq() - o2.getOrdSeq();
			}
		});
    	model.addAttribute("smallCodeList", list);
    	
    	ArrayList<EnvironmentCodeModel> lalist = new ArrayList<EnvironmentCodeModel>();
    	for(EnvironmentCodeModel l :list) {
    		environmentCodeModel.setGroupId(l.getCodeId());
    		lastModels = environmentCodeService.selectGroupIdList(environmentCodeModel);
    		lalist.addAll(lastModels);
    	}
    	model.addAttribute("lastCodeList", lalist);
    	
        return "/open/selfDiagnosis";
    }
    
}
