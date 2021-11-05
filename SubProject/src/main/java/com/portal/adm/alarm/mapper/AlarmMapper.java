package com.portal.adm.alarm.mapper;

import java.util.List;
import java.util.Map;

import com.portal.adm.alarm.model.AlarmModel;
import com.portal.adm.member.model.MemberModel;
import com.portal.common.annotation.ConnMapperFirst;

/**
 * Mybatis 코드관리 매핑 Interface
 */
@ConnMapperFirst
public interface AlarmMapper {

    /**
     * 알람 리스트를 가져온다
     *
     * @param alarmModel
     * @return  알람 리스트
     */
    List<AlarmModel> selectAlarmList(AlarmModel alarmModel);
    
    /**
     * 알람 카운트를 가져온다
     *
     * @param alarmModel
     * @return  알람 카운트
     */
   int selectAlarmListCount(AlarmModel alarmModel);
   
   /**
    * 알람정보를 등록한다.
    *
    * @param alarmModel
    * @return  알람 등록
    */
   int insert(AlarmModel alarmModel);
   
   /**
    * 알람정보를 조회한다.
    *
    * @param alarmModel
    * @return  알람 조회
    */
   AlarmModel select(AlarmModel alarmModel);
   
   /**
    * 알람정보를 삭제한다.
    *
    * @param alarmModel
    * @return  알람 삭제
    */
   long delete(AlarmModel alarmModel);
   
   /**
    * 알람정보를 삭제한다.
    *
    * @param alarmModel
    * @return  알람 삭제
    */
   AlarmModel select(String alarmId);
   
   /**
    * 알람정보를 삭제한다.
    *
    * @param alarmModel
    * @return  알람 삭제
    */
   List<AlarmModel> selectAlarmListView(String userId);
   
   MemberModel selectAlarmAuth(MemberModel model);
   
   AlarmModel selectAlarmCheck(AlarmModel model);

}
