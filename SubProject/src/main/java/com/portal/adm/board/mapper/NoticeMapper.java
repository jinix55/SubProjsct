package com.portal.adm.board.mapper;

import com.portal.adm.board.model.NoticeModel;
import com.portal.common.annotation.ConnMapperFirst;
import com.portal.common.paging.Criteria;

import java.util.List;

@ConnMapperFirst
public interface NoticeMapper {

	List<NoticeModel> selectNoticeList(Criteria criteria);
	int selectNoticeListCount(Criteria criteria);
	NoticeModel selectNotice(NoticeModel model);
	long deleteNotice(NoticeModel model);
	long insertNotice(NoticeModel model);
	long updateNotice(NoticeModel model);		
	
}
