package com.portal.adm.board.mapper;

import java.util.List;

import com.portal.adm.board.model.QnaModel;
import com.portal.common.annotation.ConnMapperFirst;
import com.portal.common.paging.Criteria;

@ConnMapperFirst
public interface QnaMapper {

    List<QnaModel> selectQnaList(Criteria criteria);
    int selectQnaListCount(Criteria criteria);
    QnaModel selectQna(QnaModel model);
    long updateQna(QnaModel model);
    long deleteQna(QnaModel model);
    
}
