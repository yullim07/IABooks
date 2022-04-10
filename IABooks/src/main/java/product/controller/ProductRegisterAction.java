package product.controller;

import java.io.IOException;
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

		// 관리자로 로그인하는 경우에만 볼 수 있게 해야 한다!!!
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
		// 로그인을 하지 않았거나 일반사용자로 로그인 한 경우 
		if(loginuser == null || !"admin".equals(loginuser.getUserid()) ) {
			
			String message = "관리자로 로그인하세요!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
				
			
		}
		
		// 관리자로 로그인한 경우 => POST 방식인지 확인 => 
		else {
			String method = request.getMethod();
			
			// GET 방식인 경우 막아줘야 하나..? 굳이?
			if(!"POST".equalsIgnoreCase(method)) {				
				
				String message = "관리자로 로그인하세요!";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
			//	super.getCategoryList(request); // 그냥 옆에 카테고리 보여주는 거라서 필요없을 듯? 그래도 우선 넣기
				// Abstract에서 사라짐 왜?
				
				// spec 목록 보여주기 === 주석 처리
			/*
				InterProductDAO pdao = new ProductDAO();
				List<SpecVO> specList = pdao.selectSpecList(); 
				request.setAttribute("specList", specList);
			*/
			}
			
			// POST 방식이라
			else {
				/*
					파일을 첨부해서 보내는 폼태그가 enctype="multipart/form-data" 으로 되어었다라면
					HttpServletRequest request 을 사용해서는 데이터값을 받아올 수 없다.
					이때는 cos.jar 라이브러리를 다운받아 사용하도록 한 후 아래의 객체를 사용해서 데이터 값 및 첨부되어진 파일까지 받아올 수 있다.
				 */
				
				MultipartRequest mtrequest = null;
				/*
					MultipartRequest mtrequest 은 
					HttpServletRequest request 가 하던일을 그대로 승계받아서 일처리를 해주고 
					동시에 파일을 받아서 업로드, 다운로드까지 해주는 기능이 있다. 	  
				 */
				
				
				// 이미지 업로드를 위해 카테고리 이름 받아오기
				String cate_name = mtrequest.getParameter("cate_name");
				CategoryVO catevo = new CategoryVO();
				catevo.setCate_name(cate_name);
								
				// 1. 첨부되어진 파일을 디스크의 어느경로에 업로드 할 것인지 그 경로를 설정해야 한다. 
				ServletContext svlCtx = session.getServletContext();
				String uploadFileDir = svlCtx.getRealPath("/images/product/"+cate_name);
				// images/product/한 다음에 카테고리명을 써줘야 한다.
				
				
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
				 
				// === 첨부 이미지 파일을 올렸으니 그 다음으로 제품정보를 (제품명, 정가, 제품수량,...) DB의 tbl_product 테이블에 insert 를 해주어야 한다.  === 

				
				// 재입고 여부 >> 이게 맞나..?
				String restock_yes = mtrequest.getParameter("restock_yes");
				// 새로운 제품 등록시 form 태그에서 입력한 값들을 얻어오기
				String fk_cate_num = mtrequest.getParameter("fk_cate_num");
			//	String cate_name = mtrequest.getParameter("cate_name");
				String pk_pro_num = mtrequest.getParameter("pk_pro_num");
				String pro_name = mtrequest.getParameter("pro_name");
				String fk_wr_code = mtrequest.getParameter("fk_wr_code");
				String wr_name = mtrequest.getParameter("wr_name");
				String publisher = mtrequest.getParameter("publisher");
				String pro_publish_date = mtrequest.getParameter("pro_publish_date");
				String pro_price = mtrequest.getParameter("pro_price");
				String pro_saleprice = mtrequest.getParameter("pro_saleprice");
				String point_rate = mtrequest.getParameter("point_rate");
				String pro_size = mtrequest.getParameter("pro_size");
				String pro_bindtype = mtrequest.getParameter("pro_bindtype");
				String pro_pages = mtrequest.getParameter("pro_pages");
				String pro_qty = mtrequest.getParameter("pro_qty");
				
				// 업로드되어진 시스템의 첨부파일 이름(파일서버에 업로드 되어진 실제파일명)을 얻어올 때는 
				// cos.jar 라이브러리에서 제공하는 MultipartRequest 객체의
				// getFilesystemName("form에서의 첨부파일 name명") 메소드를 사용 한다. 
				// 이때 업로드 된 파일이 없는 경우에는 null을 반환한다.
				String pro_imgfile_name = mtrequest.getFilesystemName("pro_imgfile_name");
				System.out.println("~~~ 확인용 pro_imgfile_name => " + pro_imgfile_name);
				
				String pro_imgfile_name_originFileName = mtrequest.getOriginalFileName("pro_imgfile_name"); 
				System.out.println("### 확인용 pro_imgfile_name_originFileName => " + pro_imgfile_name_originFileName);
								
				
				String pro_index = mtrequest.getParameter("pro_index");
				// 시큐어 코드
				pro_index = pro_index.replaceAll("<", "&lt;");
				pro_index = pro_index.replaceAll(">", "&gt;");
				// 입력한 내용에서 엔터는 <br>로 변환시키기
				pro_index = pro_index.replaceAll("\r\n", "<br>");
				
				String pro_content = mtrequest.getParameter("pro_content");
				// 시큐어 코드
				pro_content = pro_content.replaceAll("<", "&lt;");
				pro_content = pro_content.replaceAll(">", "&gt;");
				// 입력한 내용에서 엔터는 <br>로 변환시키기
				pro_content = pro_content.replaceAll("\r\n", "<br>");
				
				
				InterProductDAO pdao = new ProductDAO();
			     
				// 제품번호 채번 해오기 << seq가 아니라서 필요하지 않음!
			//	int pnum = pdao.getPnumOfProduct();
				
				
				ProductVO pvo = new ProductVO();
			//	CategoryVO catevo = new CategoryVO();
				WriterVO wvo = new WriterVO();
				
				/*
				 * 필요한 정보
				 * 제품테이블		-	재입고여부(int pro_restock 기본값 0)
				 * 					제품코드(pk_pro_num), 제품명(pro_name), 저자코드(fk_wr_code), 카테고리코드(int fk_cate_num), 
				 * 					출판사(publisher), 출간일자(pro_publish_date), 정가(int pro_price), 도서판매가(int pro_saleprice), 
				 * 					목차(pro_index), 포인트적립률(int point_rate), 입고일자(pro_inputdate = sysdate),
				 * 					입고량(int pro_qty), 판매량(100 - pro_sales?), 크기(pro_size), 제본형태(pro_bindtype), 쪽수(int pro_pages),
				 * 					메인이미지(pro_imgfile_name), 저자코드(int fk_wr_code), 도서소개(pro_content)
				 * 					
				 * 					
				 * 카테고리테이블	-	카테고리명(cate_name)
				 * 저자테이블		- 	저자명(wr_name)
				 * 추가이미지테이블	- 	
				 * 
				 */
				
				// pro_restock
				pvo.setPro_restock(Integer.parseInt(restock_yes));
				pvo.setFk_cate_num(Integer.parseInt(fk_cate_num));
			//	catevo.setCate_name(cate_name);
				pvo.setPk_pro_num(pk_pro_num);
				pvo.setPro_name(pro_name);
				pvo.setFk_wr_code(Integer.parseInt(fk_wr_code));
				wvo.setWr_name(wr_name);
				pvo.setPublisher(publisher);
				pvo.setPro_publish_date(pro_publish_date);
				pvo.setPro_price(Integer.parseInt(pro_price));
				pvo.setPro_saleprice(Integer.parseInt(pro_saleprice));
				pvo.setPoint_rate(Integer.parseInt(point_rate));
				pvo.setPro_imgfile_name(pro_imgfile_name_originFileName);
				pvo.setPro_size(pro_size);
				pvo.setPro_bindtype(pro_bindtype);		// pro_bindtype
				pvo.setPro_pages(Integer.parseInt(pro_pages));
				pvo.setPro_qty(Integer.parseInt(pro_qty));
				pvo.setPro_index(pro_index);
				pvo.setPro_content(pro_content);
				
				String message = "";
				String loc = "";
				
				try {
					// **** tbl_product 테이블에 제품정보 insert 하기 **** //
					pdao.productInsert(pvo);
				
					// === 추가이미지파일이 있다라면 tbl_product_imagefile 테이블에 제품의 추가이미지 파일명 insert 해주기 === // 
					String str_attachCount = mtrequest.getParameter("attachCount");
					System.out.println("~~~ 확인용 추가이미지 파일개수 str_attachCount => " + str_attachCount);
					// str_attachCount 이 추가이미지 파일의 개수인데  ""  "0"  ~ "10" 값이 들어온다.
					
					int attachCount = 0;
					
					if( !"".equals(str_attachCount) ) {
						attachCount = Integer.parseInt(str_attachCount);
					}
					
					// 그런데 우리는 테이블에 원래파일명 시스템파일명 이런 거 없는데 어떡하지 
					// 첨부파일의 파일명(파일서버에 업로드 되어진 실제파일명) 알아오기
					for(int i=0; i<attachCount; i++) {
						String attachFileName = mtrequest.getFilesystemName("attach"+i);
					
						// **** tbl_product_imagefile 테이블에 VO 대신에 HashMap을 사용하여 insert **** //  
						Map<String,String> paraMap = new HashMap<>();
						paraMap.put("pk_pro_num", String.valueOf(pk_pro_num));
						paraMap.put("attachFileName", attachFileName);
						
					//	pdao.product_imagefile_Insert(paraMap);
					}// end of for-----------------------------------------------------
					
					message = "제품등록 성공!!";
					loc = request.getContextPath()+"/product/showBookList.book";
					
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
