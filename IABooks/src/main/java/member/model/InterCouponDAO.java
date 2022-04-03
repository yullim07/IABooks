package member.model;

import java.sql.SQLException;

public interface InterCouponDAO {

	// 쿠폰등록을 해주는 메소드
	int couponRegister(CouponVO coupon) throws SQLException;

	
	
}
