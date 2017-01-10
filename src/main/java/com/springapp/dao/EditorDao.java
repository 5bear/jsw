package com.springapp.dao;

import com.springapp.entity.Editor;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by 11369 on 2016/10/25.
 */
@Repository
public class EditorDao extends BaseDao {
    public Editor getByNo(String no){
        return this.find("from Editor where no='"+no+"'",Editor.class);
    }
    public List<Editor> getEditor(){
        return this.findAll("from Editor",Editor.class);
    }
    public List<Editor>getEditorPageList(int pn){
        return this.findByPage("from Editor ",Editor.class,(pn-1)*PAGELENGTH,PAGELENGTH);
    }
}
