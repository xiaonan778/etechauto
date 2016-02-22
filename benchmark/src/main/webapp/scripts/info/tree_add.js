$(function(){
    
    $("#level").chosen().change(function(){
    	var level = $("#level").val();
    	if (level == "1") {
    		$("#parents_select").attr("style", "visibility: hidden;");
    		$("#parent_fk").val("");
    		$('#parent_fk').combotree('clear');
    	} else {
    		$("#parents_select").attr("style", "visibility: visible;");
    	}
    });
    
    $("#parent_fk").combotree({ 
    	url: _path + '/info/comboTree',
        valueField: 'id',
        textField: 'text',
        required: true,
        editable: false,
        onClick: function (node) { 
        	
        },
        onLoadSuccess: function (node, data) {
        	
        }
    });
});

$(function(){  
    
	validator = $('#tree_add_form').validate({
	    	errorElement : 'span',  
	        errorClass : 'help-block',  
	        focusInvalid : false,  
	        rules : {  
	        	name : {  
	                required : true,
	                rangelength:[1, 500]
	            },
	            sorter : {  
	                required : true,
	                rangelength:[2, 4],
	                digits: true
	            }
	        },  
	        messages : {    
	        	name : {  
	                required : "必须填写菜单名称.",
	                rangelength:jQuery.validator.format("请输入 一个长度介于 {0} 和 {1} 之间的字符串")
	            },
	            sorter : {  
	                required : 	"必须填写菜单排序."
	            }
	        },
	        highlight : function(element) {  
	            $(element).closest('.form-group').addClass('has-error');  
	        },
	        success : function(label) {  
	            label.closest('.form-group').removeClass('has-error');  
	            label.remove();  
	        }, 
	        errorPlacement : function(error, element) {  
	            element.parent('div').parent('div').append(error);  
	        }
	        
	    });
	
    $("#submit").click(function(){
    	var level = $("#level").val();
    	if (level != "1") {
    		if(!$("input[name='parent_fk']").val()) {
    			bravoui.ui.msg.alert("请选择父级节点！");
    			return false;
    		}
    	} 
    	
    	if (validator.form()) {
    		bravoui.ui.msg.waiting({
    			title : "正在新增树节点",
    			msg : "请稍等..."
    		});
    		$("#tree_add_form").ajaxSubmit({
                type: "POST",
                url: _path + "/info/addTree",
                dataType: "json",
                success: function(data){
                	bravoui.ui.msg.waiting.remove();
                	if (data.msg == "S") {
                		bravoui.ui.msg.alert({
                			msg : "新增树节点成功！",
                			ok : function(){
                				window.location = _path + "/info/toTree";
                			}
                		});
                	} else {
                		bravoui.ui.msg.alert("新增树节点失败！");
                	}
                },  
                error : function(xhr, msg, error) {  
                	bravoui.ui.msg.waiting.remove();
                	if ("timeout" == msg || "parsererror" == msg) {
                        bravoui.ui.msg.alert({
                			msg : "对不起，session过期，请重新登录!",
                			ok : function(){
                				window.location.reload();
                			}
                		});
                    } else {
                        bravoui.ui.msg.alert("Internal Server Error!");
                    }
                }  
            });
    	}
		
	});
    
});