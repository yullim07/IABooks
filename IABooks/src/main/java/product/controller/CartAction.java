package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;
import product.model.*;

public class CartAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		/*
		 * // 카테고리 목록 조회? super.getCategoryList(request);
		 */
		
		// 로그인 여부
		boolean isLogin = super.checkLogin(request);
		
		// 로그인을 하지 않은 경우
		if(!isLogin) {
			request.setAttribute("message", "장바구니를 보려면 로그인하세요.");
			request.setAttribute("loc", "javascript:history.back()");
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		// 로그인을 한 경우	
		else { 
			request.setAttribute("message", "장바구니를 보려면 로그인하세요.");
			request.setAttribute("loc", "javascript:history.back()");
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
	}	
		
		
		
		
		
		

}
