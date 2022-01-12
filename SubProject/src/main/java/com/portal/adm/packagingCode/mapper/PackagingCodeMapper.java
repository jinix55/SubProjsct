package com.portal.adm.packagingCode.mapper;

import java.util.List;

import com.portal.adm.packagingCode.model.PackagingCodeModel;
import com.portal.common.annotation.ConnMapperFirst;

/**
 * Mybatis 코드관리 매핑 Interface
 */
@ConnMapperFirst
public interface PackagingCodeMapper {

	/**
	 * 그룹 ID 리스트를 가져온다
	 *
	 * @param criteria   그룹 ID가 "GROUP_ID"이면 코드 그룹이고 그룹ID가 코드ID이면 세부코드를 리턴한다
	 * @return          그룹ID의 하위 코드모델 리스트
	 */
	List<PackagingCodeModel> selectGroupIdList(PackagingCodeModel model);
	
    /**
     * 환경부 코드 리스트 최근 날짜순으로 조회한다.
     *
     * @param criteria   "GROUP_ID"기준으로 그룹으로 조회하여 리스트 생성
     * @return          GROUP_ID 기준 갱신 년 월 리턴
     */
    List<PackagingCodeModel> selectCodeDayList(PackagingCodeModel model);

    /**
     * 그룹 ID 리스트 카운트를 가져온다
     *
     * @param groupCd
     * @return
     */
    int selectGroupIdListCount(PackagingCodeModel model);

    /**
     * 그룹 ID 리스트 카운트를 가져온다. 페이징(X)
     *
     * @param groupCd 그룹 ID가 "GROUP_ID"이면 코드 그룹이고 그룹ID가 코드ID이면 세부코드를 리턴한다
     * @return
     */
    List<PackagingCodeModel> selectGroupIdAllList(String groupId);

    /**
     * 그룹ID와 코드ID 조건의 코드모델을 리턴한다
     *
     * @param model     코드모델의 그룹ID, 코드ID조건을 사용
     * @return          코드모델
     */
    List<PackagingCodeModel> selectList(PackagingCodeModel model);
    
    /**
     * 그룹ID와 코드ID 조건의 코드모델을 리턴한다
     *
     * @param model     코드모델의 그룹ID, 코드ID조건을 사용
     * @return          코드모델
     */
    PackagingCodeModel select(PackagingCodeModel model);

    /**
     * 그룹ID와 코드ID 조건의 코드모델을 삭제한다. // 사용여부로 변경예정 (작업중)
     * @param model     코드모델의 그룹ID, 코드ID조건을 사용
     * @return          영향 row카운트 수
     */
    long delete(PackagingCodeModel model);
    
    /**
     * 그룹ID 기준으로 하위 모든 데이터를 삭제한다.
     * @param model     코드모델의 그룹ID 사용
     * @return          영향 row카운트 수
     */
    long deleteDownCode(PackagingCodeModel model);

    /**
     * 그룹ID와 코드ID 조건의 코드모델을 업데이트한다.
     * @param model     코드모델의 그룹ID, 코드ID조건을 사용
     * @return          영향 row카운트 수
     */
    long update(PackagingCodeModel model);

    /**
     * 코드모델을 생성한다.
     * @param model     신규등록 코드모델
     * @return          영향 row카운트 수
     */
    long insert(PackagingCodeModel model);

    /**
     * 그룹ID의 하위코드ID가 있는지 확인한다.
     *
     * @param model 그룹ID를 사용
     * @return
     */
    int selectCodeCountForGroupId(PackagingCodeModel model);
}
