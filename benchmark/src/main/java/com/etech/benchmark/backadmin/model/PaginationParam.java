package com.etech.benchmark.backadmin.model;


public abstract class PaginationParam extends BaseQueryParam {
    private static final long serialVersionUID = 3980897875704674547L;
    private int pageStart;
    private int pageSize;
    private int pageNow;
    private String sorter;
    private String sortOrder;

    public PaginationParam() {
        this.pageStart = 0;

        this.pageSize = 10;

        this.pageNow = 0;
    }

    public int getPageStart() {
        if (this.pageSize > -1)
            this.pageStart = (this.pageSize * this.pageNow);

        return this.pageStart;
    }

    public void setPageStart(int pageStart) {
        this.pageStart = pageStart;
    }

    public int getPageSize() {
        return this.pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getPageNow() {
        return this.pageNow;
    }

    public void setPageNow(int pageNow) {
        this.pageNow = ((pageNow > 0) ? pageNow - 1 : 0);
    }

    public String getSorter() {
        return this.sorter;
    }

    public void setSorter(String sorter) {
        this.sorter = sorter;
    }

    public String getSortOrder() {
        return this.sortOrder;
    }

    public void setSortOrder(String sortOrder) {
        this.sortOrder = sortOrder;
    }
}