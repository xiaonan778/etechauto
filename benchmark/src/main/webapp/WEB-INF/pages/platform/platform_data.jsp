<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources.jsp" />
    <script src="${path }/scripts/platform/platform_data.js" ></script>   
	<style type="text/css">
	      .table-operation-column a {
	        padding-right: 10px;
	      }
	      
	      .td-hover{
	        background-color: #FFFFC8;
	      }
	      .th-hover{
	        background-color: #FFFFC8;
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
				        <li class="active">平台运营数据</li>
				        <c:if test="${flag eq '1'}"><li class="active">拉新阶段</li></c:if>
				        <c:if test="${flag eq '2'}"><li class="active">活跃黏性阶段</li></c:if>
				        <c:if test="${flag eq '3'}"><li class="active">活动运营阶段</li></c:if>
				    </ul><!-- .breadcrumb -->
				</div>
				            
				<div class="page-content">
				    <div style="height: 40px;">
				        <input type="hidden" id="flag" value="${flag }" />
				    </div>
				    <!--  平台运营数据-拉新阶段  -->
				    <c:if test="${flag eq '1'}">
				    <p class="bg-success subHeader">累计数据：</p>
				    <div class="row">
				        <div class="col-xs-12">
				            <table id="tp" class="table table-striped table-hover table-bordered table-responsive">          
				                <tr>
				                    <th style="width:20%;">累计租户数</th>
				                    <th style="width:20%;">累计理财师数</th>
				                    <th style="width:20%;">累计Pad激活数</th>
				                    <th style="width:20%;">累计理财产品</th>
				                    <th style="width:20%;">累计投资人数</th>
				                </tr>      
				                <tr>
				                    <td><div id="tenant"><a href="${path }/report/tenant/tenant_sum_view" target="_self" class="btn-block">${pfs.sum_tenant}</a></div></td>
				                    <td><div id="cfp"><a href="${path }/report/cfp/financePlanner_sum_view" target="_self" class="btn-block">${pfs.sum_cfp}</a></div></td>
				                    <td><div id="pad"><a href="${path }/report/pad/pad_sum_view" target="_self" class="btn-block">${pfs.sum_pad}</a></div></td>
				                    <td><div id="product"><a href="${path }/report/product/product_sum_view" target="_self" class="btn-block">${pfs.sum_product}</a></div></td>
				                    <td><div id="investor"><a href="${path }/report/investor/investor_sum_view" target="_self" class="btn-block">${pfs.sum_investor}</a></div></td>
				                </tr>
				            </table>
				        </div>
				    </div>
				    <p class="bg-success subHeader">${pfs.days}天新增数据：</p>
				    <div class="row" style="width: 100%; height: 520px;margin: 0 auto;border: 1px solid #ddd;">
				        <div class="col-xs-1" style="height: 100%">
				            <img alt="previous" src="${path }/resources/images/pre.png" style="margin-top: 180px;cursor: pointer;" id="pre"/>
				        </div>
				        <div class="col-xs-10" style="height: 100%">
				            <div id="chart" style="height: 100%"></div>
				        </div>
				        <div class="col-xs-1" style="height: 100%">
				            <img alt="next" src="${path }/resources/images/next.png" style="margin-top: 180px;cursor: pointer;" id="next"/>
				        </div>
				    </div>
				    <div class="row">
				        <div class="col-xs-12">
				            <table id="tp" class="table table-striped table-hover table-bordered table-responsive tab-selected"  >  
				                <tr>
				                    <th style="width:20%;">新增租户</th>
				                    <th style="width:20%;">新增理财师</th>
				                    <th style="width:20%;">新增Pad激活</th>
				                    <th style="width:20%;">新增理财产品</th>
				                    <th style="width:20%;">新增投资人</th>
				                </tr>      
				                <tr>
				                    <td><div id="tenant"><a href="javascript:phase_new_charts(1);" class="btn-block">${pfs.month_tenant}</a></div></td>
				                    <td><div id="cfp"><a href="javascript:phase_new_charts(2);" class="btn-block">${pfs.month_cfp}</a></div></td>
				                    <td><div id="pad"><a href="javascript:phase_new_charts(3);" class="btn-block">${pfs.month_pad}</a></div></td>
				                    <td><div id="product"><a href="javascript:phase_new_charts(4);" class="btn-block">${pfs.month_product}</a></div></td>
				                    <td><div id="investor"><a href="javascript:phase_new_charts(5);" class="btn-block">${pfs.month_investor}</a></div></td>
				                </tr>
				            </table>
				        </div>
				    </div>
				    </c:if>
				    
				    <!--  平台运营数据-活跃粘性阶段  -->
				    <c:if test="${flag eq '2'}">
				    <p class="bg-success subHeader">活跃数据</p>
				    <div class="row">
				        <div class="col-xs-12">
				            <table id="tp" class="table table-striped table-hover table-bordered table-responsive">          
				                <tr>
				                    <th style="width:20%;">Pad登录数（累计）</th>
				                    <th style="width:20%;">Pad使用时长最密集区间（累计）</th>
				                    <th style="width:20%;">Pad使用频次最密集区间（累计）</th>
				                    <th style="width:20%;">活跃理财师（累计）</th>
				                    <th style="width:20%;">活跃租户（累计）</th>
				                </tr>      
				                <tr>
				                    <td><a href="${path }/report/pad/pad_loginSize_sum_view" target="_self" class="btn-block">${pad_login_size_all }</a></td>
				                    <td><a href="${path }/report/pad/pad_duration_sum_view" target="_self" class="btn-block">${max_pad_duration_range_all }</a></td>
				                    <td><a href="${path }/report/pad/pad_frequency_sum_view" target="_self" class="btn-block">${max_pad_frequency_range_all }</a></td>
				                    <td><a href="${path }/report/cfp/cfp_active_summary_view" target="_self" class="btn-block">${cfp_active_size_all}</a></td>
				                    <td><a href="${path }/report/tenant/tenant_active_sum_view" target="_self" class="btn-block">${tenant_active_size_all}</a></td>
				                </tr>
				            </table>
				        </div>
				    </div>
				    <div class="row">
				        <div class="col-xs-12">
				            <table id="tp" class="table table-striped table-hover table-bordered table-responsive">          
				                <tr>
				                    <th style="width:20%;">下单金额（本月累计）</th>
				                    <th style="width:20%;">产品下单数（本月累计）</th>
				                    <th style="width:20%;">产品支付单数（本月累计）</th>
				                    <th style="width:20%;">支付转化率</th>
				                </tr>      
				                <tr>
				                    <td><a href="${path }/report/trade/summary_view" target="_self" class="btn-block"><fmt:formatNumber value="${tenant_trade_amount }" type="currency" /></a></td>
				                    <td><a href="${path }/report/trade/summary_view" target="_self" class="btn-block">${tenant_total_order }</a></td>
				                    <td><a href="${path }/report/trade/summary_view" target="_self" class="btn-block">${tenant_pay_order }</a></td>
				                    <td><a href="${path }/report/trade/summary_view" target="_self" class="btn-block">${tenant_pay_ratio }</a></td>
				                </tr>
				            </table>
				        </div>
				    </div>
				    <p class="bg-success subHeader">本月活跃数据</p>
				    <div class="row" style="width: 100%; height: 520px;margin: 0 auto;border: 1px solid #ddd;">
				        <div class="col-xs-1" style="height: 100%">
				            <img alt="previous" src="${path }/resources/images/pre.png" style="margin-top: 180px;cursor: pointer;" id="pre"/>
				        </div>
				        <div class="col-xs-10" style="height: 100%">
				            <div id="phase_activity" style="height: 100%"></div>
				        </div>
				        <div class="col-xs-1" style="height: 100%">
				            <img alt="next" src="${path }/resources/images/next.png" style="margin-top: 180px;cursor: pointer;" id="next"/>
				        </div>
				    </div>
				    <div class="row">
				      <div class="col-xs-12">
				            <table id="tp" class="table table-striped table-bordered table-responsive tab-selected">          
				                <tr>
				                    <th style="width:20%;">Pad登录数</th>
				                    <th style="width:20%;">Pad使用频次最密集区间</th>
				                    <th style="width:20%;">Pad使用时长最密集区间</th>
				                    <th style="width:20%;">活跃理财师</th>
				                    <th style="width:20%;">活跃租户</th>
				                </tr>      
				                <tr>
				                    <td><a href="javascript:phase_activity_charts(1);" class="btn-block">${pad_login_size_month }</a></td>
				                    <td><a href="javascript:phase_activity_charts(2);" class="btn-block">${max_pad_frequency_range }</a></td>
				                    <td><a href="javascript:phase_activity_charts(3);" class="btn-block">${max_pad_duration_range }</a></td>
				                    <td><a href="javascript:phase_activity_charts(4);" class="btn-block">${cfp_active_size}</a></td>
				                    <td><a href="javascript:phase_activity_charts(5);" class="btn-block">${tenant_active_size}</a></td>
				                </tr>
				            </table>
				        </div>
				    </div>
				    </c:if>
				    
				    <!--  平台运营数据-活动运营阶段  -->
				    <c:if test="${flag eq '3'}">
				    <div class="row">
				        <div class="col-md-12 text-center" >
				            <div style="height: 400px">
				            <br>
				            <span style="font-size: 30px;" >敬请期待~</span>
				            </div>
				        </div>
				    </div>
				    </c:if>
				</div>
            </div><!-- /.main-content -->
            
        </div>
        
    </div><!-- /.main-container-inner -->
    
    <jsp:include page="../common/footer.jsp" />
</body>
</html>
       