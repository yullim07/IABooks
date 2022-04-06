package product.controller2;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;

public class ShowIndexBestAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String cate_name = request.getParameter("cate_name");

		InterProductDAO pdao = new ProductDAO();
		 
	    Map<String,String> paraMap = new HashMap<>();
	    paraMap.put("cate_name", cate_name); 
	     
	    List<ProductVO> prodList = pdao.selectIndexBest(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		if(prodList.size() > 0) {
			for(ProductVO pvo : prodList) {
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("pro_name", pvo.getPro_name());
				jsonObj.put("pro_imgfile_name", pvo.getPro_imgfile_name());
				jsonObj.put("pk_pro_num", pvo.getPk_pro_num());
				jsonObj.put("pro_saleprice", pvo.getPro_saleprice());
				jsonObj.put("cate_name", pvo.getCategory().getCate_name());

	            jsonArr.put(jsonObj);
	
			}//end of for
			
			String json =jsonArr.toString();
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}else {
			String json =jsonArr.toString();
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}//end of if
		
	}

}
