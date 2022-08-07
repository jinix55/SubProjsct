package com.portal.adm.product.service;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.portal.adm.file.model.FileModel;
import com.portal.adm.file.service.FileService;
import com.portal.adm.product.mapper.ProductGroupFIleMapper;
import com.portal.adm.product.model.ProductGroupFileModel;
import com.portal.adm.product.model.ProductModel;
import com.portal.common.Constant;
import com.portal.common.IdUtil;

/**
 * 상품 그룹 첨부파일 서비스 클래스
 */
@Service
public class ProductGroupFileService {

    @Resource
    private ProductGroupFIleMapper productGroupFIleMapper;

    @Resource(name="fileService")
	private FileService fileService;
    
    @Resource
    private IdUtil idUtil;    

    /**
   	 * 첨부파일 목록 카운트를 조회한다.
   	 *
   	 * @param criteria 페이징 모델
   	 * @return
   	 */
   	public int selectProductGroupFileListCount(ProductGroupFileModel productGroupFileModel) {
   		return productGroupFIleMapper.selectProductGroupFileListCount(productGroupFileModel);
   	}
    
    /**
	 * 첨부파일관리 목록을 조회한다.
	 *
	 * @param criteria 페이징 모델
	 * @return
	 */
    public List<ProductGroupFileModel> selectProductGroupFileList(ProductGroupFileModel productGroupFileModel) {
    	List<ProductGroupFileModel> productGroupFileList = productGroupFIleMapper.selectProductGroupFileList(productGroupFileModel);
        return productGroupFileList;
    }
	
    /**
	 * 첨부파일관리 목록을 조회한다.
	 *
	 * @param criteria 페이징 모델
	 * @return
	 */
    public List<ProductGroupFileModel> selectProductGroupFileListByGfileId(ProductGroupFileModel productGroupFileModel) {
    	List<ProductGroupFileModel> productGroupFileList = productGroupFIleMapper.selectProductGroupFileListByGfileId(productGroupFileModel);
        return productGroupFileList;
    }
    
    /**
	 * 첨부파일관리 상세정보을 조회한다.
	 *
	 * @param productGroupFileModel 모델
	 * @return
	 */
    public ProductGroupFileModel selectProductGroupFile(ProductGroupFileModel productGroupFileModel) {
    	ProductGroupFileModel productGroupFile = productGroupFIleMapper.selectProductGroupFile(productGroupFileModel);
        return productGroupFile;
    }
    
	/**
	 * 첨부파일 정보를 등록한다.
	 *
	 * @param model 첨부파일아이디를 사용
	 * @return
	 */
	@Transactional
	public String insertProductGroupFile(ProductGroupFileModel productGroupFileModel) {
		long count = productGroupFIleMapper.insertProductGroupFile(productGroupFileModel);
		
		if (count > 0) {
			return Constant.DB.INSERT;
		} else {
			return Constant.DB.FAIL;
		}
	}

	/**
	 * 첨부파일 정보를 수정한다.
	 *
	 * @param model 첨부파일아이디를 사용
	 * @return
	 */
	
	@Transactional
	public String updateProductRecycleGrade(ProductGroupFileModel productGroupFileModel) {
		long count = productGroupFIleMapper.updateProductGroupFile(productGroupFileModel);
		if (count > 0) {
			return Constant.DB.UPDATE;
		} else {
			return Constant.DB.FAIL;
		}
	}
	
	/**
	 * 첨부파일 정보를 수정(삭제,미사용)한다.
	 *
	 * @param model 첨부파일아이디를 사용
	 * @return
	 */
	@Transactional
	public String deleteProduct(ProductGroupFileModel productGroupFileModel) {
		long count = productGroupFIleMapper.deleteProductGroupFile(productGroupFileModel);
		if (count > 0) {
			return Constant.DB.DELETE;
		} else {
			return Constant.DB.FAIL;
		}
	}
	
