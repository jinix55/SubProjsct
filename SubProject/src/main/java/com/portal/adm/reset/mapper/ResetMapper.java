package com.portal.adm.reset.mapper;

import java.util.List;

import com.portal.adm.reset.model.ResetModel;
import com.portal.common.annotation.ConnMapperFirst;

/**
 * Mybatis 코드관리 매핑 Interface
 */
@ConnMapperFirst
public interface ResetMapper {

    /**
     * 레포트 리스트를 가져온다
     *
     * @param resetModel
     * @return  레포트 리스트
     */
    List<ResetModel> selectResetList(ResetModel resetModel);
    
    /**
     * 레포트 카운트를 가져온다
     *
     * @param resetModel
     * @return  레포트 카운트
     */
   int selectResetListCount(ResetModel resetModel);
   
   /**
    * 레포트정보를 등록한다.
    *
    * @param resetModel
    * @return  레포트 등록
    */
   int insert(ResetModel resetModel);
   
   /**
    * 레포트정보를 업데이트한다.
    *
    * @param resetModel
    * @return  레포트 업데이트
    */
   long update(ResetModel resetModel);
   
   /**
    * 레포트정보를 조회한다.
    *
    * @param resetModel
    * @return  레포트 조회
    */
   ResetModel select(ResetModel resetModel);
   
   /**
    * 레포트정보를 삭제한다.
    *
    * @param resetModel
    * @return  레포트 삭제
    */
   long delete(ResetModel resetModel);
   
   /**
    * 레포트정보를 삭제한다.
    *
    * @param resetModel
    * @return  레포트 삭제
    */
   ResetModel select(String resetId);

}
