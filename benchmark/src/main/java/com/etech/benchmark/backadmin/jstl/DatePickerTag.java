package com.etech.benchmark.backadmin.jstl;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.etech.benchmark.data.sys.model.SysDataDictionary;

public class DatePickerTag extends TagSupport {

	private static final long serialVersionUID = 5502974992835277017L;
	private List<SysDataDictionary> items;
	private String prefix;
	private int flag;
	private boolean show = true; 

	@Override
	public int doEndTag() throws JspException {
		JspWriter out = pageContext.getOut();
		StringBuffer buffer = new StringBuffer();
		buffer.append("<div id=\"" + prefix + "_modal\" class=\"reveal-modal\" style=\"top: -50px;left: 60%;margin-left: -100px;\" >");
		buffer.append("<h4>自选时间段：</h4>");
		buffer.append("<form  id=\"" + prefix + "_datepicker_form\" class=\"form\" >");
		buffer.append("<div class=\"col-md-6\"><div class=\"form-group\"><div class=\"input-group\">");
		buffer.append("<div class=\"input-group-addon\">开始时间</div>");
		buffer.append("<input class=\"form-control datepicker\" type=\"text\" id=\"" + prefix + "_time\" name=\"" + prefix + "_time\" placeholder=\"请选择时间\" > ");
		buffer.append("</div></div></div>");
		buffer.append("<div class=\"col-md-6\"><div class=\"form-group\"><div class=\"input-group\">");
		buffer.append("<div class=\"input-group-addon\">结束时间</div>");
		buffer.append("<input class=\"form-control datepicker\" type=\"text\" id=\"" + prefix + "_timeEnd\" name=\"" + prefix + "_timeEnd\" placeholder=\"请选择时间\" > ");
		buffer.append("</div></div></div>");
		buffer.append("</form>");
		buffer.append("<a class=\"close-reveal-modal\" id=\"" + prefix + "_modalCancel\">&#215;</a>");
		buffer.append("<a href='#' data-reveal-id='" + prefix + "_modal' id=\"" + prefix + "_anytime\" style=\"display: none;\"></a>");
		buffer.append("<div class=\"col-xs-12 text-right\">");
		buffer.append("<input type=\"button\" value=\"确认\" class=\"btn btn-primary\" id=\"" + prefix + "_confirm\" />");
		buffer.append("<input type=\"button\" value=\"取消\" style=\"margin-left:10px;\" class=\"btn btn-info\" id=\"" + prefix + "_cancel\"/>");
		buffer.append("</div></div><br>");
		if (show) {
		    buffer.append("<div class=\"row\"><div class=\"col-xs-12\">");
		} else {
		    buffer.append("<div class=\"row\" style='display: none;'><div class=\"col-xs-12\">");
		}
        buffer.append("<div class=\"input-group pull-right\" style='width:200px;'><div class=\"input-group-addon\">显示时间段:</div>");
        buffer.append("<select class=\"form-control\" id=\"" + prefix + "_showtime\" >");
        for (SysDataDictionary dict : items) {
            buffer.append("<option value=\"" + dict.getMax() + "\" id=\"" + prefix + "_option$" + dict.getMax() + "\" ");
            if (flag == dict.getMax()) {
                buffer.append("selected");
            }
            buffer.append(">" + dict.getName() + "</option>");
        }
        buffer.append("</select><input type='hidden' id='"+ prefix + "_selected' value='" + flag + "' />");
        buffer.append("</div></div></div>");
	
		try {
			out.write(buffer.toString());
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		
		return TagSupport.EVAL_PAGE;
	}

    public void setItems(List<SysDataDictionary> items) {
        this.items = items;
    }

    public void setPrefix(String prefix) {
        this.prefix = prefix;
    }

    public void setFlag(int flag) {
        this.flag = flag;
    }

    public void setShow(boolean show) {
        this.show = show;
    }
    
}
