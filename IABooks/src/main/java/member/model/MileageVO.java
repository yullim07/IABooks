package member.model;

public class MileageVO {
	
	private int all_mg;		// 총 적립금
	private int used_mg;		// 사용된 적립금
	private int available_mg;	// 사용가능 적립금
	private int refund_mg;		// 환불예정 적립금
	private int unsecured_mg;		// 미가용 적립금
	
	
	// 기본생성자
	MileageVO() {}
	
	
	public MileageVO( int all_mg, int used_mg, int available_mg, int refund_mg, int unsecured_mg) {
		super();
		this.all_mg = all_mg;
		this.used_mg = used_mg;
		this.available_mg = available_mg;
		this.refund_mg = refund_mg;
		this.unsecured_mg = unsecured_mg;
		
		
	}


	public int getAll_mg() {
		return all_mg;
	}


	public void setAll_mg(int all_mg) {
		this.all_mg = all_mg;
	}


	public int getUsed_mg() {
		return used_mg;
	}


	public void setUsed_mg(int used_mg) {
		this.used_mg = used_mg;
	}


	public int getAvailable_mg() {
		return available_mg;
	}


	public void setAvailable_mg(int available_mg) {
		this.available_mg = available_mg;
	}


	public int getRefund_mg() {
		return refund_mg;
	}


	public void setRefund_mg(int refund_mg) {
		this.refund_mg = refund_mg;
	}


	public int getUnsecured_mg() {
		return unsecured_mg;
	}


	public void setUnsecured_mg(int unsecured_mg) {
		this.unsecured_mg = unsecured_mg;
	}
}

