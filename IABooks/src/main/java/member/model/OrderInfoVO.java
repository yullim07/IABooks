package member.model;

import product.model.CategoryVO;
import product.model.OrderVO;
import product.model.ProductVO;

public class OrderInfoVO {
   
	private OrderVO ovo;
	private CategoryVO cvo;
	private ProductVO pvo;
	
	private int deliverstatus;
	private String delivername;
	
	

   // 기본생성자 
   public OrderInfoVO() {}
   
   public OrderInfoVO(int deliverstatus, String delivername) {
      super();
      this.ovo = ovo;
      this.cvo = cvo;
      this.pvo = pvo;
      
      this.deliverstatus = deliverstatus;
      this.delivername = delivername;
      
   }

		public OrderVO getOvo() {
			return ovo;
		}
		
		public void setOvo(OrderVO ovo) {
			this.ovo = ovo;
		}
		
		public CategoryVO getCvo() {
			return cvo;
		}
		
		public void setCvo(CategoryVO cvo) {
			this.cvo = cvo;
		}
		
		public ProductVO getPvo() {
			return pvo;
		}
		
		public void setPvo(ProductVO pvo) {
			this.pvo = pvo;
		}
		
		public int getDeliverstatus() {
			return deliverstatus;
		}
		
		public void setDeliverstatus(int deliverstatus) {
			this.deliverstatus = deliverstatus;
		}
		
		public String getDelivername() {
			return delivername;
		}
		
		public void setDelivername(String delivername) {
			this.delivername = delivername;
		}
   	






}