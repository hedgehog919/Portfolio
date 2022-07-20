package Fileconversion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

public class Base {
	public static void main(String[] args) {
		String url = "jdbc:sqlserver://localhost:1433;databasename=FileconversionDB"; // databasename = 資料庫名稱
		String user = "sunny";
		String pwd = "0123456";
		String sql = "SELECT * From [dbo].[109年高雄市長照服務申請--長期照顧管理中心]"; 
		// SELECT * = 選擇全部，  SELECT 單位名稱, 地址 FROM ... = 選擇單位 / 地址從某個資料表
		
		try(Connection conn = DriverManager.getConnection(url, user, pwd)){
			Statement stmt = (Statement) conn.createStatement();
			ResultSet resultSet = stmt.executeQuery(sql); // executeQuery = 執行查詢
			ResultSetMetaData rsmd = resultSet.getMetaData(); // 從ResultSet 物件底下 getMetaData 取得裡面的資料
			
			// 印出資料表欄位名稱
			int columnsNumber = rsmd.getColumnCount(); //  columns欄位
			System.out.println("印出欄位(Column)數量：" + columnsNumber);
			for (int i = 1; i <= columnsNumber; i++) { // 
				System.out.print(rsmd.getColumnName(i) + " \t"); // getColumnName 取得 欄位 名稱	 //print 沒換行
			}
			System.out.println();	// println 換行
//			System.out.printf("ID:%.2f \n", 0.12345);	// f 可以印出浮點數
			
			// 印出資料表的資料
			while (resultSet.next()) { // while = 每次抓出一行(row)資料
			    for (int i = 1; i <= columnsNumber; i++) {
			        System.out.print(resultSet.getString(i) + "\n");	// tab跳一行 --縮排 // .getString 抓到資料表中的資料

			    }
			    System.out.println();
			    System.out.println("---------------------------------------------");
			}

		} catch (SQLException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getErrorCode());
		} 
		
	}
}
