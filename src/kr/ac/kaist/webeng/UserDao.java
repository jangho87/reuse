package kr.ac.kaist.webeng;
import java.sql.*;

public class UserDao {
	public int checkId(String usrid) throws Exception{
		String DB_URL = "jdbc:mysql://localhost/reuse";
		String DB_USER="root";
		String DB_PASSWORD="qwer1234";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		int re = 0;
		try {
			// 1.JDBC Drive loading
			Class.forName("org.gjt.mm.mysql.Driver");
			
			// 2. Connection to DB
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
			String selectSQL = "select * from asset where asset_name = ?";
			pstmt = conn.prepareStatement(selectSQL);
			pstmt.setString(1, usrid);
			ResultSet rs = pstmt.executeQuery();
			if( rs.next() ){
				re = 1;
			}
		}
		finally {
			if( pstmt != null ) try{ pstmt.close(); } catch(SQLException e){}
			if( conn != null ) try{ conn.close(); } catch(SQLException e){}
		}
		return re;
	}
}
