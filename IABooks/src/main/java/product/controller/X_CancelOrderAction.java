package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class X_CancelOrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		// 로그인한 유저가 아닌 경우
		// 로그인한 유저의 경우
		
	}

}

/*
 package cn.techtutorial.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.techtutorial.connection.DbCon;
import cn.techtutorial.dao.OrderDao;

@WebServlet("/cancel-order")
public class CancelOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try(PrintWriter out = response.getWriter()) {
			String id = request.getParameter("id");
			if(id != null) {
				OrderDao orderDao = new OrderDao(DbCon.getConnection());
				orderDao.cancelOrder(Integer.parseInt(id));
			}
			response.sendRedirect("orders.jsp");
		} catch (ClassNotFoundException|SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}

}
 
 
 
 */
