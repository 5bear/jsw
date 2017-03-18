package com.springapp.classes;

/**
 * Created by 11369 on 2016/10/15.
 */
public class SplitWord {
    public static String[] SplitWords(String word){
        if(word==null||word.equals(""))
            return new String[]{""};
        int len=word.length();
        char[]chasr=word.toCharArray();
        int count=0;
        String words="";
        for(int i=2;i<=len;i++){
            for(int y=0;y<=len-i;y++){
                StringBuilder sb=new StringBuilder();
                for(int z=y;z<y+i;z++){
                    sb.append(chasr[z]);
                }
                if(count==0)
                    words+=sb.toString();
                else
                    words+=","+sb.toString();
                count++;
            }
        }
        return words.split(",");
    }
    public static void main(String[] args){
        String word="你好啊我是bbbbear";
        word = word.replaceAll("[\\pP\\p{Punct}]", ",");
        System.out.print(word);
    }
}
