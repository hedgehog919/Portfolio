package Fileconversion;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;

public class topic {
	
		public static void main(String[] args) {
			try {
				URL url=new URL("https://data.kcg.gov.tw/dataset/ae326992-4179-431b-aa2a-d1660a447f7c/resource/79a289ac-53f9-4eac-80b0-768c43feb3d1/download/109--3.csv");
				InputStream in = url.openStream();
				InputStreamReader inr=new InputStreamReader(in);
				BufferedReader br=new BufferedReader(inr);
				String line="";
				while((line=br.readLine())!=null) {
					System.out.println(line);
				}
			} catch (MalformedURLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}		
		

}


