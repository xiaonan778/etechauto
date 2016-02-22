<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <title>新增租户</title>
    <jsp:include page="../common/resources.jsp" />
    <link rel="stylesheet" href="${path }/css/report/load.css" />
    <script src="${path }/scripts/common/preview.js" ></script>
    <script src="${path }/scripts/tms/tenant_add.js" ></script>
    <script type="text/javascript">
        $(function(){
            $("#tms_list").addClass("active");
            $("#tms").addClass("open");
            $("#tms").addClass("active");
            
            $("#qkcp_fk").change(function(){
            	$("#version_fk").html("");
            	var qkcp_fk = $("#qkcp_fk").val();
                $.ajax({
                    type : "POST",
                    data : {qkcp_fk: qkcp_fk},
                    url : _path + "/tms/getAbilityVersion",
                    dataType : "json",
                    success : function(data){
                       var contents = "";
                       if (data.msg == "S") {
                    	   $("#version_fk").show();
                    	   $("#noVersion").remove();
                    	   var versions = data.result;
                           $.each(versions, function(index, version){
                               contents = contents + "<option value='" + version.id + "'>" + version.name + "</option>";
                           });
                           $("#version_fk").html(contents);
                       } else {
                    	  contents =  "<input id='noVersion' class='form-control' type='text' value='无可用版本'  readonly/>";
                    	  $("#version_fk").after(contents);
                    	  $("#version_fk").hide();
                       }
                    },
                    error : function(msg, xhr, thrown) {
                        
                    }
                });
            });
            
        });
    </script>
    <style>
        .dk_fouc select {
            position: relative;
            top: 0;
            visibility: visible;
        }
    </style>
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
                        <li class="active">租户管理</li>
                        <li><a href="${path}/tms/list">租户清单</a></li>
                        <li class="active">新增租户</li>
                    </ul><!-- .breadcrumb -->
                </div>
            
                <div class="page-content">
                    <div style="height: 40px;"></div>
                    <div class="panel panel-default">
			            <div class="panel-heading">
			                <table style="width: 99%;">
			                    <tr>
			                        <td style="width: 4%;text-align: left;" nowrap="nowrap" >
			                        <a  class="btn btn-primary" type="button" href="${path }/tms/list" >返回</a></td>
			                        <td class="panel-title" style="width: 96%;text-align: center;font-weight:bold">新增租户</td>
			                    </tr>
			               </table>
			            </div>
			            <div class="panel-body">
			            <div class="row">
			            <form  id="tenant_add_form" class="form" enctype="multipart/form-data" >
			            <div class="col-md-12">
			                    <p class="bg-success subHeader">基本信息：</p>
			            </div>
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-6">
			                        <div class="form-group">
			                            <div class="input-group">
			                                <div class="input-group-addon">Token：</div>
			                                <input class="form-control" type="text" id="id" name="id" value="${token}" readonly>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-6">
			                        <div class="form-group">
                                        <div class="input-group">
                                                <div class="input-group-addon" id="tenantName">租户名称：</div>
                                                <!-- <input class="form-control" type="text" id="name" name="name"  onkeyup="validateText(1);" placeholder="请输入租户名" > -->     
                                                <input class="form-control" type="text" id="name" name="name" placeholder="请输入租户名" >                          
                                        </div>
                                     </div>
			                    </div>
			                    <div class="col-md-6">
			                       <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-addon" id="tenantDomain"> 平台域名：</div>
                                            <input class="form-control" type="text" id="domain" name="domain" placeholder="请输入域名">    
                                            <div class="input-group-addon">${webSuffix}</div>
                                        </div>
                                    </div>
                                </div>
			                </div>
			            </div>			            
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-6">
			                          <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-addon">应用名称：</div>
                                            <input class="form-control" type="text" id="name_apk" name="name_apk"  placeholder="请输入应用名">        
                                        </div>
                                      </div>
			                    </div>
			                    <div class="col-md-6">
			                          <div class="form-group">
			                            <div class="input-group">
			                                    <div class="input-group-addon">应用版本：</div>
			                                    <input class="form-control" type="text" id="ver_apk" name="ver_apk"  placeholder="请输入应用版本">      
			                            </div>
			                          </div>
			                    </div>			                    
			                </div>
			            </div>
			            <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-6">
                                     <div class="form-group">
                                          <div class="input-group">
                                              <div class="input-group-addon">祺鲲产品:</div>
                                              <select  class="form-control" id="qkcp_fk" name="qkcp_fk" >
                                                   <c:forEach items="${qkcpList}" var="one" >
                                                       <option value="${one.id }">${one.name}</option>
                                                   </c:forEach>
                                              </select>
                                          </div>
                                      </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                               <div class="input-group-addon">版本号:</div>
                                               <c:choose>
                                                  <c:when test="${versions != null && versions.size() > 0}">
                                                  <select class="form-control" id="version_fk" name="version_fk">
                                                      <c:forEach items="${versions }" var="version">
                                                        <option value="${version.id }">${version.name }</option>
                                                      </c:forEach>
                                                  </select> 
                                                  </c:when>
                                                  <c:otherwise>
                                                     <select class="form-control" id="version_fk" name="version_fk" style="display:none;"></select>
                                                     <input id="noVersion" class="form-control" type="text" value="无可用版本"  readonly/>
                                                  </c:otherwise>
                                               </c:choose>     
                                        </div>
                                     </div>
                                </div>
                            </div>                  
                        </div>
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-6">
			                          <div class="form-group">
			                            <div class="input-group">
			                                    <div class="input-group-addon">下发Pad：</div>
			                                    <input class="form-control" type="text" id="pad_count" name="pad_count"  placeholder="请输入Pad下发数">       
			                            </div>
			                          </div>
			                    </div>
			                    <div class="col-md-6">
			                        <div class="form-group">
			                            <div class="input-group">
			                                <div class="input-group-addon">接口频道：</div>
			                                <input class="form-control" type="text" id="channel" name="channel"  placeholder="请输接口频道">      
			                                <%-- <select class="form-control" id="channel" name="channel" >
			                                    <c:forEach var="dic" items="${channels}">
			                                     <option value="${dic.name }" >${dic.name }</option>
			                                    </c:forEach>
			                                </select> --%>
			                             </div>
			                         </div>
			                   </div>
			                </div>                  
			            </div>
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-6">
			                          <div class="form-group">
			                            <div class="input-group">
			                                    <div class="input-group-addon">友盟Channel：</div>
			                                    <input class="form-control" type="text" id="app_key" name="app_key"  placeholder="请输入友盟Channel">        
			                            </div>
			                          </div>
			                    </div>
			                    <div class="col-md-6">
			                          <div class="form-group">
			                            <div class="input-group">
			                                    <div class="input-group-addon">友盟Secret：</div>
			                                    <input class="form-control" type="text" id="secret" name="secret" placeholder="请输入友盟Secret">        
			                            </div>
			                          </div>
			                    </div>
			                </div>                  
			            </div>
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-6">
			                        <div class="form-group">
			                            <div class="input-group">
			                                <div class="input-group-addon">大logo：</div>
			                                 <input class="form-control" type="file" id="logo_l" name="logo_l" onchange="previewImage(this,0)">
			                            </div>
			                        </div>
			                    </div>
			                    <div class="col-md-6">
			                        <div class="form-group">
			                            <div class="input-group">
			                                请上传152×204像素，png格式的图片
			                                 <div id="preview0">
			                                 <img id="imghead" width=150 height=150 border=0 src='${path }/images/nophoto.jpg'>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                </div>                  
			            </div>
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-6">
			                        <div class="form-group">
			                            <div class="input-group">
			                                <div class="input-group-addon">小logo：</div>
			                                 <input class="form-control" type="file" id="logo_s" name="logo_s" onchange="previewImage(this,1)">
			                            </div>
			                        </div>
			                    </div>
			                    <div class="col-md-6">
			                        <div class="form-group">
			                            <div class="input-group">
			                                 请上传35×32像素图片  
			                                 <div id="preview1">
			                                  <img id="imghead" width=40 height=40 border=0 src='${path }/images/nophoto.jpg'>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                </div>                  
			            </div>
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-6">
			                        <div class="form-group">
			                            <div class="input-group">
			                                <div class="input-group-addon">应用图标：</div>
			                                 <input class="form-control" type="file" id="logo_apk" name="logo_apk" onchange="previewImage(this,2)">
			                            </div>
			                        </div>
			                    </div>
			                    <div class="col-md-6">
			                        <div class="form-group">
			                            <div class="input-group">
			                                 请上传144×144像素，png格式的图片  
			                                 <div id="preview2">
			                                  <img id="imghead" width=144 height=144 border=0 src='${path }/images/nophoto.jpg'>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                </div>                  
			            </div>  
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-6">
			                        <div class="form-group">
			                            <div class="input-group">
			                                <div class="input-group-addon">导航栏小图标：</div>
			                                 <input class="form-control" type="file" id="logo_nav" name="logo_nav" onchange="previewImage(this,3)">
			                            </div>
			                        </div>
			                    </div>
			                    <div class="col-md-6">
			                        <div class="form-group">
			                            <div class="input-group">
			                                 请上传32×32像素，png格式的图片  
			                                 <div id="preview3">
			                                  <img id="imghead" width=32 height=32 border=0 src='${path }/images/nophoto.jpg'>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                </div>                  
			            </div>      
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-6">
			                        <div class="form-group">
			                            <div class="input-group">
			                                <div class="input-group-addon">启动页图片：</div>
			                                 <input class="form-control" type="file" id="logo_start" name="logo_start" onchange="previewImage(this,4)">
			                            </div>
			                        </div>
			                    </div>
			                    <div class="col-md-6">
			                        <div class="form-group">
			                            <div class="input-group">
			                                 请上传1280×800像素，png格式的图片  
			                                 <div id="preview4">
			                                  <img id="imghead" width=256 height=160 border=0 src='${path }/images/nophoto.jpg'>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                </div>                  
			            </div>                          
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-12">
			                        <div class="form-group">
			                            <div class="input-group">
			                                <div class="input-group-addon">&nbsp;备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：&nbsp;</div>
			                                <textarea class="form-control" rows="3" id="memo" name="memo" maxlength="200"></textarea>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
			             <div class="text-center">
			                <button type="button" class="btn btn-primary" id="addTenant">下一步</button>
			            </div>
			            </form>
			            </div>             
			         </div>    
			        </div>
                    
                </div><!-- /.page-content -->
            </div><!-- /.main-content -->
            
        </div>
        
    </div><!-- /.main-container-inner -->
    
    <jsp:include page="../common/footer.jsp" />
</body>
</html>
