var uploadNode = "";

function addHoverDom(treeId, treeNode) {
	var sObj = $("#" + treeNode.tId + "_span");
	if ($("#editBtn_" + treeNode.tId).length > 0	|| $("#fileBtn_" + treeNode.tId).length > 0) {
		return;
	}
	
	var addStr = "<span style='margin-left: 5px;' class='button add' id='addBtn_" + treeNode.tId + "' title='新增' onfocus='this.blur();'></span>";
	sObj.after(addStr);
	var editStr = "<span style='margin-left: 10px;' class='button edit' id='editBtn_" + treeNode.tId + "' title='编辑' onfocus='this.blur();'></span>";
	sObj.after(editStr);
	var btn = $("#editBtn_" + treeNode.tId);
	if (btn) {
		btn.bind("click", function() {
			window.location.href = _path + "/info/" + treeNode.id + "/toTreeEdit";
			return true;
		});
	}
		
	var addBtn = $("#addBtn_" + treeNode.tId);
	if (addBtn) {
		addBtn.bind("click", function() {
			uploadNode = treeNode;
			$("#category").val("");
			
			$("#myModal1").modal({
				backdrop : 'static',
				keyboard : false
			});
			return true;
		});
	}
			
};

function removeHoverDom(treeId, treeNode) {
	$("#editBtn_" + treeNode.tId).unbind().remove();
	$("#addBtn_" + treeNode.tId).unbind().remove();
	$("#fileBtn_" + treeNode.tId).unbind().remove();
	$("#delBtn_" + treeNode.tId).unbind().remove();
};

function addTreeNode(treeNode, node) {
	var zTree = $.fn.zTree.getZTreeObj("infoTree");
	zTree.addNodes(treeNode, node);
};


