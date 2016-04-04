package com.etech.benchmark.data.report.model;


/**
 * 报表要素
 * @author xiongfeng
 *
 */
public class ChartFactor {
    /**
     * 图表类型
     */
    private String chartType; 
    
    /**
     * X轴
     */
    private String xAxis; 
    
    /**
     * 单位
     */
    private String xAxisUnit; 
    
    /**
     * Y轴
     */
    private String yAxis; 
    
    /**
     * 单位
     */
    private String yAxisUnit; 
    
    /**
     * Z轴
     */
    private String zAxis;
    
    /**
     * 单位
     */
    private String zAxisUnit;

    public String getChartType() {
        return chartType;
    }

    public void setChartType(String chartType) {
        this.chartType = chartType;
    }

    public String getxAxis() {
        return xAxis;
    }

    public void setxAxis(String xAxis) {
        this.xAxis = xAxis;
    }

    public String getxAxisUnit() {
        return xAxisUnit;
    }

    public void setxAxisUnit(String xAxisUnit) {
        this.xAxisUnit = xAxisUnit;
    }

    public String getyAxis() {
        return yAxis;
    }

    public void setyAxis(String yAxis) {
        this.yAxis = yAxis;
    }

    public String getyAxisUnit() {
        return yAxisUnit;
    }

    public void setyAxisUnit(String yAxisUnit) {
        this.yAxisUnit = yAxisUnit;
    }

    public String getzAxis() {
        return zAxis;
    }

    public void setzAxis(String zAxis) {
        this.zAxis = zAxis;
    }

    public String getzAxisUnit() {
        return zAxisUnit;
    }

    public void setzAxisUnit(String zAxisUnit) {
        this.zAxisUnit = zAxisUnit;
    } 
}
