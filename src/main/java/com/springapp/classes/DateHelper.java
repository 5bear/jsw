package com.springapp.classes;

import java.util.Calendar;
import java.util.Date;

/**
 * Created by anc on 15/3/26.
 */
public class DateHelper {

    /**
     * 计算天数差
     *
     * @param fromDate
     * @param toDate
     * @return
     */
    public static int getIntervalDays(Date fromDate, Date toDate) {
        if (null == fromDate || null == toDate) {
            return -1;
        }
        return (int) ((fromDate.getTime() - toDate.getTime()) / (24 * 60 * 60 * 1000));
    }

    public static int getCurrentYear() {
        Calendar calendar = Calendar.getInstance();
        return calendar.get(Calendar.YEAR);
    }
}
