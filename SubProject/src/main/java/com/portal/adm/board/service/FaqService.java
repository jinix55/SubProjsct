package com.portal.adm.board.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.portal.adm.board.mapper.FaqMapper;
import com.portal.adm.board.model.FaqModel;
import com.portal.adm.code.service.CodeService;
import com.portal.common.paging.Criteria;

@Service
public class FaqService {

	@Resource
	private CodeService codeService;
	
	@Resource
	private FaqMapper faqMapper;
	
	public List<FaqModel> selectFaqList(Criteria criteria) {
		return faqMapper.selectFaqList(criteria);
	}
	public int selectFaqListCount(Criteria criteria) {
		return faqMapper.selectFaqListCount(criteria);
	}
	public FaqModel selectFaq(FaqModel model) {
		return faqMapper.selectFaq(model);
	}
	public long deleteFaq(FaqModel model) {
		return faqMapper.deleteFaq(model);
	}
	public long insertFaq(FaqModel model) {
		return faqMapper.insertFaq(model);
	}
	public long updateFaq(FaqModel model) {
		return faqMapper.updateFaq(model);
	}
	
    /**
     * 모든 FAQ 코드 가져오기
     * @param model
     */
	public void selectAllFaqCodeList(Model model) {
        	model.addAttribute("codeFaqCateCdList", codeService.selectGroupIdAllList("FAQ_CAT"));
        	model.addAttribute("codeUseYnList", codeService.selectGroupIdAllList("USE_YN"));		
    }	
	
}
