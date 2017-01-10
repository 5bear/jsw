package org.ansj.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.ansj.domain.Result;
import org.ansj.domain.Term;
import org.ansj.splitWord.analysis.ToAnalysis;

public class ExtractWord {
	@SuppressWarnings("rawtypes")
	public List<String> extracWord(String article, Map<String, List> map) throws Exception {
        List<String> list = new ArrayList<String>();
        @SuppressWarnings("unchecked")
		List<String> list_c = map.get(MacroDef.STOP_CHINESE);
        Result parse = ToAnalysis.parse(article);
        for (Term term : parse) {
            boolean flag = true;
            String str = term.getName().trim();
            for (String str_c : list_c) {
                if (str_c.equals(str))
                    flag = false;
            }
            if (str == "")
                flag = false;
            if (flag)
                list.add(str);
        }
        return list;
    }
	@SuppressWarnings("rawtypes")
	public static void main(String[] args) throws Exception {
        ExtractWord extractWord = new ExtractWord();
        GetStopWords getStopWord = new GetStopWords();
        Map<String, List> map = getStopWord.getStopWordList("C:\\Users\\JasonWang\\Desktop\\近义词处理程序\\StopWordList.txt");
        String test1="Maven是基于项目对象模型(POM)，可以通过一小段描述信息来管理项目的构建，报告和文档的软件项目管理工具。Maven除了以程序构建能力为特色之外，还提供高级项目管理工具。";
        String test2="教育学相关的课件";
        List<String> list = extractWord.extracWord(test2,map);
        for (String str : list) {
            System.out.println(str);
        }
    }
}
