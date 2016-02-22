$(function() {
	// 产品交易趋势图
    var url = _path + "/report/trade/trend/chart";
    $('#trade_trend_chart').load(url);
    var url = _path + "/report/trade/trend/subitem";
    $('#trade_trend_subitem').load(url);
    
    $("#goback").click(function(){
   	 	window.history.back();
    });
    
});