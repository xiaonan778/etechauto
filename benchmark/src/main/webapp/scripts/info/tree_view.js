var uploadNode = "";

function addHoverDom(treeId, treeNode) {
	var sObj = $("#" + treeNode.tId + "_span");
	if ($("#editBtn_" + treeNode.tId).length > 0	|| $("#fileBtn_" + treeNode.tId).length > 0) {
		return;
	}
	if (treeNode.treeFlag === true) {
		// uploadId = treeNode.id;
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
				$("#uploadFile").val("");
				//        	 uploadId = treeNode.id;
				$("#myModal1").modal({
					backdrop : 'static',
					keyboard : false
				});
				return true;
			});
		}
			
	} else {
		var delStr = "<span style='margin-left: 5px;' class='button remove' id='delBtn_" + treeNode.tId + "' title='删除' onfocus='this.blur();'></span>";
		sObj.after(delStr);
		var fileStr = "<span style='margin-left: 10px;' class='button file' id='fileBtn_" + treeNode.tId + "' title='打开文件' onfocus='this.blur();'></span>";
		sObj.after(fileStr);
		var fileBtn = $("#fileBtn_" + treeNode.tId);
		if (fileBtn){
			fileBtn.on("click", function(e) {
				window.open(treeNode.fileUrl, "_blank");
			});
		}
		var delBtn = $("#delBtn_" + treeNode.tId);
		//if (delBtn) delBtn.unbind("click").bind("click",{treeNode:treeNode}, remove);
		if (delBtn) {
			delBtn.bind("click", {
				treeNode : treeNode
			}, remove);
		}
	}
};
function removeHoverDom(treeId, treeNode) {
	$("#editBtn_" + treeNode.tId).unbind().remove();
	$("#addBtn_" + treeNode.tId).unbind().remove();
	$("#fileBtn_" + treeNode.tId).unbind().remove();
	$("#delBtn_" + treeNode.tId).unbind().remove();
};

function addExcel(treeNode, node) {
	var zTree = $.fn.zTree.getZTreeObj("infoTree");
	zTree.addNodes(treeNode, node);
};

function remove(e) {
	var treeNode = e.data.treeNode;
	var zTree = $.fn.zTree.getZTreeObj("infoTree");
	bravoui.ui.msg.confirm({
		title : "警告",
		msg : "确认删除该文件?",
		ok : function() {
			bravoui.ui.msg.waiting({
				title : "正在删除",
				msg : "请稍后..."
			});
			$.ajax({
				type : "POST",
				contentType : 'application/json;charset=utf-8',
				url : _path + "/info/" + treeNode.id + "/deleteFile",
				dataType : 'json',
				cache : false,
				success : function(data) {
					bravoui.ui.msg.waiting.remove();
					if (data.msg == "success") {
						//bravoui.ui.msg.alert("删除成功!");
						zTree.removeNode(treeNode);
					} else {
						bravoui.ui.msg.alert(data.msg);
					}
				},
				error : function(data) {
					bravoui.ui.msg.waiting.remove();
					bravoui.ui.msg.alert("对不起,删除失败");
				}
			});
		}
	});
};

$(function() {

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
					$("#treeFlag").attr("class", "icon-minus");
					treeObj.expandAll(true);
				} else {
					$("#treeFlag").attr("class", "icon-plus");
					treeObj.expandAll(false);
				}
			} else {
				bravoui.ui.msg.alert("加载树结构失败！");
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
		if (opt.hasClass("icon-plus")) {
			opt.removeClass("icon-plus").addClass("icon-minus");
			$.cookie("tree_open", true, {
				path : '/benchmark/'
			});
			treeObj.expandAll(true);
			return false;
		}
		if (opt.hasClass("icon-minus")) {
			opt.removeClass("icon-minus").addClass("icon-plus");
			$.cookie("tree_open", false, {
				path : '/benchmark/'
			});
			treeObj.expandAll(false);
			return false;
		}
	});

	$("#confirmAdd").click(function() {
		
		var flag = $("#addType").val();
		if (flag == "2" || flag == "3") {
			if (!$("#uploadFile").val()) {
				$("#uploadFile").focus();
				alert("请选择要上传的文件！");
				return false;
			}
		} else if ((flag == "1")) {
			if (!$("#category").val()) {
				$("#category").focus();
				alert("请填写分类名称！");
				return false;
			}
		}
		bravoui.ui.msg.waiting({
			title: "",
			msg: "请稍后..."
		});
		$("#fileForm").ajaxSubmit({
			type : "POST",
			url : _path + "/info/" + uploadNode.id + "/fileUpload",
			dataType : "json",
			success : function(data) {
				bravoui.ui.msg.waiting.remove();
				if (data.status == "S") {
					$("#excel").val("");
					addExcel(uploadNode, data.node);
				} else {
					bravoui.ui.msg.alert("上传失败！");
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
	
	$("#category2").hide();
	$("#category3").hide();
	$("#addType").change(function(){
		var type = $(this).val();
		if (type == "1") {
			$("#category1").show();
			$("#category2").hide();
			$("#category3").hide();
			$("#category").val("");
			$("#uploadFile").val("");
		} else if (type == "2") {
			$("#category1").hide();
			$("#category2").show();
			$("#category3").show();
			$("#category").val("");
			$("#uploadFile").val("");
		} else if (type == "3") {
			$("#category1").hide();
			$("#category2").show();
			$("#category3").hide();
			$("#category").val("");
			$("#uploadFile").val("");
		}
	});
});
