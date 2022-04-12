package product.controller;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class WriterRegister extends AbstractController {

	// 작가코드를 생성해주는 메소드 생성하기 //
	
	private String getWr_code() throws SQLException {
		
		// 작가코드 형식 : 그냥 시퀀스만 사용하기(앞의 코드들이 1000~4000까지의 4자리 숫자니까)
		
		InterProductDAO pdao = new ProductDAO();
		
		int seq = pdao.getSeq_tbl_writer();
		// pdao.getSeq_tbl_order();는 시퀀스 seq_tbl_order 값을 채번해오는 것이다.
		
		return "e"+seq;
		
	} // end of private String getWr_code() --------------------
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
