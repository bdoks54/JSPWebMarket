package com.project2.ezen;

import java.sql.Date;

public class OrderDTO {
	private int order_id;
	private String order_name;
	private String order_phone;
	private String order_postcode;
	private String order_address;
	private String order_detailaddress;
	private String order_extraaddress;
	private Date order_date;
	private String fk_cust_id;
	
	public OrderDTO() {
		// TODO Auto-generated constructor stub
	}
	
	

	public int getOrder_id() {
		return order_id;
	}


	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}



	public String getOrder_name() {
		return order_name;
	}
	public void setOrder_name(String order_name) {
		this.order_name = order_name;
	}
	public String getOrder_postcode() {
		return order_postcode;
	}
	public void setOrder_postcode(String order_postcode) {
		this.order_postcode = order_postcode;
	}
	public String getOrder_address() {
		return order_address;
	}
	public void setOrder_address(String order_address) {
		this.order_address = order_address;
	}
	public String getOrder_detailaddress() {
		return order_detailaddress;
	}
	public void setOrder_detailaddress(String order_detailaddress) {
		this.order_detailaddress = order_detailaddress;
	}
	public String getOrder_extraaddress() {
		return order_extraaddress;
	}
	public void setOrder_extraaddress(String order_extraaddress) {
		this.order_extraaddress = order_extraaddress;
	}
	public Date getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	public String getFk_cust_id() {
		return fk_cust_id;
	}
	public void setFk_cust_id(String fk_cust_id) {
		this.fk_cust_id = fk_cust_id;
	}
	
	
	public String getOrder_phone() {
		return order_phone;
	}
	public void setOrder_phone(String order_phone) {
		this.order_phone = order_phone;
	}



	@Override
	public String toString() {
		return "OrderDTO [order_id=" + order_id + ", order_name=" + order_name + ", order_phone=" + order_phone
				+ ", order_postcode=" + order_postcode + ", order_address=" + order_address + ", order_detailaddress="
				+ order_detailaddress + ", order_extraaddress=" + order_extraaddress + ", order_date=" + order_date
				+ ", fk_cust_id=" + fk_cust_id + "]";
	}




	

	

}
