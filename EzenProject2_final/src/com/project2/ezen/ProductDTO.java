package com.project2.ezen;

public class ProductDTO {
  private	String product_id;
  private	String product_name;
  private Integer product_price;
  private	String product_url;
  private	String product_desc;
  private	String product_durl;
  private int quantity;


 
	
	public String getProduct_id() {
		return product_id;
	}
	public void setProduct_id(String product_id) {
		this.product_id = product_id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public Integer getProduct_price() {
		return product_price;
	}
	public void setProduct_price(Integer product_price) {
		this.product_price = product_price;
	}
	public String getProduct_url() {
		return product_url;
	}
	public void setProduct_url(String product_url) {
		this.product_url = product_url;
	}
	
	public String getProduct_desc() {
		return product_desc;
	}
	public void setProduct_desc(String product_desc) {
		this.product_desc = product_desc;
	}
	public String getProduct_durl() {
		return product_durl;
	}
	public void setProduct_durl(String product_durl) {
		this.product_durl = product_durl;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	@Override
	public String toString() {
		return  product_id ;
	}
	
	

}
