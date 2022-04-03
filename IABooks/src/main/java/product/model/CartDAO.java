package product.model;

import java.util.List;

public class CartDAO implements InterCartDAO {

	@Override
	public List<CartVO> cartMoney() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void cartInsert(CartVO dto) {
		String sql = " update ";
		
	}

	@Override
	public List<CartVO> cartList(String userid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void cartDeleteOne(String pk_cartno) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void cartDeleteAll(String userid) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void cartUpdate(String pk_cartno) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int cartTotalPrice(String userid) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int cartTotalQty(String userid, String pk_pro_num) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void cartUpdate(CartVO cvo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void cartModify(CartVO cvo) {
		// TODO Auto-generated method stub
		
	}

}
