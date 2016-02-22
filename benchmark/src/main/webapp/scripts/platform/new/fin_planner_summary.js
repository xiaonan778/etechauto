
$(function() {
	var url = _path + "/report/cfp/trend/chart";
    $('#finPlanner_chart').load(url,function(){
    	$("#finPlanner_report").prev().show();
    });
    
    $("#goback").click(function(){
    	 window.history.back();
    });
    
    var url2 = _path + "/report/cfp/cfp_time_org_chart";
    $('#cfp_org_trend_chart').load(url2);
    var url21 = _path + "/report/cfp/cfp_time_org_subitem";
    $('#cfp_org_trend_subitem').load(url21);
});
