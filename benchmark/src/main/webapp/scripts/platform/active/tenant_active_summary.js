
$(function() {
	var url = _path + "/report/tenant/active/chart";
    $('#tenant_active_chart').load(url,function(){
    	$("#tenant_active_report").prev().show();
    });
    
    $("#goback").click(function(){
    	 window.history.back();
    });
});