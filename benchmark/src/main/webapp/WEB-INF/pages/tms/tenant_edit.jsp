<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources.jsp" />
    
    <script src="${path }/scripts/common/preview.js" ></script>
    <script src="${path }/scripts/tms/tenant_edit.js" ></script>
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
                        <li class="active">编辑租户</li>
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
			                        <td class="panel-title" style="width: 96%;text-align: center;font-weight:bold">编辑租户&nbsp;${tenant.name}</td>
			                    </tr>
			               </table>
			            </div>
			            <div class="panel-body">
			            <div class="row">
			            <form  id="tenant_edit_form" class="form"  enctype="multipart/form-data" >
			            <div class="col-md-12">
			                <p class="bg-success subHeader">基本信息：</p>
			            </div>
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-6">
			                          <div class="form-group">
			                            <div class="input-group">
			                                    <div class="input-group-addon">Token：</div>
			                                    <input class="form-control" value="${tenant.id}" type="text" id="id" name="id" readonly>        
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
			                                    <div class="input-group-addon">租户名称：</div>
			                                    <input class="form-control" value="${tenant.name}"  type="text" id="name" name="name">                            
			                            </div>
			                          </div>
			                    </div>
			                    <div class="col-md-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-addon"> 平台域名：</div>
                                            <input class="form-control" value="${tenant.domain}" type="text" id="domain" name="domain" readonly>    
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
                                                <input class="form-control" value="${tenant.name_apk}"  type="text" id="name_apk" name="name_apk"  placeholder="请输入应用名称">                              
                                        </div>
                                      </div>
                                </div>
			                    <div class="col-md-6">
			                          <div class="form-group">
			                            <div class="input-group">
			                                    <div class="input-group-addon">应用版本：</div>
			                                    <input class="form-control" value="${tenant.ver_apk}" type="text" id="ver_apk" name="ver_apk"  placeholder="请输入应用版本">     
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
                                                <div class="input-group-addon">祺鲲产品：</div>
                                                <input class="form-control" value="${tenant.qkcp}" type="text" id="qkcp" name="qkcp" readonly>                         
                                        </div>
                                      </div>
                                </div>
                                <div class="col-md-6">
                                      <div class="form-group">
                                        <div class="input-group">
                                                <div class="input-group-addon">版本号：</div>
                                                <input class="form-control" value="${tenant.version}" type="text" id="version" name="version" readonly>     
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
			                                    <input class="form-control"  value="${tenant.pad_count}" type="text" id="pad_count" name="pad_count"  placeholder="请输入Pad下发数">              
			                            </div>
			                          </div>
			                    </div>
			                    <div class="col-md-6">
			                        <div class="form-group">
			                            <div class="input-group">
			                                <div class="input-group-addon">接口频道：</div>
			                                        <input class="form-control" value="${tenant.channel}" type="text" id="channel" name="channel" placeholder="请输接口频道">     
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
			                                    <input class="form-control" type="text" value="${tenant.app_key}" id="app_key" name="app_key"  placeholder="请输入友盟Channel">      
			                            </div>
			                          </div>
			                    </div>
			                    <div class="col-md-6">
			                          <div class="form-group">
			                            <div class="input-group">
			                                    <div class="input-group-addon">友盟Secret：</div>
			                                    <input class="form-control" type="text" value="${tenant.secret}"  id="secret" name="secret" placeholder="请输入友盟Secret">      
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
			                                <div class="input-group-addon"> 大logo：</div>
			                                 <input class="form-control" type="file" id="logo_l" name="logo_l" onchange="previewImage(this,0)">
			                                </div>
			                        </div>
			                    </div>
			                    <div class="col-md-6">
			                        <div class="form-group">
			                            <div class="input-group">
			                                        请上传152×204像素，png格式的图片
			                                 <div id="preview0">
			                                    <!-- 显示本地图片需在Tomcat配置虚拟目录 -->
			                                    <c:choose>
			                                       <c:when test="${empty tenant.logo}">
			                                            <img id="imghead" width=150 height=150 border=0 src='${path }/images/nophoto.jpg'>
			                                       </c:when>
			                                       <c:otherwise>
			                                            <img id="imghead" width=152 height=204 border=0 src='/upload${tenant.logo }'>
			                                            <input  value="${tenant.logo}" type="text" id="logo" name="logo" style="display:none;"> 
			                                       </c:otherwise>
			                                    </c:choose>
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
			                                <div class="input-group-addon"> 小logo：</div>
			                                 <input class="form-control" type="file" id="logo_s" name="logo_s" onchange="previewImage(this,1)">
			                                </div>
			                        </div>
			                    </div>
			                    <div class="col-md-6">
			                        <div class="form-group">
			                            <div class="input-group">
			                                         请上传35×32像素图片
			                                 <div id="preview1">
			                                    <!-- 显示本地图片需在Tomcat配置虚拟目录 -->
			                                    <c:choose>
			                                       <c:when test="${empty tenant.logo_mini}">
			                                            <img id="imghead" width=40 height=40 border=0 src='${path }/images/nophoto.jpg'>
			                                       </c:when>
			                                       <c:otherwise>
			                                            <img id="imghead" width=35 height=32 border=0 src='/upload${tenant.logo_mini }'>
			                                            <input  value="${tenant.logo_mini}" type="text" id="logo" name="logo" style="display:none;">    
			                                       </c:otherwise>
			                                    </c:choose>
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
			                                <div class="input-group-addon"> 应用图标：</div>
			                                 <input class="form-control" type="file" id="logo_apk" name="logo_apk" onchange="previewImage(this,2)">
			                                </div>
			                        </div>
			                    </div>
			                    <div class="col-md-1">
			                        <input type="checkbox" name="delPic" value="logo_apk">&nbsp;删除图片</input>
			                    </div>
			                    <div class="col-md-5">
			                        <div class="form-group">
			                            <div class="input-group">
			                                          请上传144×144像素，png格式的图片  
			                                 <div id="preview2">
			                                    <!-- 显示本地图片需在Tomcat配置虚拟目录 -->
			                                    <c:choose>
			                                       <c:when test="${empty tenant.pic_apk}">
			                                            <img id="imghead" width=144 height=144 border=0 src='${path }/images/nophoto.jpg'>
			                                       </c:when>
			                                       <c:otherwise>
			                                            <img id="imghead" width=144 height=144 border=0 src='/upload${tenant.pic_apk }'>
			                                            <input  value="${tenant.pic_apk}" type="text" id="logo" name="logo" style="display:none;">  
			                                       </c:otherwise>
			                                    </c:choose>
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
			                                <div class="input-group-addon"> 导航栏小图标：</div>
			                                 <input class="form-control" type="file" id="logo_nav" name="logo_nav" onchange="previewImage(this,3)">
			                                </div>
			                        </div>
			                    </div>
			                    <div class="col-md-1">
			                        <input type="checkbox" name="delPic" value="logo_nav">&nbsp;删除图片</input>
			                    </div>
			                    <div class="col-md-5">
			                        <div class="form-group">
			                            <div class="input-group">
			                                         请上传32×32像素，png格式的图片  
			                                 <div id="preview3">
			                                    <!-- 显示本地图片需在Tomcat配置虚拟目录 -->
			                                    <c:choose>
			                                       <c:when test="${empty tenant.pic_nav}">
			                                            <img id="imghead" width=32 height=32 border=0 src='${path }/images/nophoto.jpg'>
			                                       </c:when>
			                                       <c:otherwise>
			                                            <img id="imghead" width=32 height=32 border=0 src='/upload${tenant.pic_nav }'>
			                                            <input  value="${tenant.pic_nav}" type="text" id="logo" name="logo" style="display:none;">  
			                                       </c:otherwise>
			                                    </c:choose>
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
			                                <div class="input-group-addon"> 启动页图片：</div>
			                                 <input class="form-control" type="file" id="logo_start" name="logo_start" onchange="previewImage(this,4)">
			                                </div>
			                        </div>
			                    </div>
			                    <div class="col-md-1">
			                        <input type="checkbox" name="delPic" value="logo_start">&nbsp;删除图片</input>
			                    </div>
			                    <div class="col-md-5">
			                        <div class="form-group">
			                            <div class="input-group">
			                                          请上传1280×800像素，png格式的图片 
			                                 <div id="preview4">
			                                    <!-- 显示本地图片需在Tomcat配置虚拟目录 -->
			                                    <c:choose>
			                                       <c:when test="${empty tenant.pic_start}">
			                                            <img id="imghead" width=256 height=160 border=0 src='${path }/images/nophoto.jpg'>
			                                       </c:when>
			                                       <c:otherwise>
			                                            <img id="imghead" width=256 height=160 border=0 src='/upload${tenant.pic_start }'>
			                                            <input  value="${tenant.pic_start}" type="text" id="logo" name="logo" style="display:none;">    
			                                       </c:otherwise>
			                                    </c:choose>
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
			                                <textarea class="form-control" rows="3" id="memo" name="memo" maxlength="200">${tenant.memo}</textarea>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
			             <div class="text-center">
			                <button type="button" class="btn btn-primary" onclick="editTenant();">保存</button>
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