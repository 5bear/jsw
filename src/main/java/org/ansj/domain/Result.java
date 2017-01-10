package org.ansj.domain;

import java.util.Iterator;
import java.util.List;

import com.springapp.classes.DicUtils;
import org.ansj.library.UserDefineLibrary;
import org.ansj.recognition.Recognition;
import org.ansj.splitWord.analysis.ToAnalysis;
import org.nlpcn.commons.lang.util.StringUtil;

/**
 * 分词结果的一个封装
 * 
 * @author Ansj
 *
 */
public class Result implements Iterable<Term> {

	private List<Term> terms = null;

	public Result(List<Term> terms) {
		this.terms = terms;
	}

	public List<Term> getTerms() {
		return terms;
	}

	public void setTerms(List<Term> terms) {
		this.terms = terms;
	}

	@Override
	public Iterator<Term> iterator() {
		return terms.iterator();
	}

	public int size() {
		return terms.size();
	}

	public Term get(int index) {
		return terms.get(index);
	}

	/**
	 * 调用一个发现引擎
	 * 
	 * @return
	 */
	public Result recognition(Recognition re) {
		re.recognition(this);
		return this;
	}

	@Override
	public String toString() {
		return toString(",");
	}

	
	public String toString(String split) {
		return StringUtil.joiner(this.terms, split);
	}

	/**
	 * 返回没有词性的切分结果
	 * @return
	 */
	public String toStringWithOutNature(){
		return  toStringWithOutNature(",");
	}
	
	/**
	 * 返回没有词性的切分结果
	 * @return
	 */
	public String toStringWithOutNature(String split) {
		
		StringBuilder sb = new StringBuilder(terms.get(0).getRealName()) ;
		
		for (int i = 1; i < terms.size(); i++) {
			sb.append(split);
			sb.append(terms.get(i).getRealName()) ;
		}
		
		return sb.toString();
	}
	public static void main(String[] args){
		List<String> dic = DicUtils.getDicList();
		for (int i = 0; i < dic.size(); i++) {
			UserDefineLibrary.insertWord(dic.get(i), DicUtils.USER_DEFINE, 1000);
		}
		Result parse1 = ToAnalysis.parse("谷歌公司一家技术型二语学习互联网公司。");
		String[] result=parse1.toStringWithOutNature().split(",");
		for (int i = 0; i < result.length; i++) {
			System.out.println(result[i]);
		}
	}

}
