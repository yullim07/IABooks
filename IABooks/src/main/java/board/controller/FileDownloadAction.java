package board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.BoardDAO;
import board.model.InterBoardDAO;
import common.controller.AbstractController;


public class FileDownloadAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pk_qna_num = request.getParameter("pk_qna_num");
		
		try {
			// 다운로드 할 파일의 경로를 알아오고 File 객체를 생성한다.
			HttpSession session = request.getSession();
			
			ServletContext svlCtx = session.getServletContext();
			String uploadFileDir = svlCtx.getRealPath("/images");
			
		//	System.out.println("=== 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir ==> " + uploadFileDir);
			// === 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir 
			
			// *** 시스템에 업로드 되어진 파일설명서 첨부파일명 및 오리지널파일명 알아오기 *** //
			InterBoardDAO bdao = new BoardDAO();
			Map<String,String> map = bdao.getQnaImgFileName(pk_qna_num);
			
			// >>> File 객체 생성하기 <<< //
		//	String filePath = uploadFileDir +"\\" + map.get("prdmanual_systemFileName");
			String filePath = uploadFileDir + File.separator + map.get("qna_file_system_name");
			/* File.separator ==> 사용중인 운영체제가 Windows 이라면  File.separator 의 값은 "\" 이고,
								  사용중인 운영체제가 매킨토시, Linux, Unix 이라면  File.separator 의 값은 "/" 이다.
			*/
			
			File file = new File(filePath);
			
			// MIME TYPE 설정하기 
	        // (구글에서 검색어로 MIME TYPE 을 해보면 MIME TYPE에 따른 문서종류가 쭉 나온다)
	        String mimeType = svlCtx.getMimeType(filePath);
	        
	   //   System.out.println("~~~~ 확인용 mimeType => " + mimeType);
	        //  ~~~~ 확인용 mimeType => application/pdf  .pdf 파일임
	        //   ~~~~ 확인용 mimeType => image/jpeg       .jpg 파일임
	        //  ~~~~ 확인용 mimeType => application/vnd.openxmlformats-officedocument.spreadsheetml.sheet    엑셀파일임.
			
	        // 현재 pdf파일을 다운받고자 할때, pdf파일에 경로네임을 적어주면 타입이 쫙 나온다.
	        
	        
	        if(mimeType == null) {
	        	mimeType = "application/octet-stream";
	        	// "application/octet-stream" 은 일반적으로 잘 알려지지 않은 모든 종류의 이진 데이터를 뜻하는 것임. 
	        }
	        response.setContentType(mimeType);
	        
	        // 다운로드 되어질 파일명 알아와서 설정해주기
	        String qna_file_original_name = map.get("qna_file_original_name");
	     // map.get("qna_file_original_name")이 웹클라이언트의 웹브라우저에서 파일을 업로드 할때 올리는 제품설명서 파일명임.
	        
	        //내용물이 영어는 괜찮은데 한글은 막 깨져서 나올 수 있음. 
	        /*
	         	qna_file_original_name(다운로드 되어질 파일명)에 한글이 포함되어질 경우
	         	한글이 깨지지 않도록 웹브라우저 별로 encoding 하기 및  다운로드 파일명 설정해주기
	         */
	        
	        String downloadFileName = "";
	        String header = request.getHeader("User-Agent");
	        
	        if (header.contains("Edge")){
	            downloadFileName = URLEncoder.encode(qna_file_original_name, "UTF-8").replaceAll("\\+", "%20");
	             response.setHeader("Content-Disposition", "attachment;filename=" + downloadFileName);
	        } else if (header.contains("MSIE") || header.contains("Trident")) { // IE 11버전부터는 Trident로 변경됨.
	             downloadFileName = URLEncoder.encode(qna_file_original_name, "UTF-8").replaceAll("\\+", "%20");
	             response.setHeader("Content-Disposition", "attachment;filename=" + downloadFileName);
	        } else if (header.contains("Chrome")) {
	            downloadFileName = new String(qna_file_original_name.getBytes("UTF-8"), "ISO-8859-1");
	             response.setHeader("Content-Disposition", "attachment; filename=" + downloadFileName);
	        } else if (header.contains("Opera")) {
	            downloadFileName = new String(qna_file_original_name.getBytes("UTF-8"), "ISO-8859-1");
	             response.setHeader("Content-Disposition", "attachment; filename=" + downloadFileName);
	        } else if (header.contains("Firefox")) {
	            downloadFileName = new String(qna_file_original_name.getBytes("UTF-8"), "ISO-8859-1");
	             response.setHeader("Content-Disposition", "attachment; filename=" + downloadFileName);
	        }
	        
	        // *** 다운로드 할 요청 파일을 읽어서 클라이언트로 파일을 전송하기 *** //
	        FileInputStream finStream = new FileInputStream(file);  //파일객체가 빨대를 딱 꼽아
	        // 1byte 기반 파일 입력 노드스트림 생성
	        
	        ServletOutputStream srvOutStream = response.getOutputStream();
	        // 1byte 기반 파일 출력 노드스트림 생성
	        // ServletOutputStream 은 바이너리 데이터를 웹 브라우저로 전송할 때 사용하는 것임.
	        
	        byte arrb[] = new byte[4096]; //4kB
	        int data = 0;
	       // finStream.read(arrb, 0, arrb.length)// 리턴타입이 int
	        while( (data = finStream.read(arrb, 0, arrb.length)) != -1 ) { // -1이 아니라면 = 끝이 아니라면
	        	//보내준다   data는 실제 읽어진 크기
	        	srvOutStream.write(arrb, 0, data);          //IO 참조한다.
	        }//end of while ----------
	        //항상 write가 나오면 flush를 쓴다.
	        
	        srvOutStream.flush();
	        
	        srvOutStream.close(); //출력노드스트림 닫아준다.
	        finStream.close(); //입력노드스트림 닫아준다.
	        
		}catch(SQLException e) {
			
		}

	}

}
