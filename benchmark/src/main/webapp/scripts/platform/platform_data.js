var num = 3;
$(function(){
	var flag = $("#flag").val();
	if ( "1" == flag ) {
		phase_new_charts(num);
	}
	if ( "2" == flag) {
		phase_activity_charts(num);
	}
	
	
	$("#tp td").mouseover(function(){
		$(this).addClass("warning");
	});
	$("#tp td").mouseout(function(){
		$(this).removeClass("warning");
	});
	
	$("#next").click(function(){
		num = num + 1;
		showDiffPhaseReport(flag);
	});
	$("#pre").click(function(){
		num = num -1;
		showDiffPhaseReport(flag);
	});
	
	$("#pmd_new_phase_" + flag).addClass("active");
	$("#pmd").addClass("open");
	$("#pmd").addClass("active");
});

/**
 * 平台运营数据-拉新阶段 报表显示
 * @param i
 */
function phase_new_charts(i){
	num = i;
	tableHover(i);
	switch (i) {
	  case 1: var url = _path + "/report/tenant/trend/chart";
		      $('#chart').load(url);
	          break;
	  case 2: var url = _path + "/report/cfp/trend/chart";
		      $('#chart').load(url);
		      break;
	  case 3: var url = _path + "/report/pad/trend/chart";
		      $('#chart').load(url);
			  break;
	  case 4: var url = _path + "/report/product/trend/chart";
		      $('#chart').load(url);
			  break;
	  case 5: var url = _path + "/report/investor/trend/chart";
		      $('#chart').load(url);
			  break;
	  default: var url = _path + "/report/tenant/trend/chart";
	          $('#chart').load(url);
	}
}

/**********
function SummaryChart(i){
	switch (i) {
	  case 2: var url = _path+"/report/cfp/organize/chart";
		      $('#chart').load(url);
		      break;
	    break;
	  case 3: var url = _path+"/report/pad/organize/chart";
		      $('#chart').load(url);
			  break;
	  default: ;
	}
}
**********/

/**
 * 平台运营数据-活跃粘度阶段 报表显示
 * @param num_in
 */
function phase_activity_charts(num_in){
	num = num_in;
	tableHover(num_in);
	switch (num_in) {
	  case 1: var url = _path + "/report/pad/loginSize/chart";
	  		  $('#phase_activity').load(url);
	  		  break;  		
	  case 2: var url = _path + "/report/pad/frequency/chart";
			  $('#phase_activity').load(url);
			  break;
	  case 3: var url = _path + "/report/pad/duration/chart";
	    	  $('#phase_activity').load(url);
	          break;
	  case 4: var url = _path + "/report/cfp/active/chart";
		      $('#phase_activity').load(url);
		  	  break;
	  case 5: var url = _path + "/report/tenant/active/chart";
      	      $('#phase_activity').load(url);
		      break;
	  default: $('#phase_activity').html("");
	}
}

/**
 * 点击pre或next图片时，根据Flag变量和全局变量 num 来显示相应的报表
 * @param flag
 */
function showDiffPhaseReport(flag){
	switch (flag) {
	  case "1": if (num >= 6) {
					num = 1;
				}
				if (num <= 0) {
					num = 5;
				}
				phase_new_charts(num);
	          break;
	  case "2": if (num >= 6) {
		  			num = 1;
				}
				if (num <= 0) {
					num = 5;
				}
				phase_activity_charts(num);
			  break;
	  case "3": ;
	  		  break;
	  default: ;
	}
}

/**
 * 给选中的单元格添加样式
 * @param num
 */
function tableHover(num) {
	$(".tab-selected").find("th").eq(num - 1).addClass("th-hover");
	$(".tab-selected").find("th").eq(num - 1).siblings().removeClass("th-hover");
	$(".tab-selected").find("td").eq(num - 1).addClass("td-hover");
	$(".tab-selected").find("td").eq(num - 1).siblings().removeClass("td-hover");
}
