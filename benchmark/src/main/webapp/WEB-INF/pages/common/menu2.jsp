<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!-- Top Nav Start -->
<div id='cssmenu'>
	<ul>
	   <shiro:hasPermission name="menu:info_search">
	       <li>
	          <a href='${path }/engine' id="sys_search"> <i class="fa fa-search"></i>信息检索</a>
           </li>
	   </shiro:hasPermission>
		<shiro:hasPermission name="menu:tree">
		    <li>
	          <a href="${path }/info/toTree" id="sys_import"> <i class="fa fa-upload"></i> 数据导入</a>
	        </li>
		</shiro:hasPermission>
		<li class=''><a href='#'  id="sys_config"><i class="fa fa-cogs"></i>设置</a>
			<ul>
			    <shiro:hasPermission name="menu:admin_permission">
			         <li><a href='${path }/sys/admin/list'>账号管理</a></li>
			    </shiro:hasPermission>
				<shiro:hasPermission name="menu:role_permission">
				    <li><a href='${path }/role/list'>角色权限</a></li>
				</shiro:hasPermission>
				<shiro:hasPermission name=" menu:sys_permission">
				    <li><a href='${path }/permission/list'>权限管理</a></li>
				</shiro:hasPermission>
				<li><a href='#'>模板管理</a></li>
			</ul>
		</li>
	</ul>
</div>
<!-- Top Nav End -->
