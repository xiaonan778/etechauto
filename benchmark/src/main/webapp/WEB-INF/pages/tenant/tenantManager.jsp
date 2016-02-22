<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources.jsp" />
    <link href="${path}/css/report/tenantManager.css" rel="stylesheet">
    <script src="${path }/scripts/tenant/tenantManager/tenantManager.js?randomId=<%=Math.random()%>" ></script> 
</head>
<body class="navbar-fixed">
    <jsp:include page="../common/header.jsp" />
    <div class="main-container">
        <div class="main-container-inner">  
            <jsp:include page="../common/menu.jsp" />
            
            <div class="main-content" id="mainContent">
                <div class="breadcrumbs" id="breadcrumbs">       
				    <ul class="breadcrumb">
				        <li>
				            <i class="icon-home home-icon"></i>
				            <a href="${path}/">首页</a>
				        </li>
				        <li class="active">租户运营数据</li>
				        <c:if test="${flag eq '1'}"><li class="active">拉新阶段</li></c:if>
				        <c:if test="${flag eq '2'}"><li class="active">活跃黏性阶段</li></c:if>
				        <c:if test="${flag eq '3'}"><li class="active">活动运营阶段</li></c:if>
				    </ul><!-- .breadcrumb -->
				</div>
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							<div class="bg-success myPanel">
								<div class="row">
									<div class="col-md-4">
										<h4 style="display:inline-block">
											正在看的是:<strong class="text-primary" id="tenantName">${tenantName}</strong>的运营情况
										</h4>
										<input type="hidden" id="tenantId" value="${tenantId}" />
									</div>
									<div class="col-md-8">
										<button type="button" id="changeTenant" class="btn btn-small">点击更换其他租户</button>
									</div>
								</div>
							</div>
						</div>
					</div>
	
	          <c:if test="${flag eq '1'}">
					<div class="row" >
						<div class="col-xs-12">
							<table id="tp" class="table table-striped table-hover table-bordered table-responsive">
								<tr>
									<th style="width:25%;">累计理财师数</th>
									<th style="width:25%;">累计Pad激活数</th>
									<th style="width:25%;">累计理财产品</th>
									<th style="width:25%;">累计投资人数</th>
								</tr>
								<tr>
									<td><div id="cfpSum">
											<a href="${path }/report/cfp/tenant/${tenantId}/summary" target="_self" class="btn-block">0</a>
										</div>
									</td>
									<td><div id="padSum">
											<a href="${path }/report/pad/tenant/${tenantId}/summary" target="_self" class="btn-block">0</a>
										</div>
									</td>
									<td><div id="productSum">
											<a href="${path }/report/product/tenant/${tenantId}/summary" target="_self" class="btn-block">0</a>
										</div>
									</td>
									<td><div id="investorSum">
											<a href="${path }/report/investor/tenant/${tenantId}/summary" target="_self" class="btn-block">0</a>
										</div>
									</td>
								</tr>
							</table>
						</div>
					</div>
			 </c:if>
			 
			  <c:if test="${flag eq '2'}">
			  	    <p class="bg-success subHeader">活跃数据</p>
				    <div class="row">
				        <div class="col-xs-12">
				            <table id="tp" class="table table-striped table-hover table-bordered table-responsive">          
				                <tr>
				                    <th style="width:25%;">Pad登录数（累计）</th>
				                    <th style="width:25%;">Pad使用时长最密集区间（累计）</th>
				                    <th style="width:25%;">Pad使用频次最密集区间（累计）</th>
				                    <th style="width:25%;">活跃理财师（累计）</th>
				                </tr>      
				                <tr>
				                    <td id="padLoginSum">
				                        <a href="${path }/report/pad/tenant_pad_loginSize_sum_view/${tenantId}" target="_self" class="btn-block">0</a>
				                    </td>
				                    <td id="max_pad_duration_range_all">
				                        <a href="${path }/report/pad/tenant_pad_duration_sum_view/${tenantId}" target="_self" class="btn-block">0</a>
				                    </td>
				                    <td id="max_pad_frequency_range_all">
				                        <a href="${path }/report/pad/tenant_pad_frequency_sum_view/${tenantId}" target="_self" class="btn-block">0</a>
				                    </td>
				                    <td id="cfp_active_size_all">
				                        <a href="${path }/report/cfp/tenant/active/${tenantId}/summary" target="_self" class="btn-block">0</a>
				                    </td>
				                </tr>
				            </table>
				        </div>
				    </div>
				    <div class="row">
				        <div class="col-xs-12">
				            <table id="tp" class="table table-striped table-hover table-bordered table-responsive">          
				                <tr>
				                    <th style="width:25%;">下单金额（本月累计）</th>
				                    <th style="width:25%;">产品下单数（本月累计）</th>
				                    <th style="width:25%;">产品支付单数（本月累计）</th>
				                    <th style="width:25%;">支付转化率</th>
				                </tr>      
				                <tr>
				                    <td class ="trade"  id="tenant_trade_amount"><a href="${path }/report/trade/tenant_summary_view/${tenantId}" target="_self" class="btn-block">￥0.00</a></td>
				                    <td class ="trade"  id="tenant_total_order"><a href="${path }/report/trade/tenant_summary_view/${tenantId}" target="_self" class="btn-block">0</a></td>
				                    <td class ="trade"  id="tenant_pay_order"><a href="${path }/report/trade/tenant_summary_view/${tenantId}" target="_self" class="btn-block">0</a></td>
				                    <td class ="trade"  id="tenant_pay_ratio"><a href="${path }/report/trade/tenant_summary_view/${tenantId}" target="_self" class="btn-block">0</a></td>
				                </tr>
				            </table>
				        </div>
				    </div>
			  </c:if>
			 
			 
					<div class="row" >
						<div class="col-xs-12">
							<p class="bg-success subHeader">30天新增数据</p>
						</div>
					</div>
					
					<div class="row" >
						<div class="panel-body">
							<div class="row"
								style="width: 100%; height: 520px;margin: 0 auto;border: 1px solid #ddd;">
								<div class="col-xs-1" style="height: 100%">
									<img alt="previous" src="${path }/resources/images/pre.png" style="margin-top: 180px;cursor: pointer;" id="pre" />
								</div>
								<div class="col-xs-10" style="height: 100%">
								    <c:if test="${flag eq '1'}">
									    <div id="phase_activity" style="height: 100%"></div>
									 </c:if>
									 <c:if test="${flag eq '2' }">
									 	 <div id="activeRptChart" style="height: 100%"></div>
			                          </c:if>
								</div>
								<div class="col-xs-1" style="height: 100%">
									<img alt="next" src="${path }/resources/images/next.png" style="margin-top: 180px;cursor: pointer;" id="next" />
								</div>
							</div>
						</div>
					</div>
			 
			 <c:if test="${flag eq '1' }">
					<div class="row" >
						<div class="col-xs-12">
							<table id="tp" class="table table-striped table-hover table-bordered table-responsive tab-selected">
								<tr>
									    <th style="width:25%;">新增理财师</th>
										<th style="width:25%;">新增Pad激活</th>
										<th style="width:25%;">新增理财产品</th>
										<th style="width:25%;">新增投资人</th>
								</tr>
								<tr>
									<td><div class="mySlide " id="slide-1">
											<a href="javascript:void(0);" class="btn-block">0</a><input type="hidden" value="cfp" />
										</div>
									</td>
									<td><div class="mySlide selected" id="slide-2">
											<a href="javascript:void(0);" class="btn-block">0</a><input type="hidden" value="pad" />
										</div>
									</td>
									<td><div class="mySlide" id="slide-3">
											<a href="javascript:void(0);" class="btn-block">0</a><input type="hidden" value="product" />
										</div>
									</td>
									<td><div class="mySlide" id="slide-4">
											<a href="javascript:void(0);" class="btn-block">0</a><input type="hidden" value="investor" />
										</div>
									</td>
								</tr>
							</table>
						</div>
					</div>
			  </c:if>
					
					
		       <c:if test="${flag eq '2' }">
					<div class="row" >
						<div class="col-xs-12">
							<table id="tp" class="table table-striped table-hover table-bordered table-responsive tab-selected">
								<tr>
								    <th style="width:25%;">Pad登录数</th>
								    <th style="width:25%;">Pad使用时长最密集区间</th>
									<th style="width:25%;">Pad使用频次最密集区间</th>
									<th style="width:25%;">活跃理财师</th>
								</tr>
								<tr>
									<td><div class="mySlide " id="slide-1">
											<a href="javascript:void(0);" class="btn-block">0</a><input type="hidden" value="pad/loginSize/" />
										</div>
									</td>
									<td><div class="mySlide selected"  id="slide-2">
											<a href="javascript:void(0);" class="btn-block">0</a><input type="hidden" value="pad/duration" />
										</div>
									</td>
									<td><div class="mySlide" id="slide-3">
											<a href="javascript:void(0);" class="btn-block">0</a><input type="hidden" value="pad/frequency" />
										</div>
									</td>
									<td><div class="mySlide" id="slide-4">
											<a href="javascript:void(0);" class="btn-block">0</a><input type="hidden" value="cfp/active" />
										</div>
									</td>
								</tr>
							</table>
						</div>
			         </div>
				</c:if>

				    <div style="height: 40px;">
				        <input type="hidden" id="flag" value="${flag }" />
				    </div>
				</div><!-- /.page-content -->
            </div><!-- /.main-content -->
            
        </div>
        
    </div><!-- /.main-container-inner -->
    
    <jsp:include page="../common/footer.jsp" />
    
    <!-- 弹出层 -->
    <div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;">
       <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header"  style="background-color:#EFF3F8;">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                    <h4 class="modal-title" id="myModalLabel">更换租户</h4>
                </div>
                <div class="modal-body">
	                <div class="table-responsive">
						<table id="sample-table-1" class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
								    <th hidden>租户id</th>
									<th class="center">租户</th>
									<th class="center">域名</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list}" var="tenant" varStatus="s">
								    <tr class ="myBg">
								        <td class="tId" hidden>${tenant.id}</td>
								        <td class="tName">${tenant.name}</td>
								        <td>${tenant.domain}</td>
								    </tr>
								</c:forEach>
							</tbody>
					    </table>
					</div>
													
                   <!--  <c:forEach items="${list}" var="tenant" varStatus="s">
                        <c:if test="${s.index%3==0}">
                            <div class="row top">
                                    <div class="col-md-2  col-md-offset-1 myBg"><input type="hidden" value="${tenant.id}"/><h5>${tenant.name}</h5></div>
                        </c:if>
                         <c:if test="${s.index%3==1}">
                                    <div class="col-md-2  col-md-offset-2 myBg"><input type="hidden" value="${tenant.id}"/><h5>${tenant.name}</h5></div>
                        </c:if>
                         <c:if test="${s.index%3==2}">
                                    <div class="col-md-2  col-md-offset-2 myBg"><input type="hidden" value="${tenant.id}"/><h5>${tenant.name}</h5></div></div>
                        </c:if>
                        <c:if test="${s.last}&&${s.index}%3!=0">
                             </div>
                        </c:if>
                    
                    </c:forEach> -->
                   <!-- </div> --> 
                </div>
                     <div class="modal-footer">
                       <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                       <button type="button" class="btn btn-primary" data-dismiss="modal" id="confireTenant">确定</button>
                     </div> 
                </div>
              
            </div><!-- /.modal-content -->
         </div><!-- /.modal-dialog -->
     </div><!--弹出层  结束 --> 
</body>
</html>
       