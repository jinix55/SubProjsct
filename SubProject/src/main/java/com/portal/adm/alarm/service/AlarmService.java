package com.portal.adm.alarm.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.portal.adm.alarm.mapper.AlarmMapper;
import com.portal.adm.alarm.model.AlarmModel;
import com.portal.adm.member.model.MemberModel;
import com.portal.common.Constant;

/**
 * 알람 서비스 클래스
 */
@Service
public class AlarmService {

    @Resource
    private AlarmMapper alarmMapper;

    /**
     * 알람 리스트를 조회한다.
     *
     * @param groupId
     * @return
     */
    public List<AlarmModel> selectAlarmList(AlarmModel alarmModel) {
        return alarmMapper.selectAlarmList(alarmModel);
    }
    
    /**
     * 알람 리스트를 조회한다.
     *
     * @param groupId
     * @return
     */
    public int selectAlarmListCount(AlarmModel alarmModel) {
    	return alarmMapper.selectAlarmListCount(alarmModel);
    }
    
    /**
     * 알람 정보를 저장한다.
     *
     * @param alarmCode
     * @return
     */
    public String save(AlarmModel alarmModel) {
        long count = alarmMapper.insert(alarmModel);

        if(count > 0) {
            return Constant.DB.INSERT;
        } else {
            return Constant.DB.FAIL;
        }
    }
    
    /**
     * 알람 확인 후 비활성화 한다.
     *
     * @param alarmCode
     * @return
     */
    public String delete(AlarmModel alarmModel) {
        long count = alarmMapper.delete(alarmModel);

        if(count > 0) {
            return Constant.DB.DELETE;
        } else {
            return Constant.DB.FAIL;
        }
    }
    
    /**
     * 알람 단일 정보를 조회한다.
     *
     * @param alarmCode
     * @return
     */
    public AlarmModel selectAlarmId(AlarmModel alarmModel) {
    	delete(alarmModel);
    	return alarmMapper.select(alarmModel);
    }
    
    /**
     * 알람 정보를 ajax로 조회한다.
     *
     * @param alarmCode
     * @return
     */
    public List<AlarmModel> selectAlarmUserId(String userId) {
    	return alarmMapper.selectAlarmListView(userId);
    }
    
    /**
     * 등록된 알람이 있는지 조회한다.1~
     *
     * @param alarmCode
     * @return
     */
    public AlarmModel selectAlarmCheck(AlarmModel model) {
    	return alarmMapper.selectAlarmCheck(model);
    }
    
    /**
     * 알람을 등록한다.
     *
     * @param alarmCode
     * @return
     */
    public MemberModel selectAlarmAuth(MemberModel memberModel) {
    	return alarmMapper.selectAlarmAuth(memberModel);
    }

}
