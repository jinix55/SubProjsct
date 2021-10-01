package com.portal.adm.board.mapper;

import com.portal.adm.board.model.FaqModel;
import com.portal.common.annotation.ConnMapperFirst;
import com.portal.common.paging.Criteria;

import java.util.List;

@ConnMapperFirst
public interface FaqMapper {

	List<FaqModel> selectFaqList(Criteria criteria);
	int selectFaqListCount(Criteria criteria);
	FaqModel selectFaq(FaqModel model);
	long deleteFaq(FaqModel model);
	long insertFaq(FaqModel model);
	long updateFaq(FaqModel model);	
	
}