$(function() {
	function zTreeOnClick(event, treeId, treeNode){
		var pNode = treeNode.getParentNode();
		var full_name = treeNode.name;
		while(!!pNode) {
			full_name = pNode.name + "_" + full_name;;
		    pNode = pNode.getParentNode();
		}
		
		$("#selectedCategory").val(full_name);
		$("#categoryName").val(full_name);
		$("#categoryId").val(treeNode.id);
	}
	
	$.ajax({
		url : _path + "/info/listTree",
		type : "POST",
		dataType : "json",
		success : function(data) {
			if (data.status == "S") {
				var setting = {
					view : {
						addHoverDom : addHoverDom,
						removeHoverDom : removeHoverDom,
						selectedMulti : true
					},
					callback: {
						onClick: zTreeOnClick 
					},	
					check : {
						enable : false
					},
					data : {
						simpleData : {
							enable : true
						}
					},
					edit : {
						enable : false
					}
				};
				var zNodes = data.result;
				$.fn.zTree.init($("#infoTree"), setting, zNodes);
				var treeObj = $.fn.zTree.getZTreeObj("infoTree");
				var treeOpen = $.cookie("tree_open");
				if (typeof (treeOpen) == "undefined") {
					treeOpen = "false";
				}
				if (treeOpen == "true") {
					$("#treeFlag").attr("class", "fa fa-minus");
					treeObj.expandAll(true);
				} else {
					$("#treeFlag").attr("class", "fa fa-plus");
					treeObj.expandAll(false);
				}
			} else {
				bravoui.ui.msg.alert("加载车型结构失败！");
			}

		},
		error : function(msg, xhr, thrown) {
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
		}
	});

	$("#openAll").click(function() {
		var opt = $(this).children("i");
		var treeObj = $.fn.zTree.getZTreeObj("infoTree");
		if (opt.hasClass("fa-plus")) {
			opt.removeClass("fa-plus").addClass("fa-minus");
			$.cookie("tree_open", true, {
				path : '/benchmark/'
			});
			treeObj.expandAll(true);
			return false;
		}
		if (opt.hasClass("fa-minus")) {
			opt.removeClass("fa-minus").addClass("fa-plus");
			$.cookie("tree_open", false, {
				path : '/benchmark/'
			});
			treeObj.expandAll(false);
			return false;
		}
	});

	$("#confirmAdd").click(function() {
		if (!$("#category").val()) {
			$("#category").focus();
			alert("请填写分类名称！");
			return false;
		}
		bravoui.ui.msg.waiting({
			title: "",
			msg: "请稍后..."
		});
		$("#addForm").ajaxSubmit({
			type : "POST",
			url : _path + "/info/" + uploadNode.id + "/addCategory",
			dataType : "json",
			success : function(data) {
				bravoui.ui.msg.waiting.remove();
				if (data.status == "S") {
					$("#excel").val("");
					addTreeNode(uploadNode, data.node);
				} else {
					bravoui.ui.msg.alert("新增失败！");
				}
			},
			error : function(xhr, msg, error) {
				bravoui.ui.msg.waiting.remove();
				if ("timeout" == msg || "parsererror" == msg) {
					bravoui.ui.msg.alert({
						msg:"对不起，session过期，请重新登录!",
						ok: function(){
							window.location.reload();
						}
					});
				} else {
					bravoui.ui.msg.alert("Internal Server Error!");
				}
			}
		});
	});
	
	
	/**
	 * *****************************************************************************************
	 * 选择文件 start
	 * *****************************************************************************************
	 */
	$("#fileChooseBtn").click(function(){
		$("#fileChooseModal").modal("show");
	});
	
	$("input[name='fileType']:radio").change(function(){
		var fileType = $("input[name='fileType']:checked").val();
		
		if (fileType == 1) {
			$(".fileType1").removeClass("hidden");
			$(".fileType2").addClass("hidden");
		} else if (fileType == 2) {
			$(".fileType1").addClass("hidden");
			$(".fileType2").removeClass("hidden");
		}
	});
	
	$(".addFile1").click(function(){
		copyFile(".fileType1", ".addFile1", ".removeFile1");
	});
	$(".removeFile1").click(function(){
		removeFile(this, ".fileType1");
	});
	$(".addFile2").click(function(){
		copyFile(".fileType2", ".addFile2", ".removeFile2");
	});
	$(".removeFile2").click(function(){
		removeFile(this, ".fileType2");
	});
	function copyFile(container, add, remove){
		var copy = $(container).first().clone();
		copy.addClass("copy");
		copy.find("input").val("");
		copy.find("select").find("option").first().prop("selected", true);
		copy.find(".hidden").removeClass("hidden");
		copy.find(add).click(function(){
			copyFile(container, add, remove);
		});
		copy.find(remove).click(function(){
			removeFile(this, container);
		});
		$("#fileContainer").append(copy);
	}
	function removeFile(_this, container){
		if ($(container).length > 1) {
			$(_this).closest(container).remove();
		}
	}
	
	
	$("#chooseConfirmbtn").click(function(){
		var fileType = $("input[name='fileType']:checked").val();
		
		if (fileType == 1) {
			$(".fileType1").each(function(index, item){
				var excelFile = $(this).find("#excelFile");
				if (excelFile.val()) {
					var file = excelFile.clone();
					excelFile.after(file);
					excelFile.addClass("hidden");
					var template = $(this).find("#template").clone();
					template.addClass("hidden");
					var content = "<tr><td>" + template.find("option:selected").text() + "</td><td>Excel</td><td>" + excelFile.val() + "</td><td><a href='javascript:void(0);' class='delRow' >删除</a></td></tr>";
					content = $(content);
					$("#tp").find("tbody").append(content);
					
					content.find(".delRow").after(excelFile).after(template).click(function(){
						$(this).closest("tr").remove();
					});
				}
			});
		} else if (fileType == 2) {
			$(".fileType2").each(function(index, item){
				var otherFile = $(this).find("#otherFile");
				if (otherFile.val()) {
					var file = otherFile.clone();
					otherFile.after(file);
					otherFile.addClass("hidden");
					var content = "<tr><td>无</td><td>其它</td><td>" + otherFile.val() + "</td><td><a href='javascript:void(0);' class='delRow' >删除</a></td></tr>";
					content = $(content);
					$("#tp").find("tbody").append(content);
					content.find(".delRow").after(otherFile).click(function(){
						$(this).closest("tr").remove();
					});
				}
			});
		}
		$(".copy").remove();
	});
	/**
	 * *****************************************************************************************
	 * 选择文件 end
	 * *****************************************************************************************
	 */
	
	
	// 确认上传
	$("#uploadBtn").click(function(){
		
		if (!$("#categoryId").val()) {
			bravoui.ui.msg.alert("请选择一个车型");
			return false;
		}
		if ($("#uploadForm").find("input[type='file']").length == 0) {
			bravoui.ui.msg.alert("请选择文件上传");
			return false;
		}
		
		$("#uploadForm").ajaxSubmit({
			url: _path + "/info/data/upload",
			type: "POST",
			dataType: "json",
			success: function(data){
				bravoui.ui.msg.waiting.remove();
				if (data.status == "S") {
					bravoui.ui.msg.alert({
						msg:data.message,
						ok: function(){
							location.reload();
						}
						});
				} else {
					bravoui.ui.msg.alert(data.message);
				}
			},
			error: function(xhr, msg, error){
				bravoui.ui.msg.waiting.remove();
				if (msg == "parsererror") {
					bravoui.ui.msg.alert({
                        msg:"连接超时，请重新登录",
                        ok: function(){
                            location.reload();
                        }
                    });
				} else {
					bravoui.ui.msg.alert("Internal Server Error");
				}
			}
		});
	});
	
});
