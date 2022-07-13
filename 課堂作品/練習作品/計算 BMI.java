package number_learn;
import java.math.BigDecimal;
import java.util.Scanner;

public class Exam01_03_learn5 {
private static final double BMI_Result = 0;


// 題目 : 計算 BMI

/*	老師提醒！
 * 	計算 BMI 不能用 int ，因為體重身高都有小數了，所以一定要用 float
 * 	h = sc.nextFloat();
 * 	w = sc.nextFloat();
 * 
 * */

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		float Weight = 0,Height = 0;

		System.out.print(" 請輸入您的體重 (kg) : ");
		float weight = sc.nextFloat();
		System.out.print(" 請輸入您的身高 (m) : ");
        float height = sc.nextFloat();
        float BMI=weight/(height*height);
     
        
        // 計算 BMI 範圍
        if (BMI < 18.5 ) {
	      	System.out.println(" BMI = " + BMI );	// 小於 18.5 為 Underweight 過輕
	    	System.out.println(" 您屬於「體重過輕」，需要多運動，均衡飲食，以增加體能，維持健康！ ");
        } else {if (BMI < 24 ) {
	    	System.out.println(" BMI = " + BMI ); // 小於 24 為 Normal 正常
	    	System.out.println(" 您屬於「健康體重」，繼續保持唷 ~ ！");
		} else { if (BMI < 27) {
	    	System.out.println(" BMI = " + BMI ); // 小於 27 為 Overweight 過重
	    	System.out.println("您屬於「體重過重」了 ! 需要小心囉，趕快力行「健康體重管理」~  ");
		} else { if (BMI  >= 27) {
			System.out.println(" BMI = " + BMI ); // 大於等於 27 為 Obese 肥胖
			System.out.println("您屬於肥胖 ! ! ! 需要立刻力行「健康體重管理」囉 ！ ! ");
		} else {
		}
		}
		}
		}
	      	sc.close();
	}
}
