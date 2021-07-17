package com.project2.ezen;

import java.util.ArrayList;
import java.sql.*;
import com.project2.ezen.ProductDTO;







public class ProductDAO {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url="jdbc:oracle:thin:@localhost:1521:xe";
    String user="system";
    String password="Tienanmen1989..";

	public ProductDAO() {
		try {
			Class.forName(driver);
													
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		
		}
		
	}

		public ArrayList<ProductDTO>  alldatas(){
		   
		
			Connection con = null;
			PreparedStatement pstmt=null;
			ResultSet rs = null;
			String query="SELECT product_id,product_url,product_name,product_price FROM product ";
			 ArrayList<ProductDTO> listofproduct = new ArrayList<ProductDTO>();
			try {
	
				con=DriverManager.getConnection(url,user, password);
				pstmt = con.prepareStatement(query);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					ProductDTO dto = new ProductDTO();
					dto.setProduct_id(rs.getString("product_id"));
					dto.setProduct_url(rs.getString("product_url"));
					dto.setProduct_name(rs.getString("product_name"));
					dto.setProduct_price(rs.getInt("product_price"));
					
					listofproduct.add(dto);
				}
			}catch(SQLException e) {
				e.printStackTrace();
				
			}finally {
				try{
					
					if(rs!=null)rs.close();
					if(pstmt!=null)pstmt.close();
					if(con!=null)con.close();
				}catch(SQLException e) {
			
					e.printStackTrace();
				}
			}		
			return listofproduct;
			
		}
		
		
		private static ProductDAO instance = new ProductDAO();
		public static ProductDAO getInstance() {
			   return instance;
		   }
		public ArrayList<ProductDTO> getallproducts(){
			 ArrayList<ProductDTO> listofproduct = instance.alldatas();
			return listofproduct;
		}
		public ProductDTO getProductById(String product_id) {
		      ProductDTO productById = null;
		      ArrayList<ProductDTO> listofproduct = instance.alldatas();
		      for( int i=0; i < listofproduct.size(); i++) {
		         ProductDTO product = listofproduct.get(i);
		     
		         if( (product != null) && product.getProduct_id() != null  && product.getProduct_id().equals(product_id) ) {
		            productById = product;
		           
		            break;
		         }
		      }
		      return productById;
		   }
}
	

		//상품 상세정보 가져오는메소드
		
		
		
		
		
		    
	


