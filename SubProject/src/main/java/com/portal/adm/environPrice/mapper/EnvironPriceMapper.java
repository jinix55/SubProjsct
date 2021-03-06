package com.portal.adm.environPrice.mapper;

import java.util.List;

import com.portal.adm.environPrice.model.EnvironPriceModel;
import com.portal.common.annotation.ConnMapperFirst;

/**
 * Mybatis 환경부담금 단가 매핑 Interface
 */
@ConnMapperFirst
public interface EnvironPriceMapper {

    /**
     * 그룹 ID 리스트를 가져온다
     *
     * @param criteria   그룹 ID가 "GROUP_ID"이면 코드 그룹이고 그룹ID가 코드ID이면 세부코드를 리턴한다
     * @return          그룹ID의 하위 코드모델 리스트
     */
    List<EnvironPriceModel> selectGroupIdList(EnvironPriceModel model);

    /**
     * 그룹 ID 리스트 카운트를 가져온다
     *
     * @param groupCd
     * @return
     */
    int selectGroupIdListCount(EnvironPriceModel model);

    /**
     * 그룹 ID 리스트 카운트를 가져온다. 페이징(X)
     *
     * @param groupCd 그룹 ID가 "GROUP_ID"이면 코드 그룹이고 그룹ID가 코드ID이면 세부코드를 리턴한다
     * @return
     */
    List<EnvironPriceModel> selectGroupIdAllList(String groupId);

    /**
     * 그룹ID와 코드ID 조건의 코드모델을 리턴한다
     *
     * @param model     코드모델의 그룹ID, 코드ID조건을 사용
     * @return          코드모델
     */
    EnvironPriceModel select(EnvironPriceModel model);

    /**
     * 그룹ID와 코드ID 조건의 코드모델을 삭제한다. // 사용여부로 변경예정 (작업중)
     * @param model     코드모델의 그룹ID, 코드ID조건을 사용
     * @return          영향 row카운트 수
     */
    long delete(EnvironPriceModel model);

    /**
     * 그룹ID와 코드ID 조건의 코드모델을 업데이트한다.
     * @param model     코드모델의 그룹ID, 코드ID조건을 사용
     * @return          영향 row카운트 수
     */
    long update(EnvironPriceModel model);

    /**
     * 코드모델을 생성한다.
     * @param model     신규등록 코드모델
     * @return          영향 row카운트 수
     */
    long insert(EnvironPriceModel model);

    /**
     * 그룹ID의 하위코드ID가 있는지 확인한다.
     *
     * @param model 그룹ID를 사용
     * @return
     */
    int selectCodeCountForGroupId(EnvironPriceModel model);
}
