$(function() {
	
	// 新增激活Pad变化
	var url = _path+"/report/pad/trend/chart";
    $('#pad_trend_chart').load(url,function(){
    	$("#pad_trend_report").prev().show();
    });
    
    // 租户Pad激活数量分布
    var url2 = _path + "/report/pad/time_org_trend_chart";
    $('#pad_org_trend_chart').load(url2);
    var url21 = _path + "/report/pad/time_org_trend/subitem";
    $('#pad_org_trend_subitem').load(url21);
    
    $("#goback").click(function(){
   	 	window.history.back();
    });
    
});