package board.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import board.model.BoardDAO;
import board.model.InterBoardDAO;
import common.controller.AbstractController;


public class CommentUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
	      
	      if("POST".equalsIgnoreCase(method)) {
	         // **** POST 방식으로 넘어온 것이라면 **** //
	         
	         String pk_cmt_num = request.getParameter("pk_cmt_num");
	         String cmt_contents = request.getParameter("cmt_contents");
	         
	         // !!!! 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드) 작성하기 !!!! //
	         cmt_contents = cmt_contents.replaceAll("<", "&lt;");
	         cmt_contents = cmt_contents.replaceAll(">", "&gt;");
	         
	         // 입력한 내용에서 엔터는 <br>로 변환시키기 
	         cmt_contents = cmt_contents.replaceAll("\r\n", "<br>");
	         
	         
	         InterBoardDAO bdao = new BoardDAO();
	         
	         Map<String,String> paraMap = new HashMap<>();
	         paraMap.put("pk_cmt_num", pk_cmt_num );
	         paraMap.put("cmt_contents", cmt_contents);
	         
	         int n = bdao.commentUpdate(paraMap);
	         
	         JSONObject jsobj = new JSONObject();  
	         jsobj.put("n", n);
	         
	         String json = jsobj.toString();  // 문자열 형태로 변환해줌.
	         
	         request.setAttribute("json", json);
	         
	      //   super.setRedirect(false);
	         super.setViewPage("/WEB-INF/jsonview.jsp");
	         
	      }
	      else {
	         // **** POST 방식으로 넘어온 것이 아니라면 **** //
	         
	         String message = "비정상적인 경로를 통해 들어왔습니다.!!";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setViewPage("/WEB-INF/msg.jsp");
	      }      

	}

}
