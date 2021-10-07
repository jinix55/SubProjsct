package com.portal.common;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * 공통 상수 처리
 */
public interface Constant {
	
	// common
	public static final String DEFAULT_USER_PHOTO = "../../images/icon_gnb_user.png";
	//public static final String DEFAULT_USER_PHOTO = "../../images/icon_top_user.png";
	public static final String DEFAULT_TABLEAU_PREVIEW = "../../images/img_noimg.png";
	public static final String LOGIN_MESSAGE ="접근 권한이 없습니다.\\n담당자에게 연락주십시오.";//임시 로그인 메시지
	public static final String FAIL_PASSWORD = "비밀번호가 다릅니다.\\n비밀번호를 확인해 주세요.";//임시 로그인 메시지
	public static final String EMPTY_STRING = "";
	public static final String UNKNOWN = "unknown";
	public static final String RESULT = "result";
	public static final String DETAIL = "detail";
	public static final String RESULT_CODE = "rsltCode";
	public static final String RESULT_MESSAGE = "rsltMsg";
	public static final String ERROR_MESSAGE = "errorMsg";
	public static final String YES = "Y";
	public static final String NO = "N";
	
	//File
	public interface File {
		public static final String AWS_S3 = "S3";
		public static final String PHOTO = "PHOTO";
		public static final String PREVIEW = "PREVIEW";
		public static final String VIEW = "VIEW";
		public static final String BOARD = "BOARD";
		public static final String BOARDQ = "BOARD_Q";
		public static final String BOARDA = "BOARD_A";
		public static final String UPLOAD = "UPLOAD";
		public static final String EDITOR = "EDITOR";
		public static final String EXCEL = "EXCEL";
	}

	// DB
	public interface DB {
		public static final String FAIL = "Fail"; // DB 등록 실패시 리턴 메시지
		public static final String UPDATE = "Update"; // DB Update 성공시 리턴 메시지
		public static final String DELETE = "Delete"; // DB Delete 성공시 리턴 메시지
		public static final String INSERT = "Insert"; // DB Insert 성공시 리턴 메시지
		public static final String USE_ROLE_ID = "UseRoleId"; // Role권한이 사용중일때 메시지
		public static final String USE_CODE_ID = "UseCodeId"; // 그룹코드가 사용중일떄
	}

	//spring profile
	public interface Profile {
		public static final String LOCAL = "local";
		public static final String DEV = "dev";
		public static final String PROD = "prod";
	}
	
	// Jasypt
	public interface Jasypt {
		public static final String KEY = "D9QkX8wx3yhCT6Wm";
		public static final String ALGORITHM = "PBEWITHHMACSHA512ANDAES_256";
	}
	
	//URL Pattern : 메뉴 조회 및 권한 확인 시 사용
	public interface UrlPattern {
		public static final Pattern MENU_CHECK_PATTERN = Pattern.compile("(/detail$|/detail/|/regist$|/regist/|/modify$|/modify/|/select$|/select/)");
		public static final Pattern AUTH_CHECK_PATTERN = Pattern.compile("(/detail$|/detail/|/regist$|/regist/|/modify$|/modify/|/insert$|/insert/|/update$|/update/|/delete$|/delete/select$|/select/)");
		public static final Pattern AUTH_IGNORE_PATTERN = Pattern.compile("(^/error/|^/file/|^/cmm/|^/popup/|/popup$)");
		public static final Map<String,String> AUTH_CHECK_TYPE = new HashMap<String,String>() {
			private static final long serialVersionUID = -1145562349837093088L;
			{
				put("detail","detail");
				put("regist","insert");
				put("modify","update");
				put("insert","insert");
				put("update","update");
				put("delete","delete");
				put("select","select");
			}
		};
	}
	
	// Header Name
	public static final List<String> IP_HEADER = new ArrayList<String>(
			Arrays.asList("x-forwarded-for", "x-real-ip", "proxy-client-ip", "wl-proxy-client-ip",
					"http_x_forwarded_for", "http_x_forwarded", "http_x_cluster_client_ip", "http_client_ip",
					"http_forwarded_for", "http_forwarded", "http_via", "remote_addr"));

