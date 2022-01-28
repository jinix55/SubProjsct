package com.portal.mail;

/**
 * 공통 상수 처리
 */
public interface MailConstant {
	
	public interface Content {
		public static final String BODYO = ""
				+ "<body>"
				+ "  <table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\" style=\"margin: 0 auto;border:1px solid #ddd;\">"
				+ "    <tr>"
				+ "      <td align=\"center\" bgcolor=\"#00A0B0\" style=\"padding: 40px 0;background: #39aa54;\">"
				+ "        <div style=\"margin:0 auto\">"
				+ "          <span><img src=\"{HOSTURL}/images/icon_open.png\" width=\"100\" height=\"auto\" style=\"display: block;margin-bottom:20px\" /></span>"
				+ "          <span style=\"color:#fff;font-size:28px;\">PPlueEco Email Service</span>"
				+ "        </div>"
				+ "      </td>"
				+ "    </tr>"
				+ "    <tr>"
				+ "      <td>"
				+ "        <div style=\"padding: 25px;line-height: 30px;\">"
				+ "          {NAME}님, 안녕하세요?<br><br>"
				+ "          {COMPANY} 포장재질구조 담당자 입니다. <br>"
				+ "          아래 링크를 클릭하시면 환경부 제출서류인 포장재 재질 구조 증명서 입력창이 뜹니다. <br>"
				+ "          빈칸을 작성 후 직인 날인 후 PDF로 첨부하여 보내기 버튼을 눌러주세요<br><br>"
				+ "          <div class=\"pt30 tc\">"
				+ "            <a class=\"button btn-success\" href=\"{HOSTURL}{API}\">바로가기</a>"
				+ "          </div><br>"
				+ "          감사합니다."
				+ "        </div>"
				+ "      </td>"
				+ "    </tr>"
				+ "    <tr>"
				+ "      <td bgcolor=\"#3e4346\" style=\"padding: 30px;\">"
				+ "        <a href=\"#\"><img src=\"{HOSTURL}/images/logo_04.png\" width=\"140\" height=\"auto\"/></a>"
				+ "    </td>"
				+ "  </tr>"
				+ "  </table>";
	}
	
}
