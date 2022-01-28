package com.portal.mail;

import java.util.Properties;
import java.util.UUID;

import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.portal.api.model.ApiExtrnlModel;
import com.portal.common.IdUtil;
import com.portal.config.props.MailProps;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class MailUtil {

	@Resource(name = "mailProps")
	private MailProps props;
	
	public String gmailSend(HttpServletRequest request, ApiExtrnlModel extrnlModel ) {
		String uuid = "";
		String userId = props.getUserId();			// 보내는 사람 메일 ID
		String password = props.getPassword();		// 보내는 사람 메일 비밀번호

		Properties prop = new Properties();
		prop.put(props.getMailSmtpHost(), props.getSmtpMailUrl());
		prop.put(props.getMailSmtpPort(), 465);
		prop.put(props.getMailSmtpAuth(), "true");
		prop.put(props.getMailSmtpSslEnable(), "true");
		prop.put(props.getMailSmtpSslTrust(), props.getSmtpMailUrl());

		Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(userId, password);
			}
		});

		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(userId));

			// 수신자메일주소
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(extrnlModel.getManagerMail()));

			// 다중 메일 발송일 경우
//			InternetAddress[] addArray = new InternetAddress[5];
//			addArray[0] = new InternetAddress("ktko0@ktko0.com");
//			addArray[1] = new InternetAddress("ktko1@ktko1.com");
//			addArray[2] = new InternetAddress("ktko2@ktko2.com");
//			addArray[3] = new InternetAddress("ktko3@ktko3.com");
//			addArray[4] = new InternetAddress("ktko4@ktko4.com");
//			message.addRecipients(Message.RecipientType.TO, addArray);

			// Subject
			message.setSubject("포장재 재질 구조 증명서 입력 부탁드립니다."); // 메일 제목을 입력

			// Text
//			message.setText("제품 포장 정보 입력 URL은 다음과 같습니다."); // 메일 내용을 입력
			
			// api 키값 생성
			uuid = UUID.randomUUID().toString().replace("-", "");
			String content = "text/html;charset=UTF-8";
			
			// 내용 셋팅
			StringBuffer mailBody = new StringBuffer();
			String contents = MailConstant.Content.BODYO.replaceAll("\\{HOSTURL\\}", request.getServerName());
			contents = contents.replaceAll("\\{API\\}", "/api/v1/setProdPackaging/"+uuid);
			contents = contents.replaceAll("\\{NAME\\}", extrnlModel.getManagerNm());
			contents = contents.replaceAll("\\{COMPANY\\}", extrnlModel.getFromCompanyNm());
			mailBody.append(contents);
			message.setContent(mailBody.toString(), content);

			// send the message
			Transport.send(message); //// 전송
			
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return uuid;

	}
}