	// Error Page URL
	public interface ERROR_URL {
		public static final String ERROR = "/error/error";//별도로 지정되지 않은 에러
		public static final String NOT_FOUND = "/error/notFound";//404 : 요청 URL 없는 경우
		public static final String METHOD_NOT_ALLOWED = "/error/methodNotAllowed";//405 : 요청 메소드 없는 경우
		public static final String INTERNAL_SERVER_ERROR = "/error/internalServerError";//500 : 요청 처리중 오류 발생한 경우
		public static final String UNAUTHORIZED = "/error/unauthorized";//401 : 사용자 미인증인 경우
		public static final String FORBIDDEN = "/error/forbidden";//403 : 접근 권한이 없는 경우
	}
	
	// 로그인 처리 메시지
	public interface LoginMessage {
		public static final String ACCOUNT_DISABLE = "ACCOUNT_DISABLE";
		public static final String ACCOUNT_EXPIRE = "ACCOUNT_EXPIRE";
		public static final String ACCOUNT_LOCK = "ACCOUNT_LOCK";
		public static final String AUTH_FAIL = "AUTH_FAIL";
		public static final String LOGIN_FAIL = "LOGIN_FAIL";
		public static final String SSO_CONNECT_FAIL = "SSO_CONNECT_FAIL";
		public static final String SSO_LOGIN_FAIL = "SSO_LOGIN_FAIL";
		public static final String DB_CONNECT_FAIL = "DB_CONNECT_FAIL";
		public static final String DB_LOGIN_FAIL = "DB_LOGIN_FAIL";
		public static final String DB_LOGIN_NOT_MATCH = "DB_LOGIN_NOT_MATCH";
		public static final String DB_LOGIN_LOCK = "DB_LOGIN_LOCK";
		public static final String DB_LOGIN_INIT = "DB_LOGIN_INIT";
		public static final String USER_NOT_FOUND = "USER_NOT_FOUND";
	}
	
	
	// 로그 항목
	public interface LOG {
		public static final String CLIENT_IP = "client_ip"; 		// 클라이언트 아이피
		public static final String SERVER_IP = "server_ip"; 		// 서버 IP
		public static final String CONTROLLER_NM = "controller_nm";	// 호출 컨트롤러(호출 클래스)
		public static final String METHOD_NM = "method_nm";			// 호출 메소드
		public static final String PARAMS = "msg";				// 파라미터
		public static final String REQUEST_URI = "rqst_uri";		// 호출 URL
		public static final String HTTP_METHOD = "rqst_method";		// HTTP 메소드
		public static final String USER_INFO = "user_info";			// 사용자 정보
		public static final String LOG_TIME = "log_time";			// 로그일시
	}
	
	//날짜, 시간 형식
	public interface DATE_FORMAT {
		public static final String YEAR = "yy";
		public static final String DATE = "yyyy-MM-dd";
		public static final String TIME = "HH:mm:ss";
		public static final String FULL_DATE = "yyyy-MM-dd HH:mm:ss";
		public static final String DEFAULT_DAY = "yyyyMMdd";
		public static final String DEFAULT_TIME = "HHmmss";
		public static final String DEFAULT_DATETIME = "yyyyMMddHHmmss";
	}
	
	//ID
	public static interface ID {
		//ID 타입 키, ID 구분 키
		public static final String ID_TY = "idTy";
		public static final String ID_SE = "idSe";
		//파일
		public static final String COMPANY = "cp";
		//파일
		public static final String FILE = "fl";
		//공지사항
		public static final String NOTICE = "nt";
		//FAQ
		public static final String FAQ = "fq";
		//QNA
		public static final String QNA = "qn";
		//자유게시판
		public static final String FREE = "fr";
		//권한
		public static final String AUTH = "au";
		//메뉴
		public static final String MENU = "mn";
		//라이선스
		public static final String LICENSE = "lc";
		//외부 시스템
		public static final String EXTERNAL = "ex";
		//외부 데이터
		public static final String EXTERNAL_DATA = "ed";		
		//업무 카테고리
		public static final String WORK = "wk";
		//프로젝트
		public static final String PROJECT = "pj";
		//시나리오
		public static final String SCENARIO = "sn";
		//시나리오 파일
		public static final String SCENARIOFILE = "snf";
		//리포트
		public static final String REPORT = "rp";
		//승인
		public static final String APPROVAL = "ar";
		//EAI SOCKET
		public static final String EAI_SOCKET = "es";
	}
	
	// JSON KEY
	public interface KEY {
		public static final String USER_ID = "userId";
		public static final String USER_NM = "userNm";
		public static final String DEPT_CODE = "deptCode";
		public static final String PSTN_CODE = "pstnCode";
	}
	
	//프로젝트
	public interface PROJECT {
		//프로젝트 시각화 타입
		public static final String TYPE_VW = "VW";
	}
	
}
