package com.portal.adm.product.mapper;

import java.util.List;

import com.portal.adm.product.model.ProductModel;
import com.portal.common.annotation.ConnMapperFirst;

/**
 * Mybatis 코드관리 매핑 Interface
 */
@ConnMapperFirst
public interface ProductMapper {

    /**
     * 그룹 ID 리스트를 가져온다
     *
     * @param criteria   그룹 ID가 "GROUP_ID"이면 코드 그룹이고 그룹ID가 코드ID이면 세부코드를 리턴한다
     * @return          그룹ID의 하위 코드모델 리스트
     */
    List<ProductModel> selectGroupIdList(ProductModel model);

    /**
     * 그룹 ID 리스트 카운트를 가져온다
     *
     * @param groupCd
     * @return
     */
    int selectGroupIdListCount(ProductModel model);

    /**
     * 그룹 ID 리스트 카운트를 가져온다. 페이징(X)
     *
     * @param groupCd 그룹 ID가 "GROUP_ID"이면 코드 그룹이고 그룹ID가 코드ID이면 세부코드를 리턴한다
     * @return
     */
    List<ProductModel> selectGroupIdAllList(String groupId);

    /**
     * 그룹ID와 코드ID 조건의 코드모델을 리턴한다
     *
     * @param model     코드모델의 그룹ID, 코드ID조건을 사용
     * @return          코드모델
     */
    ProductModel select(ProductModel model);

    /**
     * 그룹ID와 코드ID 조건의 코드모델을 삭제한다. // 사용여부로 변경예정 (작업중)
     * @param model     코드모델의 그룹ID, 코드ID조건을 사용
     * @return          영향 row카운트 수
     */
    long delete(ProductModel model);

    /**
     * 그룹ID와 코드ID 조건의 코드모델을 업데이트한다.
     * @param model     코드모델의 그룹ID, 코드ID조건을 사용
     * @return          영향 row카운트 수
     */
    long update(ProductModel model);

    /**
     * 코드모델을 생성한다.
     * @param model     신규등록 코드모델
     * @return          영향 row카운트 수
     */
    long insert(ProductModel model);

    /**
     * 그룹ID의 하위코드ID가 있는지 확인한다.
     *
     * @param model 그룹ID를 사용
     * @return
     */
    int selectCodeCountForGroupId(ProductModel model);
}
