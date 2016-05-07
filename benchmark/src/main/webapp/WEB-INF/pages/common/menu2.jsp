<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!-- Top Nav Start -->
<div id='cssmenu'>
	<ul>
		<li>
	      <a href='${path }/engine' id="sys_search"> <i class="fa fa-search"></i>信息检索</a>
	    </li>
		<li>
		  <a href="${path }/info/toTree" id="sys_import"> <i class="fa fa-upload"></i> 数据导入</a>
		</li>
		<li class=''><a href='#'><i class="fa fa-cogs"></i>设置</a>
			<ul>
				<li><a href='#'>账号管理</a></li>
				<li><a href='#'>角色权限</a></li>
				<li><a href='#'>权限管理</a></li>
				<li><a href='#'>模板管理</a></li>
			</ul>
		</li>
	</ul>
</div>
<!-- Top Nav End -->

<script type="text/javascript">
    
        /* $(document).on("click", "#cssmenu li a", function(){
            var activeId_2 = $(this).attr("id");    
            var activeId_1 = $(this).parent().parent().attr("id");
            $.cookie("activeId_1", activeId_1, { path: '/benchmark/' });
            $.cookie("activeId_2", activeId_2, { path: '/benchmark/' });  
        });
        
        $(document).on("click", ".menu-item", function(){
            var activeId_1 = $(this).attr("id");    
            $.cookie("activeId_1", null, { path: '/benchmark/' });
            $.cookie("activeId_2", activeId_1, { path: '/benchmark/' });  
        });
        
        
        var activeId_1 = $.cookie("activeId_1");
       
        $("#" + activeId_2).addClass("active"); */
        
    </script>