<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources.jsp" />
	
	<link rel="stylesheet" href="${path}/resources/easyui/themes/bootstrap/datagrid.css" />
	<link rel="stylesheet" href="${path}/resources/easyui/themes/bootstrap/pagination.css" />
    <script src="${path}/resources/easyui/js/jquery.easyui.min.js"></script>
    
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
                        <li >信息分类</li>
                        <li ><a href="${path}/info/listall">信息查询</a></li>
                        <li class="active">Excel数据</li>
                    </ul><!-- .breadcrumb -->
                </div>
                <div class="page-content">
                    <div style="height: 40px;"></div>
			            <div class="row">
		                <div class="col-xs-12">
					    <table id="excel_data"  style="width:100%;height: auto;max-height:500px;" title="Excel数据"  data-options="rownumbers:true, singleSelect:true, toolbar: '#tb', onClickRow: onClickRow">
					        <c:forEach items="${dataList }"  var="row"  varStatus="status">
					           <c:if test="${status.index == 0}">
					               <thead>
					               <tr>
	                                   <c:forEach items="${row }" var="cell">
	                                       <th  data-options="field:'${cell.key }',editor:'textbox'">${cell.key }</th>
	                                   </c:forEach>
	                               </tr>
	                               </thead>
					           </c:if>
					        </c:forEach>
					        <tbody>
					        <c:forEach items="${dataList }"  var="row"  varStatus="status">
                               <tr>
                                   <c:forEach items="${row }" var="cell">
                                       <td>${cell.value }</td>
                                   </c:forEach>
                               </tr>
                            </c:forEach>
                            </tbody>
	                    </table>
	                    
	                    <div id="tb" style="height:auto">
					        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="append()">&nbsp;&nbsp;&nbsp;&nbsp;新增&nbsp;&nbsp;<i class="icon-plus"></i></a>
					        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveData()">&nbsp;&nbsp;&nbsp;&nbsp;删除&nbsp;&nbsp;<i class="icon-remove"></i></a>
					        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveData()">&nbsp;&nbsp;&nbsp;&nbsp;保存&nbsp;&nbsp;<i class="icon-save"></i></a>
					        <input type="hidden" value="${tableName }"  id="tableName" />
					        <input type="hidden" value="${fileId }"  id="fileId" />
					    </div>
	                    
		                </div>
		                <div id="searchText"></div>
		            </div><!--/row-->	            
                </div><!-- /.page-content -->
            </div><!-- /.main-content -->
        </div>
    </div><!-- /.main-container-inner -->
    <jsp:include page="../common/footer.jsp" />
    
    <script type="text/javascript">
	        var datagrid = $('#excel_data').datagrid();  
	        $("#excel_data").datagrid('hideColumn', 'id');        
	        $("#excel_data").datagrid('hideColumn', 'fileId');  
	        var editIndex = undefined;
	        function endEditing(){
	            if (editIndex == undefined){
	                return true;
	            }
	            if ($('#excel_data').datagrid('validateRow', editIndex)){
	                $('#excel_data').datagrid('endEdit', editIndex);
	                editIndex = undefined;
	                return true;
	            } else {
	                return false;
	            }
	        }
	        function onClickRow(index){
	                if (endEditing()){
	                    $('#excel_data').datagrid('selectRow', index).datagrid('beginEdit', index);
	                    editIndex = index;
	                } else {
	                    $('#excel_data').datagrid('selectRow', editIndex);
	                }
	        }
	        
	        // 新增数据
	          function append(){
	            if (endEditing()){
	                $('#excel_data').datagrid('appendRow', {});
	                editIndex = $('#dg').datagrid('getRows').length-1;
	                $('#excel_data').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
	            }
	        }
	        
	        // 保存新增或修改的数据
	          function saveData() {
	        	var row = $('#excel_data').datagrid('getSelected');
	        	
	        	if (row){
	        		row.tableName = $("#tableName").val();
	        		$('#excel_data').datagrid('acceptChanges');
	        		//alert(JSON.stringify( row ));
        		         if (row.id) {
	        			bravoui.ui.msg.waiting({
	                        title: "正在更新数据",
	                        msg: "请稍后..."
	                    });
	        		} else {
	        			row.fileId = $("#fileId").val(); 
	        			bravoui.ui.msg.waiting({
                            title: "正在新增数据",
                            msg: "请稍后..."
                        });
	        		}
	        		
	        	    $.ajax({
	        	    	url: _path + "/info/excel/update",
	        	    	type: "POST",
	        	    	dataType: "json",
	        	    	contentType: "application/json;charset=utf-8",
	        	    	data: JSON.stringify( row )
	        	    }).done(function(data){
	        	    	
	        	    	bravoui.ui.msg.waiting.remove();
	        	    	if (data.status == "S") {
	        	    		bravoui.ui.msg.alert(data.message);
	        	    	} else {
	        	    		bravoui.ui.msg.alert("Internal Server Error!");
	        	    		$('#excel_data').datagrid('rejectChanges');
	        	    	}
	        	    }).fail(function(xhr, msg, error){
	        	    	bravoui.ui.msg.waiting.remove();
	        	    	$('#excel_data').datagrid('rejectChanges');
	        	    	if ("timeout" == msg || "parsererror" == msg) {
                            bravoui.ui.msg.alert({
                                msg : "对不起，session过期，请重新登录!",
                                ok : function() {
                                    window.location.reload();
                                }
                            });
                        } else {
                            bravoui.ui.msg.alert("Internal Server Error!");
                        }
	        	    });
	        	}
	        }
    </script>
</body>
</html>
