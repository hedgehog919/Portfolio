package Fileconversion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

import java.net.URL;
import java.net.URLConnection;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;


public class Advance {
	String url = "jdbc:sqlserver://localhost:1433;databasename=FileconversionDB"; // databasename = 資料庫名稱
	String user = "sunny";
	String pwd = "0123456";
	
	// 第一步 使用Java從網路抓取資料 
	public String getDataSet(String url){	// public公開  (String url)-- 方法 ; URL是資料位址
		System.out.println("第一步 使用Java從網路抓取資料 ...");
		String Result = "";
		try {
			URL urlCSV = new URL(url); //URL java的物件 --建立一個URL物件
			URLConnection urlConn = urlCSV.openConnection(); // URL 連結網路
			InputStreamReader inputCSV = new InputStreamReader(((URLConnection) urlConn).getInputStream()); // 取得 輸入網址裡面的資料 // Stream=串流
			BufferedReader br = new BufferedReader(inputCSV); //緩衝區 -- 批次取得資料用，減少記憶體消耗
			String line; // Line 線
			while ((line = br.readLine()) != null) {
				Result += line + "\n";	// \n--換行 Result 結果
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} 
		System.out.println("完成");
		return Result;
	}
	
	// 第二步 將資料存入資料庫中
	public void InputSqlDataSet(String text) {
		System.out.println("第二步 將資料存入資料庫中 ...");
		String sql1 = "IF NOT EXISTS (" // 如果此資料不存在
					+ "		SELECT * FROM sys.objects "
					+ "		WHERE object_id = OBJECT_ID(N'dbo.oldMen')"	// oldMen資料表名稱
					+ "	) CREATE TABLE OldMen("
					+ "	unit varchar(50), address varchar(150), "	// unit單位名稱  address地址
					+ "	phone varchar(50), phone2 varchar(50), "	// phone 連絡電話 phone2 傳真電話
					+ "	email varchar(50))";
		try(Connection conn = DriverManager.getConnection(url, user, pwd)){  // DriverManager資料庫訊息
			// Statement 創建資料表 conn連線物件
			Statement stmt = (Statement) conn.createStatement();
			boolean result = stmt.execute(sql1); // execute = 執行

			// 輸入資料進入資料
			String[] textSplit = text.split(",|\n");
			for (int i = 0+5; i < textSplit.length; i+=5) {
				String sql2 = "INSERT INTO [dbo].[oldMen]"
						+ "	([unit],[address],[phone],[phone2],[email])"
						+ " VALUES ('" + textSplit[i] + "', '" + textSplit[i+1] +"', "
						+ "'" + textSplit[i+2] + "', " + "'" + textSplit[i+3] + "', " + "'" + textSplit[i+4] + "');";
				stmt.addBatch(sql2);
			}
			int[] executeBatch = stmt.executeBatch();	
			// int[] 陣列--stmt物件 executeBatch方法
			
			
			// 資源釋放
			conn.close();
		} catch (SQLException e) {
			System.out.println(e.getMessage());		
			System.out.println(e.getErrorCode());	// 取得錯誤訊息
		} 
		System.out.println("完成");
	}
	
	// 第三步 讀取資料出來
	public String getSqlDataSet() {
		System.out.println("第三步 讀取資料出來 ...");
		String sql = "SELECT * From [dbo].[OldMen]"; 
		String result = "";	// String result 字串結果 
		try(Connection conn = DriverManager.getConnection(url, user, pwd)){
			Statement stmt = (Statement) conn.createStatement();
			ResultSet resultSet = stmt.executeQuery(sql); // executeQuery = 執行查詢
			ResultSetMetaData rsmd = resultSet.getMetaData(); // 從ResultSet 物件底下 getMetaData 取得裡面的資料
			
			// 取得資料表欄位名稱
			int columnsNumber = rsmd.getColumnCount();
			for (int i = 1; i <= columnsNumber; i++) {
				result += rsmd.getColumnName(i) + ", ";	
				// result結果 += rsmd.getColumnName(i)--result = result + rsmd.getColumnName(i)
			}
			result += "\n";
			
			// 印出資料表的資料
			while (resultSet.next()) { // 每次抓出一行(row)資料
			    for (int i = 1; i <= columnsNumber; i++) {
			    	result += resultSet.getString(i) + ", ";
			    }
				result += "\n";
			}

		} catch (SQLException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getErrorCode());
		} 
		System.out.println("完成");
		return result;
	}
	
	// 第四步 將讀取的資料匯出成csv檔案
	public void writeFile(String filePath, String Text) {
		System.out.println("第四步 將讀取的資料匯出成csv檔案 ...");
		File file = new File(filePath); // 建立filePath 路徑
		try {
	        // 取得FileWriter物件
	        FileWriter FW = new FileWriter(filePath);
	        FW.write(Text); // 寫出來
	        FW.close(); // 關掉他
	    }
		catch (Exception e) {
			System.out.println(e.getMessage());
		} 
		System.out.println("完成");
	}
	
	public static void main(String[] args) {	// 總結以上四步奏
		String urlOrgData = "https://data.kcg.gov.tw/dataset/ae326992-4179-431b-aa2a-d1660a447f7c/resource/79a289ac-53f9-4eac-80b0-768c43feb3d1/download/109--3.csv";
							// 取得政府開放資料的CSV檔
		
		Advance Adv = new Advance();
		// 第一步 使用Java從網路抓取資料 
		String urlText = Adv.getDataSet(urlOrgData);
		// 第二步 將資料存入資料庫中
		Adv.InputSqlDataSet(urlText);
		// 第三步 讀取資料出來
		String getText = Adv.getSqlDataSet();
		// 第四步 將讀取的資料匯出成csv檔案
		Adv.writeFile("./output.csv", getText);
	}

}
