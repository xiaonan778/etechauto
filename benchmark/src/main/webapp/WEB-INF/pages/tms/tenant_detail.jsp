<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <title>租户详情</title>
    <jsp:include page="../common/resources.jsp" />
    <script type="text/javascript">
        $(function(){
            $("#tms_list").addClass("active");
            $("#tms").addClass("open");
            $("#tms").addClass("active");
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
                        <li class="active">租户管理</li>
                        <li><a href="${path}/tms/list">租户清单</a></li>
                        <li class="active">租户详情</li>
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
			                        <td class="panel-title" style="width: 96%;text-align: center;font-weight:bold">租户详情</td>
			                    </tr>
			               </table>
			            </div>
			            <div class="panel-body">
			            <div class="row">
			            <div class="col-md-12">
			                <p class="bg-success subHeader">基本信息：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<c:if test="${tenant.status==1}"> <a href="http://${tenant.domain}${webSuffix}/admin" target="_blank"><b>点击查看租户主页</b></a></c:if></p>
			            </div>
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-12">
			                        <div class="form-group">
			                            <div class="input-group">
			                                 <div id="preview">
			                                    <!-- 显示本地图片需在Tomcat配置虚拟目录 -->
			                                       大logo &nbsp;
			                                    <c:choose>
			                                       <c:when test="${empty tenant.logo}">
			                                                <img id="imghead" width=150 height=150 border=0 src='${path }/images/nophoto.jpg'>
			                                       </c:when>
			                                       <c:otherwise>
			                                            <img id="imghead" width=152 height=204 border=0 src='/upload${tenant.logo }'>
			                                       </c:otherwise>
			                                    </c:choose>
			                                    &nbsp;&nbsp;小logo &nbsp;
			                                    <c:choose>
			                                       <c:when test="${empty tenant.logo_mini}">
			                                             <img id="imghead1" width=40 height=40 border=0 src='${path }/images/nophoto.jpg'>
			                                       </c:when>
			                                       <c:otherwise>
			                                            <img id="imghead" width=35 height=32 border=0 src='/upload${tenant.logo_mini }'>
			                                       </c:otherwise>
			                                    </c:choose>
			                                    &nbsp;&nbsp;应用图标 &nbsp;
			                                    <c:choose>
			                                       <c:when test="${empty tenant.pic_apk}">
			                                             <img id="imghead1" width=114 height=114 border=0 src='${path }/images/nophoto.jpg'>
			                                       </c:when>
			                                       <c:otherwise>
			                                            <img id="imghead" width=114 height=114 border=0 src='/upload${tenant.pic_apk }'>
			                                       </c:otherwise>
			                                    </c:choose>
			                                    &nbsp;&nbsp;导航栏小图标 &nbsp;
			                                    <c:choose>
			                                    <c:when test="${empty tenant.pic_nav}">
			                                             <img id="imghead1" width=32 height=32 border=0 src='${path }/images/nophoto.jpg'>
			                                       </c:when>
			                                       <c:otherwise>
			                                            <img id="imghead" width=32 height=32 border=0 src='/upload${tenant.pic_nav }'>
			                                       </c:otherwise>
			                                    </c:choose>
			                                    &nbsp;&nbsp;启动页图片 &nbsp;
			                                    <c:choose>
			                                    <c:when test="${empty tenant.pic_start}">
			                                             <img id="imghead1" width=256 height=160 border=0 src='${path }/images/nophoto.jpg'>
			                                       </c:when>
			                                       <c:otherwise>
			                                            <img id="imghead" width=256 height=160 border=0 src='/upload${tenant.pic_start }'>
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
			                                    <input class="form-control" value="${tenant.name}" type="text" id="name" name="name" readonly>                         
			                            </div>
			                          </div>
			                    </div>
			                    <div class="col-md-6">
                                <div class="form-group">
                                    <div class="input-group">
                                        <div class="input-group-addon"> 平台域名：</div>
                                        <input class="form-control" value="${tenant.domain}" type="text" id="domain" name="domain" readonly>    
                                        <div class="input-group-addon">${webSuffix }</div>
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
                                                <input class="form-control" value="${tenant.name_apk}" type="text" id="name_apk" name="name_apk" readonly>                         
                                        </div>
                                      </div>
                                </div>
			                    <div class="col-md-6">
			                          <div class="form-group">
			                            <div class="input-group">
			                                    <div class="input-group-addon">应用版本：</div>
			                                    <input class="form-control" value="${tenant.ver_apk}" type="text" id="ver_apk" name="ver_apk" readonly>       
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
			                                <div class="input-group-addon"> Pad数：</div>
			                                <input class="form-control" value="${tenant.pad_count}" type="text" id="pad_count" name="pad_count" readonly>   
			                            </div>
			                        </div>
			                    </div>
			                    <div class="col-md-6">
			                        <div class="form-group">
			                            <div class="input-group">
			                                <div class="input-group-addon">接口频道:</div>
			                                        <input class="form-control" value="${tenant.channel}" type="text" id="channel" name="channel" readonly>     
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
			                                    <input class="form-control" type="text" value="${tenant.app_key}" id="app_key" name="app_key"  readonly>        
			                            </div>
			                          </div>
			                    </div>
			                    <div class="col-md-6">
			                          <div class="form-group">
			                            <div class="input-group">
			                                    <div class="input-group-addon">友盟Secret：</div>
			                                    <input class="form-control" type="text" value="${tenant.secret}"  id="secret" name="secret" readonly>       
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
			                                <textarea class="form-control" rows="3" id="memo" name="memo" readonly>${tenant.memo}</textarea>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
			            <div class="col-md-12">
			                <p class="bg-success subHeader">数据库信息：</p>
			            </div>
			            <c:choose>
			                <c:when test="${empty tenantDb}">
			                    <div class="row">
			                        <div class="col-md-12">
			                            <div class="col-md-12">
			                                <div class="form-group">
			                                    <div class="input-group">
			                                        该租户还未配置数据库
			                                    </div>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                </c:when>
			                <c:otherwise>
			                    <div class="row">
			                        <div class="col-md-12">
			                            <div class="col-md-6">
			                                <div class="form-group">
			                                    <div class="input-group">
			                                        <div class="input-group-addon"> 库名：</div>
			                                        <input class="form-control" value="${tenantDb.name}" type="text"  readonly> 
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
			                                        <div class="input-group-addon"> 帐号：</div>
			                                        <input class="form-control" value="${tenantDb.account}" type="text"  readonly>  
			                                    </div>
			                                </div>
			                            </div>
			                            <div class="col-md-6">
			                                <div class="form-group">
			                                    <div class="input-group">
			                                        <div class="input-group-addon"> 密码：</div>
			                                        <input class="form-control" value="${tenantDb.password}" type="text"  readonly> 
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
			                                        <div class="input-group-addon">备注：</div>
			                                        <textarea class="form-control" rows="3" readonly>${tenantDb.memo}</textarea>
			                                    </div>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                </c:otherwise>
			            </c:choose>         
			            </div> 
			            </div>   
			            <div class="col-md-12">
			                <p class="bg-success subHeader">屏蔽功能：</p>
			            </div>  
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-12">
			                        <div class="form-group">
			                            <div class="input-group">
			                                <c:set var="size" value="0" ></c:set>
			                                <c:forEach items="${dictionaryList}" var="dictionary">
			                                    <c:if test="${dictionary.valid eq 1 }"> &nbsp;${dictionary.name}&nbsp;&nbsp;&nbsp;&nbsp; <c:set var="size" value="1" ></c:set></c:if>
			                                </c:forEach>
			                                    <c:if test="${size eq 0 }">&nbsp;无</c:if>
			                            </div>
			                        </div>
			                    </div>
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
