$(function() {
	// 近30天新发布理财产品变化
	var url1 = _path + "/report/product/trend/chart";
    $('#product_trend_chart').load(url1,function(){
    	$("#product_trend_report").prev().show();
    });
    
    // 近30天理财产品交易分布图
    var url2 = _path + "/report/product/trade_category/chart";
    $('#product_trade_category_chart').load(url2);
    var url21 = _path + "/report/product/trade_category/subitem";
    $('#product_trade_category_subitem').load(url21);
    
    // 近30天产品年化利率分布图
    var url3 = _path + "/report/product/category_ratio/chart";
    $('#product_category_ratio_chart').load(url3);
    var url31 = _path + "/report/product/category_ratio/subitem";
    $('#product_category_ratio_subitem').load(url31);
    
    // 近30天产品是否预约情况分布图
    var url5 = _path + "/report/product/appointment/chart";
    $('#product_appointment_chart').load(url5);
    var url51 = _path + "/report/product/appointment/subitem";
    $('#product_appointment_subitem').load(url51);
    
    // 近30天发行商发布产品分布图
    var url6 = _path + "/report/product/catetenant/chart";
    $('#product_catetenant_chart').load(url6);
	var url61 = _path + "/report/product/product_caterenant_subitem";
    $('#product_catetenant_subitem').load(url61);
    
    $("#goback").click(function(){
    	 window.history.back();
    });
});


