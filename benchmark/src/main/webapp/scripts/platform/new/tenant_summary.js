
$(function() {
	// 近30天租户Pad激活趋势分布图
	var url = _path + "/report/tenant/trend/chart";
    $('#tenant_trend_chart').load(url,function(){
    	$("#tenant_trend_report").prev().show();
    });
    
    // 租户交易金额 分布图
    var url2 = _path + "/report/tenant/trade/chart";
    $('#tenant_trade_chart').load(url2);
    var url21 = _path + "/report/tenant/trade/subitem";
    $('#tenant_trade_subitem').load(url21);
    
    // 租户交易产品情况
    var url = _path + "/report/tenant/prodtrade/chart";
    $('#tenant_prodtrade_chart').load(url);
    var url = _path + "/report/tenant/prodtrade/subitem";
    $('#tenant_prodtrade_subitem').load(url);
    
    $("#goback").click(function(){
    	 window.history.back();
    });
});