package product.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.*;

public class ProductRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임.
		super.goBackURL(request);
		super.getCategoryList(request); // 필요없다
		
		// 관리자로 로그인하는 경우에만 볼 수 있게 해야 한다!!!
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser == null || !"admin".equals(loginuser.getUserid()) ) { 
			

			String message = "관리자로 로그인하세요!";
			String loc = "<%= ctxPath%>/login/join.book";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");

		}
				
		// 관리자로 로그인한 경우 => POST 방식인지 확인 => 
		else {
			
			String method = request.getMethod();
			
			if(!"POST".equalsIgnoreCase(method)) {			
	
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/product/admin/productRegister.jsp");
				
			}
			
			// POST 방식이라
			else {
				/*
					파일을 첨부해서 보내는 폼태그가 enctype="multipart/form-data" 으로 되어었다면
					HttpServletRequest request 을 사용해서는 데이터값을 받아올 수 없다.
					이때는 cos.jar 라이브러리를 다운받아 사용하도록 한 후 아래의 객체를 사용해서 데이터 값 및 첨부되어진 파일까지 받아올 수 있다.
				 */
				
				MultipartRequest mtrequest = null;
				
				////////////////////////////////////////////////////////////////////////////////////////////////		
				
				// 1. 첨부되어진 파일을 디스크의 어느경로에 업로드 할 것인지 그 경로를 설정해야 한다. 
				ServletContext svlCtx = session.getServletContext();
				String uploadFileDir = svlCtx.getRealPath("/images/product/");
				//System.out.println("=== 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir ==> " + uploadFileDir);
				// 가급적이면 하나의 폴더에 넣자!
				
				// ==== 파일을 업로드 해준다. 시작 ==== //
				try {
					mtrequest = new MultipartRequest(request, uploadFileDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy() );
				} catch(IOException e) {
					e.printStackTrace();
					 
					request.setAttribute("message", "업로드 되어질 경로가 잘못되었거나 또는 최대용량 10MB를 초과했으므로 파일업로드 실패함!!");
					request.setAttribute("loc", request.getContextPath()+"/product/admin/productRegister.book"); 
								   	  
					super.setViewPage("/WEB-INF/msg.jsp");
					return; // 종료
				}
				// ==== 파일을 업로드 해준다. 끝 ==== //
				
				// ==== 파일의 이름 경로를 알아와서 원하는 위치로 이동시킨다. ==== //
				
				String pro_imgfile_name_originFileName = mtrequest.getOriginalFileName("pro_imgfile_name"); 
				String pro_imgfile_name = mtrequest.getFilesystemName("pro_imgfile_name");
				String cateNameChoice = mtrequest.getParameter("cateNameChoice");
				
				
				/*
				String srcFile = uploadFileDir+pro_imgfile_name_originFileName;
				
				String dstFile = "C:/Users/sist/git/IABooks/IABooks/src/main/webapp/images/product/"+cateNameChoice+"/"+pro_imgfile_name_originFileName;
				String fstFile = uploadFileDir+cateNameChoice+"/"+pro_imgfile_name_originFileName;
				
				File src = new File(srcFile);
				File dst = new File(dstFile);
				File fst = new File(fstFile);
				src.renameTo(dst);
				src.renameTo(fst);
				*/
				
				try {
				    Path filePath = Paths.get(uploadFileDir+pro_imgfile_name_originFileName);
				    Path filePathToMove = Paths.get(uploadFileDir+cateNameChoice+"/"+pro_imgfile_name_originFileName);
				    Path filePathToMove2 = Paths.get("C:/Users/sist/git/IABooks/IABooks/src/main/webapp/images/product/"+cateNameChoice+"/"+pro_imgfile_name_originFileName);
				    Files.move(filePath, filePathToMove, StandardCopyOption.REPLACE_EXISTING);
				    Files.move(filePath, filePathToMove2, StandardCopyOption.REPLACE_EXISTING);
				} catch (IOException e) {
				    e.printStackTrace();
				}
				// ==== 파일의 이름 경로를 알아와서 원하는 위치로 이동시킨다. 끝==== //
				
				
				// === 제품정보를 (제품명, 정가, 제품수량,...) DB의 tbl_product 테이블에 insert 를 해주어야 한다.  === 
				//판매량.조회수 품절유무 입고일자 제외 + 작가이름,작가소개 , 카테고리이름
				String restock = mtrequest.getParameter("restock");//재입고 
				pro_imgfile_name = pro_imgfile_name_originFileName;//이미지파일명
				String fk_cate_num = mtrequest.getParameter("fk_cate_num");//카테고리 넘버
				//String cate_name = mtrequest.getParameter("cate_name");//카테고리이름
				String pk_pro_num = mtrequest.getParameter("pk_pro_num");//책표준번호
				String pro_name = mtrequest.getParameter("pro_name");//책이름
				String fk_wr_code = mtrequest.getParameter("fk_wr_code");//작가코드
				String wr_name = mtrequest.getParameter("wr_name");//작가이름
				String publisher = mtrequest.getParameter("publisher");//출간사명
				String pro_publish_date = mtrequest.getParameter("pro_publish_date");//출간일
				String pro_price = mtrequest.getParameter("pro_price");//도서정가
				String pro_saleprice = mtrequest.getParameter("pro_saleprice");//도서판매가
				String point_rate = mtrequest.getParameter("point_rate");//적립포인트
				String pro_size = mtrequest.getParameter("pro_size");//책크기
				String pro_bindtype = mtrequest.getParameter("pro_bindtype");//제본형태
				String pro_pages = mtrequest.getParameter("pro_pages");//페이지
				String pro_qty = mtrequest.getParameter("pro_qty");//도서재고량
							
				String pro_index = mtrequest.getParameter("pro_index");//목차
				String pro_content = mtrequest.getParameter("pro_content");//책소개
				String wr_info = mtrequest.getParameter("wr_info");//작가소개
				
				// 시큐어 코드
				
				if(!("".equalsIgnoreCase(pro_index) || pro_index == null)) {
					pro_index = pro_index.replaceAll("<", "&lt;");
					pro_index = pro_index.replaceAll(">", "&gt;");
					pro_index = pro_index.replaceAll("\r\n", "<br>");
					
				}else {
					pro_index = "";
				}
				if(!("".equalsIgnoreCase(pro_content) || pro_content == null)) {
					pro_content = pro_content.replaceAll("<", "&lt;");
					pro_content = pro_content.replaceAll(">", "&gt;");
					pro_content = pro_content.replaceAll("\r\n", "<br>");
					
				}else {
					pro_content = "";
				}
				if(!("".equalsIgnoreCase(wr_info) || wr_info == null)) {
					wr_info = wr_info.replaceAll("<", "&lt;");
					wr_info = wr_info.replaceAll(">", "&gt;");
					wr_info = wr_info.replaceAll("\r\n", "<br>");
					
				}else {
					wr_info = "";
				}
				


				

				InterProductDAO pdao = new ProductDAO();
				
				Map<String,String> paraMap = new HashMap<>();
			  
			    ProductVO pvo = new ProductVO();
				
				if("".equalsIgnoreCase(pro_pages) || pro_pages == null) {
					pvo.setPro_pages(0);
				}else{
					pvo.setPro_pages(Integer.parseInt(pro_pages));
				}
			   
			    if("".equals(restock) || restock==null || Integer.parseInt(restock) == 0 ) {
			    	pvo.setPro_restock(0);
			    }else {
			    	pvo.setPro_restock(Integer.parseInt(restock));
			    }
				
				pvo.setFk_cate_num(Integer.parseInt(fk_cate_num));
			    
				pvo.setPk_pro_num(pk_pro_num);
				pvo.setPro_name(pro_name);
				//pvo.setFk_wr_code(Integer.parseInt(fk_wr_code));
				pvo.setPublisher(publisher);
				pvo.setPro_publish_date(pro_publish_date);
				pvo.setPro_price(Integer.parseInt(pro_price));
				pvo.setPro_saleprice(Integer.parseInt(pro_saleprice));
				
				//pvo.setPoint_rate(Integer.parseInt(point_rate));
				pvo.setPoint_rate(Double.valueOf(point_rate));
				pvo.setPro_imgfile_name(pro_imgfile_name);
				pvo.setPro_size(pro_size);
				pvo.setPro_bindtype(pro_bindtype);
				pvo.setPro_qty(Integer.parseInt(pro_qty));
				pvo.setPro_index(pro_index);
				pvo.setPro_content(pro_content);
			    
				String message = "";
				String loc = "";
				int n = 0;
				int seq = 0;
				int wrCodecheck = 0;
				paraMap.put("wr_name", wr_name); 
				paraMap.put("wr_info", wr_info); 
				paraMap.put("fk_wr_code", fk_wr_code); 
				try {
					
					int wr_code = pdao.findWrcode(paraMap);
					
				    if(wr_code != 0) {//존재하는 경우 작가코드 가져다씀
				    	wrCodecheck = wr_code;	
				    }else {//존재하지 않는 경우 작가 추가
				    	
				    	seq = pdao.getSeq_tbl_writer() ;
				    	wrCodecheck = seq;
				    	paraMap.put("fk_wr_code", Integer.toString(seq)); 
				    	
				    	 n = pdao.writerInsert(paraMap);
				    }
				    
				    paraMap.put("fk_wr_code", Integer.toString(wrCodecheck)); 
				    
				    System.out.println("wrCodecheck"+wrCodecheck);
			    	pvo.setFk_wr_code(wrCodecheck);
				    
				    paraMap.put("pk_pro_num", pk_pro_num); 
				    String pro_num = pdao.findProNum(paraMap);
				    
				    if(pro_num == null || "".equalsIgnoreCase(pro_num)) { //신간인경우 insert
				    	n  = pdao.productInsert(pvo);
				    	
				    }else {//도서표준번호가 있는 경우 update 품절이면 해제 , 품절아니면 추가
				    	 paraMap.put("pro_num", pro_num); 
				    	 paraMap.put("pro_qty", pro_qty); 
				    	 paraMap.put("pro_saleprice", pro_saleprice); 
				    	
				    	 n  = pdao.productUpdate(paraMap);
				    }
				    			   
					if(n==1) {
					message = "제품등록 성공!!";
					loc = request.getContextPath()+"/product/showBookList.book";
					
					}else {
						message = "제품등록 실패!!";
						loc = request.getContextPath()+"/product/admin/productRegister.book";
					}	
				} catch(SQLException e) {
					e.printStackTrace();
					
					message = "제품등록 실패!!";
					loc = request.getContextPath()+"/product/admin/productRegister.book";
				}
					 
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				   
				super.setViewPage("/WEB-INF/msg.jsp");
	
			}
		}
		
		
	}

}