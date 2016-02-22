$(function() {
	
	// 新增激活Pad变化
	var url = _path+"/report/pad/trend/chart?tenant_fk=" + $("#tenantId").val();
    $('#pad_trend_chart').load(url,function(){
    	$("#pad_trend_report").prev().show();
    });
    
});