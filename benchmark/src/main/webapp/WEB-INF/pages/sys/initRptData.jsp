<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources.jsp" />
    <link rel="stylesheet" href="${path }/css/report/load.css" />
    <script src="${path}/scripts/common/jquery.serializeJson.js"></script>
    <script type="text/javascript">
	    $(function(){
	        $("#sys_tenant_init").addClass("active");
	        $("#sys").addClass("open");
	        $("#sys").addClass("active");
	        
	         $('.form_date').datetimepicker({
		    	language : 'zh-CN',
				format : 'yyyy-mm-dd',
				autoclose : true,
				todayBtn : true,
				todayHighlight : 1,
				startView : 2,
				minView : 2
    		});
    		$(".dateCreate").each(function(i,e){
	    		var dateCreate = new Date($(this).val());
	    		var dateString = customPlugin.getDateString(dateCreate);
	    		$(this).next().find(".dateSelect").val(dateString);
    		});
    		
    		$(".dateCreate2").each(function(i,e){
	    		var dateCreate = new Date($(this).val());
	    		var dateString = customPlugin.getDateString(dateCreate);
	    		$(this).next().find(".dateSelect2").val(dateString);
    		});
    		
    	//初始化租户报表	
    	$(".init-report").click(function(){
    	   var $obj= $(this).parent();
    	   var id  = $(this).parent().parent().find("td:first").html(); 
    	   var date = $(this).parent().parent().find(".dateSelect").val();
    	   var dateEnd = $(this).parent().parent().find(".dateSelect2").val();
    	   var that =this;
    	   var loadingStr =   '<div class="sk-spinner sk-spinner-fading-circle">'+
						      '<div class="sk-circle1 sk-circle"></div>'+
						      '<div class="sk-circle2 sk-circle"></div>'+
						      '<div class="sk-circle3 sk-circle"></div>'+
						      '<div class="sk-circle4 sk-circle"></div>'+
						      '<div class="sk-circle5 sk-circle"></div>'+
						      '<div class="sk-circle6 sk-circle"></div>'+
						      '<div class="sk-circle7 sk-circle"></div>'+
						      '<div class="sk-circle8 sk-circle"></div>'+
						      '<div class="sk-circle9 sk-circle"></div>'+
						      '<div class="sk-circle10 sk-circle"></div>'+
						      '<div class="sk-circle11 sk-circle"></div>'+
						      '<div class="sk-circle12 sk-circle"></div>'+
						    '</div>';
		   $(this).children().html("正在初始化");
			$(this).append(loadingStr);
			$(this).attr("disabled","disabled");
    		var configdata = {id:id,date:date,dateEnd:dateEnd};
    		  $.ajax({
                  type : 'POST',
                  contentType : 'application/json;charset=utf-8',
                  url : _path+ "/init/data",
                  data : JSON.stringify(configdata),
                  dataType : 'json',
                  success : function(data) {
                  $(that).attr("disabled",false);
                  $(that).find(".sk-spinner").remove();
                  $(that).children().html("初始化");
                      
                  },
                  error : function(data) {
                  }
              });
           });	
           
           //初始化金宝租户
           
           $(".init-jinbao").click(function(){
    	   //var isPeriod= $(this).parent().parent().find(".ace").is(":checked");
    	   var $obj= $(this).parent();
    	   var id  = $(this).parent().parent().find("td:first").html(); 
    	   var date = $(this).parent().parent().find(".dateSelect").val();
    	   var dateEnd = $(this).parent().parent().find(".dateSelect2").val();
    	   var that =this;
    	   var loadingStr =   '<div class="sk-spinner sk-spinner-fading-circle">'+
						      '<div class="sk-circle1 sk-circle"></div>'+
						      '<div class="sk-circle2 sk-circle"></div>'+
						      '<div class="sk-circle3 sk-circle"></div>'+
						      '<div class="sk-circle4 sk-circle"></div>'+
						      '<div class="sk-circle5 sk-circle"></div>'+
						      '<div class="sk-circle6 sk-circle"></div>'+
						      '<div class="sk-circle7 sk-circle"></div>'+
						      '<div class="sk-circle8 sk-circle"></div>'+
						      '<div class="sk-circle9 sk-circle"></div>'+
						      '<div class="sk-circle10 sk-circle"></div>'+
						      '<div class="sk-circle11 sk-circle"></div>'+
						      '<div class="sk-circle12 sk-circle"></div>'+
						    '</div>';
		   $(this).children().html("正在初始化");
			$(this).append(loadingStr);
			$(this).attr("disabled","disabled");
    		var configdata = {id:id,date:date,dateEnd:dateEnd};
    		  $.ajax({
                  type : 'POST',
                  contentType : 'application/json;charset=utf-8',
                  url : _path+ "/init/jinbaoData",
                  data : JSON.stringify(configdata),
                  dataType : 'json',
                  success : function(data) {
                  $(that).attr("disabled",false);
                  $(that).find(".sk-spinner").remove();
                  $(that).children().html("初始化");
                      
                  },
                  error : function(data) {
                  }
              });
           });	
           
           
	   });
    </script>
