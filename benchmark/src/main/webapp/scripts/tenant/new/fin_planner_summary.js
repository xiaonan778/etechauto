
$(function() {
	var url = _path + "/report/cfp/trend/chart?tenant_fk=" + $("#tenantId").val();
    $('#finPlanner_chart').load(url,function(){
    	$("#finPlanner_report").prev().show();
    });
    
});
