package Loop_learn;

import java.util.Scanner;

public class Loop_Exam05_learn04_DoubleForLoop {

/*	迴圈輸出多變圖形 - 菱形
 * 
 * 參考資料 : 
 * https://matthung0807.blogspot.com/2018/02/java.html
 * https://www.delftstack.com/zh-tw/howto/java/java-pyramid-of-stars/
 * 
 * 
 * */	

	public static void main(String[] args) {
	
		Scanner pyramid_scanner = new Scanner(System.in);	// 建立一個叫 pyramid_scanner 的物件
		
		Integer pyramid_rows;	// 金字塔行數
		Integer p;	// 金字塔 pyramid 
		Integer pyramid_spaces;	 // 間距
		Integer star_count;	// 星星數
	      
	    System.out.print("Enter the number of rows of pyramid (金字塔行數) : ");
	    pyramid_rows = pyramid_scanner.nextInt();
	        
	        System.out.print("");
	        System.out.println(" -------- 圖形結果 --------");
	        System.out.println();
	        
	        
	    // Loops for the first pyramid 正金字塔的循環
	        for(p = 0; p < pyramid_rows; p ++){
	            for(pyramid_spaces = p ; pyramid_spaces < pyramid_rows; pyramid_spaces++) {	// 設定金字塔空格距離
	                System.out.print(" ");	// 印出金字塔中每行的空格
	            }
	            for(star_count = 0; star_count < (p + 1); star_count++) {
	                System.out.print("* ");	// 印出金字塔中每行的星星
	            }
	           System.out.print("\n");
	        }
	        
	   // Loops for the inverted pyramid 倒金字塔的循環
	        for(p = pyramid_rows; p > 0; p = (p - 1)){	// 倒型金字塔行數 - 1
	            for(pyramid_spaces = pyramid_rows; pyramid_spaces >= ( p - 1 ); pyramid_spaces--) {
	                System.out.print(" ");
	            }
	            for(star_count = ( p - 1 ); star_count > 0; star_count--) {
	                System.out.print("* ");
	            }
	           System.out.print("\n");
	        }
	}
}
