package com.springapp.classes;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class DicUtils {
	public static String USER_DEFINE="user_define";
	private static String filePath="/library/userlibrary.dic";
	public static List<String> getDicList(){
		 String encoding="UTF-8";
		 List<String> dicList=new ArrayList<String>();
         File file=new File(filePath);
         if(file.isFile() && file.exists()){ //判断文件是否存在
            InputStreamReader read = null;
			try {
				read = new InputStreamReader(new FileInputStream(file),encoding);
				BufferedReader bufferedReader = new BufferedReader(read);
				String lineTxt = null;
	            while((lineTxt = bufferedReader.readLine()) != null){
	                dicList.add(lineTxt);
	            }
			} catch (Exception e) {
				e.printStackTrace();
			} finally{
				try {
					read.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
         }
		 return dicList;
	}
	public static void OutToTxt(String path,String tag){
		FileOutputStream writerStream;
		BufferedWriter writer =null;
		try {
			writerStream = new FileOutputStream(path+filePath,true);
			writer = new BufferedWriter(new OutputStreamWriter(writerStream, "UTF-8"));
			writer.write(tag);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				writer.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}
}