	/**
	 * 첨부파일 저장한다
	 *
	 * @param model 첨부파일아이디를 사용
	 * @return
	 */
	public String saveProuductGroupFile(ProductModel productModel, MultipartFile[] files, String productGroupFileId) {
		try {
    		String fileUrl = "C:/PPLUS/" + productModel.getProductCode() + "/" + productModel.getProductId() + "/";
    		String result = "success";
    		String resultMessage = "성공";
    		
    		ProductGroupFileModel productGroupFileModel = new ProductGroupFileModel();
    		
    		//사진 업로드
    		for(MultipartFile file : files) {
    			if(file.getOriginalFilename().equals("")) {
    				continue;
    				//return new ResponseEntity<>("notFile", HttpStatus.NOT_ACCEPTABLE);
    			}
    			
    			FileModel f = new FileModel();
				f.setFileId(idUtil.getFileId());
				
				// s3 기본 처리
    			f.setStorageSe("LOCAL");
    			f.setFileNm(file.getOriginalFilename());
    			f.setFileExtsn(FilenameUtils.getExtension(file.getOriginalFilename()));
    			f.setFileSize(file.getSize());
    			f.setFileUrl(fileUrl+f.getFileId() + "/");
    			f.setUseYn("Y");
    			f.setRefId(productModel.getProductCode());
    			f.setRgstId(productModel.getModiId());
    			f.setModiId(productModel.getModiId());
    			f.setFileCl(Constant.File.API);
    			
    			try {
    				f.setInputStream(file.getResource().getInputStream());
    			} catch (IOException e) {
    				result = "fail";
    				resultMessage = "실패";
    			}
    			
    			// 파일 생성
    			if (!"fail".equals(result)) {
    				fileService.insertFile(f);
    				
    				if(productGroupFileId == null || "".equals(productGroupFileId)) {
    					productGroupFileId = idUtil.getProductGroupFileId();
    				}
    				productGroupFileModel.setGfileId(productGroupFileId);
    				productGroupFileModel.setFileId(f.getFileId());
    				productGroupFileModel.setRgstId(productModel.getModiId());
    				productGroupFileModel.setModiId(productModel.getModiId());
    				insertProductGroupFile(productGroupFileModel);
    				
    				Path directoryPath = Paths.get(fileUrl+f.getFileId() + "/");

    				try {
    					Files.createDirectories(directoryPath);
    				} catch (IOException e1) {
//    					return "1.파일 생성시 오류났습니다.";
    				}

    				try {
    					FileOutputStream fos = new FileOutputStream(fileUrl+f.getFileId() + "/" + file.getOriginalFilename());

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
//    					return "1.FileNotFoundException.";
    				}
    				catch (IOException e) {
//    					return "1.IOException.";
    				}
    			}
    		}
		} catch (Exception e) {
			System.out.println(e.getMessage());
//        	return e.getMessage();
        }
		return productGroupFileId;
	}
	
	/**
	 * 첨부파일 저장한다
	 *
	 * @param model 첨부파일아이디를 사용
	 * @return
	 */
	public String saveProuductMainFile(ProductModel productModel, MultipartFile file) {
		String fileId = "";
		try {
    		String fileUrl = "C:/PPLUS/" + productModel.getProductCode() + "/" + productModel.getProductId() + "/";
    		String result = "success";
    		String resultMessage = "성공";
    		ProductGroupFileModel productGroupFileModel = new ProductGroupFileModel();
    		
    		if(file != null) {
	    		//사진 업로드
				if(file.getOriginalFilename().equals("")) {
					return fileId;
				}
				
				FileModel f = new FileModel();
				f.setFileId(idUtil.getFileId());
				fileId = f.getFileId();
				// s3 기본 처리
				f.setStorageSe("LOCAL");
				f.setFileNm(file.getOriginalFilename());
				f.setFileExtsn(FilenameUtils.getExtension(file.getOriginalFilename()));
				f.setFileSize(file.getSize());
				f.setFileUrl(fileUrl+f.getFileId() + "/");
				f.setUseYn("Y");
				f.setRefId(productModel.getProductCode());
				f.setRgstId(productModel.getModiId());
				f.setModiId(productModel.getModiId());
				f.setFileCl(Constant.File.API);
				
				try {
					f.setInputStream(file.getResource().getInputStream());
				} catch (IOException e) {
					result = "fail";
					resultMessage = "실패";
				}
				
				// 파일 생성
				if (!"fail".equals(result)) {
					fileService.insertFile(f);
					
					Path directoryPath = Paths.get(fileUrl+f.getFileId() + "/");
	
					try {
						Files.createDirectories(directoryPath);
					} catch (IOException e1) {
	//    					return "1.파일 생성시 오류났습니다.";
					}
	
					try {
						FileOutputStream fos = new FileOutputStream(fileUrl+f.getFileId() + "/" + file.getOriginalFilename());
	
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
	//    					return "1.FileNotFoundException.";
					}
					catch (IOException e) {
	//    					return "1.IOException.";
					}
				}
    		}
		} catch (Exception e) {
			System.out.println(e.getMessage());
//        	return e.getMessage();
        }
		return fileId;
	}
	
}
