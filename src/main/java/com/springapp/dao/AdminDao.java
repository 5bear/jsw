package com.springapp.dao;

import com.springapp.entity.Admin;
import org.springframework.stereotype.Repository;

/**
 * Created by 11369 on 2016/8/12.
 */
@Repository
public class AdminDao extends BaseDao {
    public Admin getByAdmin(String admin){
        return this.find("from Admin where account=?",Admin.class,new Object[]{admin});
    }
}
