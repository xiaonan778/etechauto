<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources2.jsp" />
    <link rel="stylesheet" href="${path }/resources/datatables/css/dataTables.bootstrap.min.css" />
    <script src="${path }/resources/datatables/js/jquery.dataTables.min.js"></script>
    <script src="${path }/resources/datatables/js/dataTables.bootstrap.min.js"></script>
    <script src="${path }/resources/datatables/js/default.js"></script>  
    
    <script src="${path }/scripts/sys/dic_son_list.js"></script>
    <script>
     	  function operation( data, type, row ) {
             	var editor = "<a class=\"edit\" href=\"javascript:void(0);\" data-id='"+row.id+"'><span>编辑</span></a>";
           	    return editor;
           }
     
     		$(document).off( "click", ".edit").on("click", ".edit", function(){
     		    var id = $(this).attr("data-id");
        		window.location = _path + "/dic/" + id + "/sonedit";
       		});    
     	    
     		 $(function(){
                 $("#sys_config").parent().addClass("active");
             });
    </script>
    
    <style>
        .action-bar {
          margin: 5px 0px;
        }
    </style>
</head>
  
<body>

    <jsp:include page="../common/header2.jsp" />

    <!-- Main Container start -->
    <div class="dashboard-container">

        <div class="container">

            <jsp:include page="../common/menu2.jsp" />

            <!-- Dashboard Wrapper Start -->
            <div class="dashboard-wrapper"> 
                    <input type="hidden" value="${sysdata.id}" id="father"/>
                    <div class="panel panel-default">
		                <div class="panel-heading panel-title">
		                    <div class="row">
		                        <div class="col-xs-3 text-left"><a  class="btn btn-primary" type="button" href="${path}/dic/list" >返回</a></div>
		                        <div class="col-xs-6 text-center">数据字典&nbsp${sysdata.code}&nbsp;-&nbsp;${sysdata.name}</div>
		                        <div class="col-xs-3 text-right"><button type="button" class="btn btn-large btn-primary add-data" >新增数据</button> </div>
		                    </div>
		                 </div>
		            </div>
		          
		            <div class="row">
		                <div class="col-xs-12" style="margin-top: 10px;">
	                        <table id="tp" class="table table-striped table-hover table-bordered table-responsive" style="width:100%;">      
	                           <thead>
	                               <tr>
										<th>ID</th>
										<th>名称</th>
										<th>对应</th>
										<th>最小值</th>
										<th>最大值</th>
										<th>规则</th>
										<th>排序</th>
										<th>状态</th>
										<th>操作</th>
									</tr>
	                           </thead>          
	                        </table>
		                </div>
		            </div><!--/row-->			
                    
                </div>
                <!-- Dashboard Wrapper End -->

            <jsp:include page="../common/footer2.jsp" />

        </div>
    </div>
    <!-- Main Container end -->

</body>
</html>