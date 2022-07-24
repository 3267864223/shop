package com.jdbc;

import com.beans.PageInfo;

public class PageUtil {

	public static PageInfo getPageInfo(int pageSize,int pageIndex,long rowCount) {
		PageInfo page=new PageInfo();

        page.setPageSize(pageSize==0?10:pageSize);

        page.setRowCount(rowCount);

        if(rowCount%page.getPageSize()==0){
            page.setPageCount(rowCount/page.getPageSize());
        }else{
            page.setPageCount(rowCount/page.getPageSize()+1);
        }

        if(pageIndex>0 && pageIndex<=page.getPageCount()){
            page.setPageIndex(pageIndex);
        }else{
            page.setPageIndex(1);
        }

        page.setBeginRow(page.getPageSize()*(page.getPageIndex()-1));

        page.setHasPre(!(page.getPageIndex()==1));

        page.setHasNext(page.getPageIndex()<page.getPageCount());

        return page;
	}
}
