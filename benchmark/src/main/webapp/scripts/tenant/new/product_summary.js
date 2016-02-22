$(function() {
	// 近30天新发布理财产品变化
	var url1 = _path + "/report/product/trend/chart?tenant_fk=" + $("#tenantId").val();
    $('#product_trend_chart').load(url1,function(){
    	$("#product_trend_report").prev().show();
    });
    
    // 近30天理财产品分类分布图
    var url2 = _path + "/report/product/publish_category/chart?tenant_fk=" + $("#tenantId").val();
    $('#product_publish_category_chart').load(url2);
    var url21 = _path + "/report/product/publish_category/subitem?tenant_fk=" + $("#tenantId").val();
    $('#product_publish_category_subitem').load(url21);
    
    // 近30天产品年化利率分布图
    var url3 = _path + "/report/product/category_ratio/chart?tenant_fk=" + $("#tenantId").val();
    $('#product_category_ratio_chart').load(url3);
    var url31 = _path + "/report/product/category_ratio/subitem?tenant_fk=" + $("#tenantId").val();
    $('#product_category_ratio_subitem').load(url31);
    
    // 近30天产品是否预约情况分布图
    var url5 = _path + "/report/product/appointment/chart?tenant_fk=" + $("#tenantId").val();
    $('#product_appointment_chart').load(url5);
    var url51 = _path + "/report/product/appointment/subitem?tenant_fk=" + $("#tenantId").val();
    $('#product_appointment_subitem').load(url51);
    
});


