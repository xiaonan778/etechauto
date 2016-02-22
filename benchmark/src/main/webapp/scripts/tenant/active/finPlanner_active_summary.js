 $(function(){
    var url = _path + "/report/cfp/active/chart?tenant_fk=" + $("#tenantId").val();
    $("#cfp_active_chart").load(url, function(){
        $("#cfp_active_report").prev().show();
    });
    
    var url2 = _path + "/report/cfp/active_detail/chart?tenant_fk=" + $("#tenantId").val();
    $("#cfp_active_detail_chart").load(url2);
    
    
    $("#activeManager").addClass("active");
    $("#tenant").addClass("open");
    $("#tenant").addClass("active");

});