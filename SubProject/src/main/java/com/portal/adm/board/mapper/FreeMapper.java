package com.portal.adm.board.mapper;

import java.util.List;

import com.portal.adm.board.model.FreeModel;
import com.portal.common.annotation.ConnMapperFirst;
import com.portal.common.paging.Criteria;

@ConnMapperFirst
public interface FreeMapper {

    List<FreeModel> selectFreeList(Criteria criteria);
    int selectFreeListCount(Criteria criteria);
    FreeModel selectFree(FreeModel model);
    long updateFree(FreeModel model);
    long deleteFree(FreeModel model);
    
}
