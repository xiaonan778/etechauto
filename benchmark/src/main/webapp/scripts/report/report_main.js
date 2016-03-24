'use strict';

$(function(){
	$("#searchBtn").click(function(){
		var queryData = {keywords: $("#keywords").val()};
		$.ajax({
			url: _path + "/report/searchKeywords",
			type: "GET",
			data: queryData,
			dataType: "json"
		}).done(function(data){
			
		}).fail(function(xhr,  msg,  error){
			
		});
	});
});