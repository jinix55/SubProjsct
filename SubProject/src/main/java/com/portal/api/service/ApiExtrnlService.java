package com.portal.api.service;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.portal.adm.alarm.mapper.AlarmMapper;
import com.portal.adm.alarm.model.AlarmModel;
import com.portal.adm.file.model.FileModel;
import com.portal.adm.product.model.ProdPackagingDetailApiModel;
import com.portal.api.mapper.ApiExtrnlMapper;
import com.portal.api.model.ApiExtrnlModel;
import com.portal.common.Constant;
import com.portal.common.IdUtil;

@Service
public class ApiExtrnlService {

	@Resource
	private ApiExtrnlMapper apiExtrnlMapper;
	
    @Resource
    private AlarmMapper alarmMapper;

	@Resource(name = "idUtil")
	private IdUtil idUtil;

	/**
	 * 포장 api 모델을 조회한다.
	 *
	 * @param model 포장 api key를 사용
	 * @return
	 */
	public ApiExtrnlModel select(ApiExtrnlModel model) {
		apiExtrnlMapper.updateDate();
		return apiExtrnlMapper.select(model);
	}

	/**
	 * 포장 api 기준 포장 정보 모델을 조회한다.
	 *
	 * @param model 포장 api key를 사용
	 * @return
	 */
	public ProdPackagingDetailApiModel selectProdApiInfo(ProdPackagingDetailApiModel model) {
		return apiExtrnlMapper.selectProdApiInfo(model);
	}

	/**
	 * 포장 api 모델을 저장한다.
	 *
	 * @param model 포장 api 모델을 사용
	 * @return
	 */
	public long insert(ApiExtrnlModel model) {
		return apiExtrnlMapper.insert(model);
	}

	/**
	 * 포장 api 모델을 저장한다.
	 *
	 * @param
	 * @return
	 */
	public long updateDate() {
		return apiExtrnlMapper.updateDate();
	}
	
	/**
	 * 포장 api 모델을 업데이트 한다.
	 *
	 * @param
	 * @return
	 */
	public long updatePackagingInfo(ProdPackagingDetailApiModel model) {
		return apiExtrnlMapper.updatePackagingInfo(model);
	}
	
	/**
	 * 파일 신규 생성
	 * 
	 * @param model
	 * @return
	 */
	public long insertFile(FileModel model) {
		return apiExtrnlMapper.insertFile(model);
	}
	
	/**
	 * 파일 신규 생성
	 * 
	 * @param model
	 * @return
	 */
	public long updateUseYnN(ProdPackagingDetailApiModel model) {
		return apiExtrnlMapper.updateUseYnN(model);
	}

	/**
	 * 파일 신규 생성
	 * 
	 * @param model
	 * @return
	 */
	public long registAlarm(AlarmModel model) {
		return alarmMapper.insert(model);
	}

