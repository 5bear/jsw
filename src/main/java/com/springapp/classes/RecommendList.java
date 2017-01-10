package com.springapp.classes;

import com.springapp.entity.Account;
import com.springapp.entity.Slide;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by 11369 on 2016/9/7.
 */
public class RecommendList {
    public static String filePath="D://Interest//";
    public static List<Long> readTxtFile(Account account){
        List<Long>returnList=new ArrayList<>();
        try {
            String encoding="utf-8";
            File file=new File(filePath+account.getaId()+".txt");
            if(file.isFile() && file.exists()){ //判断文件是否存在
                InputStreamReader read = new InputStreamReader(
                        new FileInputStream(file),encoding);//考虑到编码格式
                BufferedReader bufferedReader = new BufferedReader(read);
                String lineTxt = null;
                while((lineTxt = bufferedReader.readLine()) != null){
                    returnList.add(Long.parseLong(lineTxt));
                }
                read.close();
            }else{
                System.out.println("找不到指定的文件");
                return null;
            }
        } catch (Exception e) {
            System.out.println("读取文件内容出错");
            e.printStackTrace();
            return null;
        }
        return returnList;
    }
}