</head>
  
<body class="navbar-fixed">
    <jsp:include page="../common/header.jsp" />
    <div class="main-container">
        <div class="main-container-inner">  
            <jsp:include page="../common/menu.jsp" />
            
            <div class="main-content" id="mainContent">
                <div class="breadcrumbs breadcrumbs-fixed" id="breadcrumbs">
            
                    <ul class="breadcrumb">
                        <li>
                            <i class="icon-home home-icon"></i>
                            <a href="${path}/">首页</a>
                        </li>
                        <li class="active">系统配置</li>
                        <li>报表初始化</li>
                    </ul><!-- .breadcrumb -->
                </div>
                <div class="page-content" style="padding-top:40px;">
                    <div class="page-header">
							<h1>
								手动初始化报表数据
								<small>
									<i class="icon-double-angle-right"></i>
									当天 或是 当天到昨天 的数据
								</small>
							</h1>
						</div>
						
						<div class="row">
									<div class="col-xs-12">
										<div class="table-responsive">
											<table id="sample-table-1" class="table table-striped table-bordered table-hover">
												<thead>
													<tr>
													    <th hidden>租户id</th>
														<th class="center">租户名</th>
														<th class="center">
															<i class="icon-time bigger-110 hidden-480"></i>
															开始日期
														</th>
														<th class="center">
															<i class="icon-time bigger-110 hidden-480"></i>
															结束日期
														</th>
														<th class="center">操作</th>
													</tr>
												</thead>

												<tbody>
												  <c:forEach items="${list}" var="z" varStatus="s">
													<tr>
													    <td hidden>${z.id}</td>
														<td class="center">
															<h5>${z.name}</h5>
														</td>
														<td class="center" align=center>
															<div style="width:200px;height:34px;margin-left:auto; margin-right:auto;">
																<input type="hidden" value="${z.dateOfCreate}" name="dateCreate" class="dateCreate" id="dateCreate"/>
																	<div class="input-group form_date date" data-date-format="yyyy-mm-dd" data-link-field="dtp_input${s.index}">
																		<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span>
																		</span> <input class="form-control dateSelect" type="text" value=""   placeholder="today" readonly>
																	</div>
																	<input type="hidden" id="dtp_input${s.index}" value="" /><br />
															</div>
												
												         </td>
												         
												         <td class="center" align=center>
															<div style="width:200px;height:34px;margin-left:auto; margin-right:auto;">
																<input type="hidden" value="${today}" name="dateCreate2" class="dateCreate2" id="dateCreate2"/>
																	<div class="input-group form_date date" data-date-format="yyyy-mm-dd" data-link-field="dtp_input2${s.index}" >
																		<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span>
																		</span> <input class="form-control dateSelect2" type="text" value=""   placeholder="today" readonly>
																	</div>
																	<input type="hidden" id="dtp_input2${s.index}" value="" /><br />
															</div>
												
												         </td>

														    <td class="center">
																	<button class="btn btn-default btn-success init-jinbao">
																		<i class="icon-ok bigger-120">init金宝</i>
																	</button>
																	<button class="btn btn-default btn-success init-report">
																		<i class="icon-ok bigger-120">init报表</i>
																	</button>
														    </td>
													     </tr>
                                                     </c:forEach>
												</tbody>
											</table>
										</div><!-- /.table-responsive -->
									</div><!-- /span -->
								</div>

                </div><!-- /.page-content -->
            </div><!-- /.main-content -->
        </div>
        
    </div><!-- /.main-container-inner -->
    
    <jsp:include page="../common/footer.jsp" />
</body>
</html>