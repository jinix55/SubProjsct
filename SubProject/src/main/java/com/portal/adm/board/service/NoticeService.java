package com.portal.adm.board.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.portal.adm.board.mapper.NoticeMapper;
import com.portal.adm.board.model.NoticeModel;
import com.portal.adm.code.service.CodeService;
import com.portal.common.paging.Criteria;

@Service
public class NoticeService {

	@Resource
	private CodeService codeService;	
	
	@Resource
	private NoticeMapper noticeMapper;
	
	public List<NoticeModel> selectNoticeList(Criteria criteria) {
		return noticeMapper.selectNoticeList(criteria);
	}
	public int selectNoticeListCount(Criteria criteria) {
		return noticeMapper.selectNoticeListCount(criteria);
	}
	public NoticeModel selectNotice(NoticeModel model) {
		return noticeMapper.selectNotice(model);
	}
	public long deleteNotice(NoticeModel model) {
		return noticeMapper.deleteNotice(model);
	}
	public long insertNotice(NoticeModel model) {
		return noticeMapper.insertNotice(model);
	}
	public long updateNotice(NoticeModel model) {
		return noticeMapper.updateNotice(model);
	}
	
    /**
     * 모든 공지사항 코드 가져오기
     * @param model
     */
	public void selectAllNoticeCodeList(Model model) {
    	model.addAttribute("codeUseYnList", codeService.selectGroupIdAllList("USE_YN"));
    	model.addAttribute("codeImportantYnList", codeService.selectGroupIdAllList("IMPORTANT_YN"));
    	model.addAttribute("popupYnList", codeService.selectGroupIdAllList("POPUP_YN"));		
    }	
	
}
