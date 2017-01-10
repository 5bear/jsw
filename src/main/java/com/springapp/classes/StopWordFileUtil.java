package com.springapp.classes;

import java.io.*;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by 11369 on 2016/8/18.
 */
public class StopWordFileUtil {
    //停用词词表
    public static final String stopWordTable = "D://StopWordTable.txt";
    public static Set<String>StopWorldSet() throws IOException {
        //读入停用词文件
            BufferedReader StopWordFileBr = new BufferedReader(new InputStreamReader(new FileInputStream(new File(stopWordTable)),"unicode"));
        //用来存放停用词的集合
        Set<String> stopWordSet = new HashSet<String>();
        //初如化停用词集
        String stopWord = null;
        for(; (stopWord = StopWordFileBr.readLine()) != null;){
            stopWordSet.add(stopWord);
        }
        return stopWordSet;
    }
}
