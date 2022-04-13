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

	/*
	 * else 에만 getCate~ 하면 cate_name은 잡히고 fk_cate_num이 널이 나와서 등록이 안되고 이 작가코드란 놈은 갑자기 무결성ㅈ ㅔ약을 따지고 앉아있다
다시 원상복구 했는데 어떻게 했는지 ㄲ먹기 전에 커밋하기 그리고 getCate눈 else에만 하고, 작가코드는 이미 존재하는 거  그냥 넣자.. => 그리고 이미지 경로 잡기 
코드를 바꿨더니 안됨 => "humaniryty" 을 "101"로 바꾼 거임
else 문의 !POST에만 getCate~ 넣기? 이렇게 하면 이미지 빼고 다 잡아옴 / POST에 넣으면 어떻게 되나 해보기
카테고리 못 잡아옴=> 결론. else문의 !POST에만 넣자! if문에 넣으면  어떻게 되지? 얘도 못 잡아옴 // 맨 위에 넣으면? 잡아오네? 얘도 test해보기
	 * */
	
	
	
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임.
		super.goBackURL(request);
		super.getCategoryList(request); // 필요없다
		
		// 관리자로 로그인하는 경우에만 볼 수 있게 해야 한다!!!
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		// 로그인을 하지 않았거나 일반사용자로 로그인 한 경우 => 이미 링크에서 막아줬기 때문에 필요없다? 모르겠다.. 왜 막는 거지?
		if(loginuser == null || !"admin".equals(loginuser.getUserid()) ) { // 애초에 들어갈 수가 없는데... get 부터 막아야 하는 거 아닌가?
			
		//	super.getCategoryList(request); // 굳이 보여줄 필요 없다!
			
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
			
			if(!"POST".equalsIgnoreCase(method)) {			
	
				// 카테고리 목록을 조회해오기
			//	super.getCategoryList(request);
				
				// spec 목록을 보여주고자 한다.
			/*	InterProductDAO pdao = new ProductDAO();
				List<SpecVO> specList = pdao.selectSpecList(); 
				request.setAttribute("specList", specList);
			*/
				
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
				// MultipartRequest mtrequest 은 HttpServletRequest request 가 하던일을 그대로 승계받아서 일처리를 해주고 
				// 동시에 파일을 받아서 업로드, 다운로드까지 해주는 기능이 있다. 	  
				
				// 이미지 업로드를 위해 카테고리 이름 받아오기 => form에서 받아오고 싶은데 어떻게? get으로
				// 근데 이미 set으로 form 으로 보내줬는데 어떻게 가지? => 뭐냐 그거 if문으로 잡아온다고 함
				
				CategoryVO catevo = new CategoryVO();
				
				///////////////////////// 강사님이 도와주심 ///////////////////////////////////////////////////////////////////////
				
				/*
				 * select 문으로 받아왔을 때
				 * String dir = "";
				 * if("A".equals(fk_cate_num)) {
				 * 	   dir = "/file_a";
				 * }
				 * else if("B".equals(fk_cate_num)) {
				 * 	   dir = "/file_b";
				 * }
				 * else if("C".equals(fk_cate_num)) {
				 * 	   dir = "/file_c";
				 * }
				 */
				
				// 코드가 더럽다 => category select 해와서 where 절 넣으면 되는데
				// 그냥 select문 써서 우선 이걸로 하려면 -> 뷰단에서 input type="hidden"을 만들고
				// 얘를 넘거주는 jquery문이 없으니까 버튼 이벤트에 어떻게 넘겨주는 뭔가를 만들어서 어떻게 어떻게 한다
				// 근데 안 됨 그냥 DAO 만들자.
				
			//	String fk_cate_num = request.getParameter("cateselhide"); // 안됨
				String fk_cate_num = request.getParameter("fk_cate_num"); // 안됨
				// 뷰단에서 name이 category인 값을 받아온다. 이거 int로 잡으면 null 값 뜸
				System.out.println("확인용 fk_cate_num : " + fk_cate_num);
				
				String dir = "";
			
				if("101".equals(fk_cate_num)) {
			//	if("humanities".equals(fk_cate_num)) {
					dir = "/humanities";
				}
				else if("102".equals(fk_cate_num)) {
			//	else if("society".equals(fk_cate_num)) {
					dir = "/society";					
				}
				else if("103".equals(fk_cate_num)) {
			//	else if("science".equals(fk_cate_num)) {
					dir = "/science";
				}
				else if("104".equals(fk_cate_num)) {
			//	else if("other".equals(fk_cate_num)) {	
					dir = "/other";
				}
				System.out.println("~~~ 확인용 dir : " + dir);

				////////////////////////////////////////////////////////////////////////////////////////////////		
				
				// 1. 첨부되어진 파일을 디스크의 어느경로에 업로드 할 것인지 그 경로를 설정해야 한다. 
				ServletContext svlCtx = session.getServletContext();
				String uploadFileDir = svlCtx.getRealPath("/images/product/"+dir);
				System.out.println("=== 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir ==> " + uploadFileDir);
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
				 
				// === 첨부 이미지 파일을 올렸으니 그 다음으로 제품정보를 (제품명, 정가, 제품수량,...) DB의 tbl_product 테이블에 insert 를 해주어야 한다.  === 
				
				
				String restock = mtrequest.getParameter("restock");			// 재입고 여부 >> 이게 맞나..?
			//	System.out.println("~~~~~ restock : " + restock);
				
				fk_cate_num = mtrequest.getParameter("fk_cate_num");
				String cate_name = mtrequest.getParameter("cate_name");
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

			     
				// 제품번호 채번 해오기 << seq가 아니라서 필요하지 않음!
			//	int pnum = pdao.getPnumOfProduct();
				
				InterProductDAO pdao = new ProductDAO();
				
				ProductVO pvo = new ProductVO();
				catevo = new CategoryVO();
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
				pvo.setPro_restock(Integer.parseInt(restock));
				pvo.setFk_cate_num(Integer.parseInt(fk_cate_num));
				
				/////////////////////////////////////////////////////////////////////////////////
				
				catevo.setCate_name(cate_name);
				
				/////////////////////////////////////////////////////////////////////////////////
				
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
				//	System.out.println("~~~ 확인용 추가이미지 파일개수 str_attachCount => " + str_attachCount);
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
