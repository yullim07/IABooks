package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class MemberUpdateEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("post".equalsIgnoreCase(method)) {
			
			// *** POST 방식으로 넘어온 것이라면 ***
			
			String userid = request.getParameter("userid");
			String name = request.getParameter("name"); 
	        String pwd = request.getParameter("pwd"); 
	        String email = request.getParameter("email"); 
	        String num1	= request.getParameter("num1");
	        String num2	= request.getParameter("num2");
	        String num3	= request.getParameter("num3");
	        String hp1 = request.getParameter("hp1"); 
	        String hp2 = request.getParameter("hp2"); 
	        String hp3 = request.getParameter("hp3"); 
	        String postcode = request.getParameter("postcode");
	        String address = request.getParameter("address"); 
	        String detailaddress = request.getParameter("detailAddress"); 
	        String extraaddress = request.getParameter("extraAddress");
	        
	        String tel = "";
			if( num2 == "" && num3 == "") {
				tel = "";
			}else {
				tel = num1+"-"+num2+"-"+num3;
			}
	        String phone = hp1+"-"+hp2+"-"+hp3;
	        
	        MemberVO member = new MemberVO(userid, name, pwd, email, tel ,phone, postcode, address, detailaddress, extraaddress);
	        
	        InterMemberDAO mdao = new MemberDAO();
	        
	        int n = mdao.updateMember(member);
	        String message = "";
	        if(n==1) {

	        	/// !!! session 에 저장된 loginuser 를 변경된 사용자의 정보값으로 변경해주어야 한다. !!! 
	        	HttpSession session = request.getSession();
	        	MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
	        	loginuser.setUserid(userid);
	        	loginuser.setPwd(pwd);
	        	loginuser.setName(name);
	        	loginuser.setEmail(email);
	        	loginuser.setTel(tel);
	        	loginuser.setPhone(phone);
	        	loginuser.setPostcode(postcode);
	        	loginuser.setAddress(address);
	        	loginuser.setDetailaddress(detailaddress);
	        	loginuser.setExtraaddress(extraaddress);
	        	
	        	message = "회원정보 수정 성공 !!";
	        	
	        } else {
	        	message = "회원정보 수정 실패 !!"; // 오라클에서 무언가 잘못된 것
	        	
	        }
	        
	        String loc = request.getContextPath() +"/member/myPage.book";
	        
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	        
	        super.setViewPage("/WEB-INF/msg.jsp");
	        
		} else {
			// *** GET 방식으로 넘어온 것이라면 ***
			
			String message = "비정상적인 경로를 통해 들어왔습니다!!";
	        String loc = "javascript:history.back()";
	        
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	        
	        super.setViewPage("/WEB-INF/msg.jsp");
			
		}
	        
		
	}

}
