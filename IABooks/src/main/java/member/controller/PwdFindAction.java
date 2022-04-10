package member.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import common.controller.AbstractController;
import member.model.*;

public class PwdFindAction extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      String method = request.getMethod(); 
      // "GET" 또는 "POST"
      
   //   System.out.println("와라 방식" + method);
      // GET
      
      if("POST".equalsIgnoreCase(method)) {
      // 비밀번호 찾기 모달창에서 "찾기" 버튼을 클릭 했을 경우
         
   //   System.out.println("와라 방식" + method);   
         
      String userid= request.getParameter("userid");
      String name = request.getParameter("name");
      String email = request.getParameter("email");
      String phone = "010-" + request.getParameter("phone_one") +"-"+ request.getParameter("phone_two") ;
      String phone2 = "010" + request.getParameter("phone_one")+ request.getParameter("phone_two") ;
      String radio = request.getParameter("check");
      
//      System.out.println(userid);
//      System.out.println(name);
//      System.out.println(email);
//      System.out.println(콜);
//      System.out.println(radio);
      
      InterMemberDAO mdao = new MemberDAO();
      
      Map<String, String> paraMap = new HashMap<>();
      paraMap.put("userid", userid);
      paraMap.put("name", name);
      paraMap.put("email", email);
      paraMap.put("phone", phone);
      
//      System.out.println(userid);
//      System.out.println(name);
//      System.out.println(email);
//      System.out.println(phone);
      boolean isUserExist = mdao.isUserExist(paraMap , Integer.parseInt(radio));
      
     
      
      boolean sendMailSuccess = false; // 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도
      boolean sendSmsSuccess = false; // 문자가 정상적으로 전송되었는지 유무를 알아오기 위한 용도
      
      
      if(isUserExist) {
         // 회원으로 존재하는 경우
    	  
  //  	  System.out.println("isUserExist : "+isUserExist);
    	  
    	  if(radio.equals("0")) {
         // 인증키를 랜덤하게 생성하도록 한다.
	         Random rnd = new Random();
	         
	         String certificationCode = "";
	         // 이메일인증키는 영문소문자 5글자 + 숫자 7글자 로 생성
	         // 예: certificationCode ==> dngrn4745003
	         
	         char randchar = ' ';
	         for(int i=0; i<5; i++) {
	         /*
	                min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면 
	                int rndnum = rnd.nextInt(max - min + 1) + min;
	                   영문 소문자 'a' 부터 'z' 까지 랜덤하게 1개를 만든다.     
	            */
	            randchar = (char)(rnd.nextInt('z' - 'a' + 1) + 'a');
	            certificationCode += randchar;
	            
	         }// end of for--------------
	         
	         int randnum = 0;
	         for(int i=0; i<7; i++) {
	            randnum = rnd.nextInt(9 - 0 + 1) + 0;
	            certificationCode += randnum;
	         }// end of for------------------------------
	         
	      //   System.out.println("~~~~ 확인용 certificationCode => " + certificationCode);
	         // ~~~~ 확인용 certificationCode => uvwpa5492751
	         
	         // 랜덤하게 생성한 인증코드(certificationCode)를 비밀번호 찾기를 하고자 하는 사용자의 email 로 전송시킨다.
	         GoogleMail mail = new GoogleMail();
	         
	         try {
	            mail.sendmail(email, certificationCode);
	            sendMailSuccess = true; // 메일 전송이 성공했음을 기록함
	         
	            // 세션불러오기
	            HttpSession session = request.getSession();
	            session.setAttribute("certificationCode", certificationCode);
	            session.setAttribute("userid", userid);
	            // 발급한 인증코드를 세션에 저장시킴 -> 아이디 또한 세션에 저장시킴(보안을 위해서)
	            
	         } catch(Exception e) {
	            // 메일 전송이 실패한 경우
	            e.printStackTrace();
	            sendMailSuccess = false; // 메일 전송이 실패했음을 기록함
	         }
    	  }//문자 + 숫자로 이루어진 인증코드 만들고 메일보내기
    	  else if(radio.equals("1")) {
    		  
    		  Random rnd = new Random();
 	         
 	         String certificationCode = "";
 	         // 휴대폰인증키는 숫자 6글자로 생성
 	         
 	         int randnum = 0;
 	         for(int i=0; i<6; i++) {
 	            randnum = rnd.nextInt(9 - 0 + 1) + 0;
 	            certificationCode += randnum;
 	         }// end of for------------------------------
 	         
 	    //     System.out.println("~~~~ 확인용 certificationCode => " + certificationCode);
 	         // ~~~~ 확인용 certificationCode => 044557
 	         
 	         // 랜덤하게 생성한 인증코드(certificationCode)를 비밀번호 찾기를 하고자 하는 사용자의 sms 로 전송시킨다.
 	        SmsSendAction sms = new SmsSendAction();
 	        
 	        // 세션불러오기
	            HttpSession session = request.getSession();
	            session.setAttribute("certificationCode", certificationCode);
	            session.setAttribute("userid", userid);

	          String code = (String) session.getAttribute("certificationCode"); // 메세지란 수정하기
	          
 	         try {
 	 		  
 	           sendSmsSuccess = sms.sendmsg(phone2, code);// 문자 전송이 성공했음을 기록함
 	           
 	            // 발급한 인증코드를 세션에 저장시킴 -> 아이디 또한 세션에 저장시킴(보안을 위해서)
 	            
 	         } catch(Exception e) {
 	            // 문자 전송이 실패한 경우
 	            e.printStackTrace();
 	            sendSmsSuccess = false; // 메일 전송이 실패했음을 기록함
 	         }
    		  
    		  
    	  }
         
      } // end of if(isUserExist)----------
      
      request.setAttribute("isUserExist", isUserExist);
      request.setAttribute("sendMailSuccess", sendMailSuccess);
      request.setAttribute("sendSmsSuccess", sendSmsSuccess);
      request.setAttribute("userid", userid);
      request.setAttribute("name", name);
      request.setAttribute("email", email); 
      request.setAttribute("phone", phone); 
      request.setAttribute("phone2", phone2); 
      request.setAttribute("radio", radio); 
      
   }// end of if("POST".equalsIgnoreCase(method))----------------
      
      
      request.setAttribute("method", method);
      
      // super.setRedirect(false);
      super.setViewPage("/WEB-INF/login/pwdFind.jsp");
      
   }

}