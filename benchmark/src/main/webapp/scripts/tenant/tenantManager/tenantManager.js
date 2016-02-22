$(function(){
    var flag =	$("#flag").val();
    switch(flag) {
	    case "1" : $("#tenantManager").addClass("active");break;
	    case "2" : $("#activeManager").addClass("active");break;
	    case "3":break;
	    default:break;
    }
     $("#tenant").addClass("open");
     $("#tenant").addClass("active");
     
     $(".tenantBussiness").click(function(){
    	 $("#tenantManager a").attr("href",_path+"/pmd/tenantManager/1/"+$("#tenantId").val());
    	 $("#activeManager a").attr("href",_path+"/pmd/tenantManager/2/"+$("#tenantId").val());
     });
     
	//弹出层
	$("#changeTenant").click(function(){
		$("#myModal").modal();
		$("body").css('padding-right','0px');
	});
    $("#pre").click(function(){
       $(".mySlide").each(function(i,e){
    	  if($(this).hasClass("selected")){
    		  var that =this;
    		  setTimeout(function(){
    			  var id = $(that).attr("id");
        		  var index = parseInt(id.charAt(id.length-1));
        		  clearBg("mySlide");
        		  var np =index-1;
        		  if(index==1) {
        			  np=4;
        		  }
        		  tableHover(np);
        		  $("#slide-"+np).addClass("selected");
        			var configdata={tenant_fk: $("#tenantId").val(),showId:30};
        	 		switch(flag) {
	             		case "1" :  $('#phase_activity').load( _path+"/report/"+$(".mySlide.selected").find("input").val()+"/trend/chart",configdata); break;
	             		case "2" :  $('#activeRptChart').load( _path+"/report/"+$(".mySlide.selected").find("input").val()+"/chart",configdata); break;
	             		case "3" :break;
	             		default:break;
             		}
        		  return false; 
    		  },600);
    	  } 
       });
    });
    // 循环轮播到下一个项目
    $("#next").click(function(){
       $(".mySlide").each(function(i,e){
    	   var that =this;
     	  if($(this).hasClass("selected")){
     		  setTimeout(function(){
     		  var id = $(that).attr("id");
     		  var index = parseInt(id.charAt(id.length-1));
     		  clearBg("mySlide");
     		  var np =index+1;
     		  if(index==4) {
     			  np=1;
     		  }
     		  $("#slide-"+np).addClass("selected");
     		 tableHover(np);
     		var configdata={tenant_fk: $("#tenantId").val(),showId:30};
     		switch(flag) {
	     		case "1" :  $('#phase_activity').load( _path+"/report/"+$(".mySlide.selected").find("input").val()+"/trend/chart",configdata); break;
	     		case "2" :  $('#activeRptChart').load( _path+"/report/"+$(".mySlide.selected").find("input").val()+"/chart",configdata); break;
	     		case "3" :break;
	     		default:break;
     		}
     		  return false; },600);
     	  } 
        });
    });
    //清除背景颜色
    function clearBg(cls){
    	$("."+cls).each(function(){$(this).removeClass("selected");$(this).find("td").removeClass("activeBg");});
    }
    $("#tp .mySlide").click(function(){
    	clearBg("mySlide");
       $(this).addClass("selected");
       var id = $(this).attr("id");
		  var index = parseInt(id.charAt(id.length-1));
       tableHover(index);
     	var configdata={tenant_fk: $("#tenantId").val(),showId:30};
    	switch(flag) {
 		case "1" :  $('#phase_activity').load( _path+"/report/"+$(".mySlide.selected").find("input").val()+"/trend/chart",configdata); break;
 		case "2" :  $('#activeRptChart').load( _path+"/report/"+$(".mySlide.selected").find("input").val()+"/chart",configdata); break;
 		case "3" :break;
 		default:break;
		}
     });
    
    $("#myModal .myBg").click(function(){
    	clearBg("myBg");
    	$(this).find("td").addClass("activeBg");
    });
    
    $(".myBg").each(function(i,e){
    	if($(this).find(".tId").html()==$("#tenantId").val()) {
    		$(this).find("td").addClass("activeBg");
    	};
    });
    //重新选择租户
    $("#confireTenant").click(function(){
    	$("#tenantId").val($(".activeBg.tId").html());
    	$("#tenantName").html($(".activeBg.tName").html());
    	getAccumulationSum();
    	var configdata={tenant_fk: $("#tenantId").val(),showId:30};
     	switch(flag) {
	 		case "1" :  
	 			$('#phase_activity').load( _path+"/report/"+$(".mySlide.selected").find("input").val()+"/trend/chart",configdata); 
	 			
	 			$("#cfpSum a").attr("href", _path + "/report/cfp/tenant/" + $("#tenantId").val() + "/summary");
	 		    $("#padSum a").attr("href", _path + "/report/pad/tenant/" + $("#tenantId").val() + "/summary");
	 		    $("#productSum a").attr("href", _path + "/report/product/tenant/" + $("#tenantId").val() + "/summary");
	 		    $("#investorSum a").attr("href", _path + "/report/investor/tenant/" + $("#tenantId").val() + "/summary");
	 			break;
	 		case "2" :  
	 			$('#activeRptChart').load( _path+"/report/"+$(".mySlide.selected").find("input").val()+"/chart",configdata);
	 			
	 		    $("#padLoginSum a").attr("href", _path+"/report/pad/tenant_pad_loginSize_sum_view/" + $("#tenantId").val());
	 		    $("#max_pad_duration_range_all a").attr("href", _path+"/report/pad/tenant_pad_duration_sum_view/"+$("#tenantId").val());
	 		    $("#max_pad_frequency_range_all a").attr("href", _path + "/report/pad/tenant_pad_frequency_sum_view/" + $("#tenantId").val());
	 		   	$(".trade a").attr("href", _path + "/report/trade/tenant_summary_view/" + $("#tenantId").val());
	 			$("#cfp_active_size_all a").attr("href", _path + "/report/cfp/tenant/active/" + $("#tenantId").val() + "/summary");
	 			break;
	 		case "3" :break;
	 		default  :break;
		}
	    
	    $("#tenantManager a").attr("href",_path+"/pmd/tenantManager/1/"+$("#tenantId").val());
	    $("#activeManager a").attr("href",_path+"/pmd/tenantManager/2/"+$("#tenantId").val());
    });

    getAccumulationSum();
    tableHover(2);
    function getAccumulationSum(){
        //获取累计数据
        $.ajax({
            type : 'POST',
            contentType : 'application/json;charset=utf-8',
            url : _path+"/pmd/tenantManager/accumulation/"+flag,
            data :JSON.stringify({id:$("#tenantId").val()}),
            dataType : 'json',
            success : function(data) {
            	console.log(data);
            	if(flag=='1') {
            		   $("#cfpSum a").html(data.cfpSum);
                       $("#slide-1 a").html(data.cfpSum30);
                       $("#productSum a").html(data.productSum);
                       $("#slide-2 a").html(data.padSum30);
                       $("#padSum a").html(data.padSum);
                       $("#slide-3 a").html(data.productSum30);
                       $("#investorSum a").html(data.investorSum);
                       $("#slide-4 a").html(data.investorSum30);
            	} else if(flag =='2') {
            		  $("#padLoginSum a").html(data.padLoginSum);
            		  $("#slide-1 a").html(data.padLoginSum30);
                      $("#max_pad_duration_range_all a").html(data.max_pad_duration_range_all);
                      $("#slide-2 a").html(data.max_pad_duration_range_30);
                      $("#max_pad_frequency_range_all a").html(data.max_pad_frequency_range_all);
                      $("#slide-3 a").html(data.max_pad_frequency_range_30);
                      $("#cfp_active_size_all a").html(data.cfp_active_size_all);
                      $("#slide-4 a").html(data.cfp_active_size_30);
                      $("#tenant_trade_amount a").html(data.tenant_trade_amount);
                      $("#tenant_total_order a").html(data.tenant_total_order);
                      $("#tenant_pay_order a").html(data.tenant_pay_order);
                      $("#tenant_pay_ratio a").html(data.tenant_pay_ratio);
            	}
            },
            error : function(data) {
            }
        });
    }
    
    
    function tableHover(num) {
    	$(".tab-selected").find("th").eq(num - 1).addClass("th-hover");
    	$(".tab-selected").find("th").eq(num - 1).siblings().removeClass("th-hover");
    	$(".tab-selected").find("td").eq(num - 1).addClass("td-hover");
    	$(".tab-selected").find("td").eq(num - 1).siblings().removeClass("td-hover");
    }
    
    //加载30天理财师增长chart || 30天pad使用时长
	var url = _path + "/report/pad/trend/chart";
	var url1 = _path +  "/report/pad/duration/chart";
	var configdata={tenant_fk: $("#tenantId").val(),showId:30};
	switch(flag) {
		case "1" : $('#phase_activity').load(url,configdata);break;
		case "2":  $('#activeRptChart').load(url1,configdata);break;
		case "3": break;
		default:$('#phase_activity').load(url,configdata);break;
	}
});