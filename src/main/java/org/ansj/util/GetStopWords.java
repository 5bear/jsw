package org.ansj.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GetStopWords {
	
	@SuppressWarnings("rawtypes")
	public Map<String, List> getStopWordList(String path_chinese) throws Exception {
        Map<String, List> map = new HashMap<String, List>();
        GetStopWords getStopWord = new GetStopWords();
        List<String> list_c = getStopWord.readStopWord(path_chinese);
        map.put(MacroDef.STOP_CHINESE, list_c);
 
        return map;
    }
	public List<String> readStopWord(String path) throws Exception {
        List<String> list = new ArrayList<String>();
        File file = new File(path);
        InputStreamReader isr = new InputStreamReader(new FileInputStream(file), MacroDef.ENCODING);
        BufferedReader bf = new BufferedReader(isr);
        String stopword = null;
        while ((stopword = bf.readLine()) != null) {
            stopword = stopword.trim();
            list.add(stopword);
        }
        bf.close();
        return list;
    }
	//测试程序
	@SuppressWarnings("rawtypes")
	public static void main(String[] args) throws Exception {
        GetStopWords getStopWordList = new GetStopWords();
        Map<String, List> map = getStopWordList.getStopWordList("C:\\Users\\JasonWang\\Desktop\\近义词处理程序\\StopWordList.txt");
        @SuppressWarnings("unchecked")
		List<String> list = map.get(MacroDef.STOP_CHINESE);
 
        for (String str : list) {
            System.out.println(str);
        }
    }
}