	/**
	 * File Upload
	 * 
	 * @param request
	 * @param multipart
	 * @return
	 * @throws IOException
	 */
	public String upload(HttpServletRequest request, MultipartRequest multipart,
			ProdPackagingDetailApiModel prodPackagingModel) {
		String result = "success";
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		final Map<String, MultipartFile> files = multipart.getFileMap();
		ArrayList<String> fileIds = new ArrayList<String>();
		String fileId = "";
		String fileUrl = "C:/" + prodPackagingModel.getCompanyCode() + "/" + prodPackagingModel.getSupplierId() + "/" + prodPackagingModel.getProductCode() + "/" + prodPackagingModel.getPackagingId() + "/" + prodPackagingModel.getPackagingOrder() + "/";
		String resultMessage = "성공";
		MultipartFile file = null;
		for (String key : files.keySet()) {
			file = files.get(key);
			if(file.getOriginalFilename().equals("")) {
				return "notFile";
			}
			FileModel f = new FileModel();
			fileId = idUtil.getFileId();
			fileIds.add(fileId);
			f.setFileId(fileId);
			// s3 기본 처리
			// f.setStorageSe("");
			// f.setSavePath("");
			// f.setBucketNm("");
			// f.setSaveFileVer("");
			// f.setSaveFileNm("");

			// s3 기본 처리
			f.setStorageSe("LOCAL");
			f.setFileNm(file.getOriginalFilename());
			f.setFileExtsn(FilenameUtils.getExtension(file.getOriginalFilename()));
			f.setFileSize(file.getSize());
			f.setFileUrl(fileUrl);
			f.setUseYn("Y");
			f.setRgstId(prodPackagingModel.getManagerId());
			f.setModiId(prodPackagingModel.getManagerId());
			f.setFileCl(Constant.File.API);
			f.setRefId(prodPackagingModel.getPackagingId());
			try {
				f.setInputStream(file.getResource().getInputStream());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				result = "fail";
				resultMessage = "실패";
			}
			// 파일 생성
			if (!"fail".equals(result)) {
				insertFile(f);
				prodPackagingModel.setMatFileId(fileId);
				prodPackagingModel.setModiId(prodPackagingModel.getManagerId());
				updatePackagingInfo(prodPackagingModel);

				Path directoryPath = Paths.get(fileUrl);

				try {
					Files.createDirectories(directoryPath);
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}

				try {
					FileOutputStream fos = new FileOutputStream(fileUrl + file.getOriginalFilename());

					InputStream is = file.getInputStream();

					int readCount = 0;
					byte[] buffer = new byte[1024];
					// 파일을 읽을 크기 만큼의 buffer를 생성하고
					// ( 보통 1024, 2048, 4096, 8192 와 같이 배수 형식으로 버퍼의 크기를 잡는 것이 일반적이다.)

					while ((readCount = is.read(buffer)) != -1) {
						// 파일에서 가져온 fileInputStream을 설정한 크기 (1024byte) 만큼 읽고

						fos.write(buffer, 0, readCount);
						// 위에서 생성한 fileOutputStream 객체에 출력하기를 반복한다
					}
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
//				 if (s3Util.upload(f)) {
//					 log.debug("s3 upload success!");
//					 updateFile(f);
//				 }else {
//					 result = "fail";
//					 resultMessage = "실패";
//				 }
				// 운영에 배포시 삭제
				// updateFile(f);
				// result = "success";
				// resultMessage = "성공";
				catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				AlarmModel alarm = new AlarmModel();
				String type = "";
				if(prodPackagingModel.getPartCode().equals("B")) {
					type = "몸체";
				}else if(prodPackagingModel.getPartCode().equals("L")){
					type = "라벨";
				}else if(prodPackagingModel.getPartCode().equals("C")){
					type = "마개";
				}else if(prodPackagingModel.getPartCode().equals("M")){
					type = "잡자재";
				}else if(prodPackagingModel.getPartCode().equals("S")){
					type = "별도포장";
				}
//				prodPackagingModel.setPartTypeNm(type);
				
				alarm.setAlarmId(idUtil.getAlarmId());
				alarm.setSj("포장재 재질 구조 증명서 등록");
				alarm.setCn(prodPackagingModel.getSupplierNm()+"에서 "+ prodPackagingModel.getProductNm() + "의 제품인 " + prodPackagingModel.getGroupNm() +" "+ prodPackagingModel.getPartNm() + "의 "+prodPackagingModel.getPackagingOrder()+"차 포장재 재질 구조 증명서가 등록 되었습니다.");
				alarm.setSenderId(prodPackagingModel.getManagerNm());
				alarm.setRecipientId(prodPackagingModel.getManagementId());
				alarm.setCheckYn("N");
				alarm.setRgstId(prodPackagingModel.getManagerNm());
				alarm.setModiId(prodPackagingModel.getManagerNm());
				registAlarm(alarm);
				updateUseYnN(prodPackagingModel);
				
				
			}
			fileUrl = f.getFileUrl();
		}
		return result;
	}
	
	/**
     * 회사 로고 조회한다.
     *
     * @param String
     * @return  회사 삭제
     */
    public String selectCompanyLogoByCompanyCode(String companyCode) {
    	return apiExtrnlMapper.selectCompanyLogoByCompanyCode(companyCode);
    }
}
