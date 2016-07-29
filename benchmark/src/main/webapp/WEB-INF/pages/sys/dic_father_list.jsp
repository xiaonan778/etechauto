<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ page import="org.apache.shiro.SecurityUtils" %>
<%@ page import="org.apache.shiro.subject.Subject"%>
<%
  Subject subject = SecurityUtils.getSubject();
%>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources2.jsp" />
    <style>
        .operation-column a {
          padding-right: 10px;
        }
        
        .panel-body .row {
          margin: 0px;
        }
        
        .action-bar {
          margin: 5px 0px;
        }
    </style>
    <link rel="stylesheet" href="${path }/resources/datatables/css/dataTables.bootstrap.min.css" />
    <script src="${path }/resources/datatables/js/jquery.dataTables.min.js"></script>
    <script src="${path }/resources/datatables/js/dataTables.bootstrap.min.js"></script>
    <script src="${path }/resources/datatables/js/default.js"></script>  
     <script>
     	  function operation( data, type, row ) {
             	var editor = "";
            <% 
           	 if(subject.isPermittedAll("modify:dictionary")) {
            %>
            	editor = "<a class=\"sonlist\" href=\"javascript:void(0);\" data-id='"+row.id+"' ><span>关联数据</span></a>";
            <%
             }
            %>
             return editor;
           }
     
     		$(document).off( "click", ".sonlist").on("click", ".sonlist", function(){
        	var id = $(this).attr("data-id");
        		window.location = _path + "/dic/" + id + "/sonlist";
       		});
     		
     		 $(function(){
     	        $("#sys_config").parent().addClass("active");
     	    });
    </script>  
    <script src="${path }/scripts/sys/dic_father_list.js"></script>
</head>
  
<body>

    <jsp:include page="../common/header2.jsp" />

    <!-- Main Container start -->
    <div class="dashboard-container">

        <div class="container">

            <jsp:include page="../common/menu2.jsp" />
            
            <!-- Dashboard Wrapper Start -->
            <div class="dashboard-wrapper">
                    
                    <div class="panel panel-default">
                        <div class="panel-heading panel-title">
                             <div class="row">
                                 <div class="col-xs-12 text-center">数据字典</div>
                             </div>
                        </div>
                    </div>
                    
		            <div class="row">
		                <div class="col-xs-12" style="margin-top: 10px;">
	                        <table id="tp" class="table table-striped table-hover table-bordered table-responsive" style="width:100%;">      
	                           <thead>
	                               <tr>
										<th>ID</th>
										<th>Code</th>
										<th>名称</th>
										<th>说明</th>
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