package member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class LoginAction extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      String method = request.getMethod();
      
      
      
      if("get".equalsIgnoreCase(method)) {
         //super.setRedirect(false);
         super.setViewPage("/WEB-INF/login/login.jsp");
      }
      else { // post 방식
         
         String userid = request.getParameter("userid");
         String pwd = request.getParameter("pwd");
         String clientip = request.getRemoteAddr();
         String registerflag = request.getParameter("registerflag");
         System.out.println(registerflag);
         
         Map<String, String> paraMap = new HashMap<>();
         paraMap.put("userid", userid);
         paraMap.put("pwd", pwd);
         paraMap.put("clientip", clientip);
         paraMap.put("registerflag",registerflag);
         
         InterMemberDAO mdao = new MemberDAO();
         
         MemberVO loginuser = mdao.selectOneMember(paraMap);

         if(loginuser != null) {
            
               if(loginuser.getU_status() == 1) {
                   String message = "로그인을 한지 1년이 지나서 휴면상태로 되었습니다. 관리자에게 문의 바랍니다.";
                   String loc = request.getContextPath()+"/index.book";
                   // 원래는 위와 같이 index.up 이 아니라 휴면인 계정을 풀어주는 페이지로 잡아주어야 한다. 
                  
                  request.setAttribute("message", message);
                  request.setAttribute("loc", loc);
                  
                  super.setRedirect(false);
                  super.setViewPage("/WEB-INF/msg.jsp");
                  
                  return; // execute() 메소드 종료 
               }
         
               HttpSession session = request.getSession();
                 // 메모리에 생성되어져 있는 session 을 불러오는 것이다.
                 
                 session.setAttribute("loginuser", loginuser);
                 // session(세션)에 로그인 되어진 사용자 정보인 loginuser 을 키이름을 "loginuser" 으로 저장시켜두는 것이다. 
                 
                 if( loginuser.isRequirePwdChange() == true ) {
                    String message = "비밀번호를 변경하신지 3개월이 지났습니다. 암호를 변경하세요!!";
                   String loc = request.getContextPath()+"/index.book"; // 추후 수정 필요
                   // 원래는 위와 같이 index.up 이 아니라 암호를 변경해주는 페이지로 잡아주어야 한다. 
                  
                  request.setAttribute("message", message);
                  request.setAttribute("loc", loc);
                  
                  super.setRedirect(false);
                  super.setViewPage("/WEB-INF/msg.jsp");
                 }
                 
                 else {
                   // 비밀번호를 변경한지 3개월 이내인 경우 
                    
                   // 페이지 이동을 시킨다.
                   super.setRedirect(true);
                   
                   
                   // 회원가입에서 자동 로그인이라면
					
					 if("true".equalsIgnoreCase(registerflag)) {
						 super.setViewPage(request.getContextPath()+"/login/registerSuccess.book");
						 System.out.println(method);
						 return; 
					 } 
                 	
	                   // 로그인을 하면 시작페이지(index.up)로 가는 것이 아니라 로그인을 시도하려고 머물렀던 그 페이지로 가기 위한 것이다.
	                   super.setViewPage(request.getContextPath()+"/index.book");
                 }
               
            }
            else {
               String message = "로그인 실패";
               String loc = "javascript:history.back()";
               
               request.setAttribute("message", message);
               request.setAttribute("loc", loc);
               
               super.setRedirect(false);
               super.setViewPage("/WEB-INF/msg.jsp");
            }
            
         }
         
      }

   }