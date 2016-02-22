$(function() {
	
	// 近30天新增投资人
	var url = _path+"/report/investor/trend/chart";
    $('#investor_trend_chart').load(url,function(){
    	$("#investor_trend_report").prev().show();
    }); 
    
    // 近30天投资人交易
    var url2 = _path + "/report/investor/trade/chart";
    $('#investor_trade_chart').load(url2);
    var url21 = _path + "/report/investor/trade/subitem";
    $('#investor_trade_subitem').load(url21);
    
    $("#goback").click(function(){
    	 window.history.back();
    });
});