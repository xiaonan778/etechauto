$(function(){
	$.extend( true, $.fn.dataTable.defaults, {
	    searching: true,
	    ordering: true,
	    autoWidth: true,
	    aLengthMenu: [[10, 25, 50, 100,-1], [10, 25, 50, 100,"所有"]],
	    language: {
	        lengthMenu: "每页 _MENU_ 条记录",
	        zeroRecords: "没有找到记录",
	        info: "第 _PAGE_ 页 ( 总共 _PAGES_ 页 )",
	        infoEmpty: "无记录",
	        infoFiltered: "(从 _MAX_ 条记录过滤)",
	        paginate: {
	            previous: "&laquo;",
	            next: "&raquo;",
	            first: "首页",
	            last: "尾页"
	        },
	        search: "过滤"
	    }
	});
	
	jQuery.fn.dataTableExt.oApi.fnReloadAjax = function ( oSettings, sNewSource, fnCallback, bStandingRedraw )
	{
	    // DataTables 1.10 compatibility - if 1.10 then `versionCheck` exists.
	    // 1.10's API has ajax reloading built in, so we use those abilities
	    // directly.
	    if ( jQuery.fn.dataTable.versionCheck ) {
	        var api = new jQuery.fn.dataTable.Api( oSettings );
	 
	        if ( sNewSource ) {
	            api.ajax.url( sNewSource ).load( fnCallback, !bStandingRedraw );
	        }
	        else {
	            api.ajax.reload( fnCallback, !bStandingRedraw );
	        }
	        return;
	    }
	 
	    if ( sNewSource !== undefined && sNewSource !== null ) {
	        oSettings.sAjaxSource = sNewSource;
	    }
	 
	    // Server-side processing should just call fnDraw
	    if ( oSettings.oFeatures.bServerSide ) {
	        this.fnDraw();
	        return;
	    }
	 
	    this.oApi._fnProcessingDisplay( oSettings, true );
	    var that = this;
	    var iStart = oSettings._iDisplayStart;
	    var aData = [];
	 
	    this.oApi._fnServerParams( oSettings, aData );
	 
	    oSettings.fnServerData.call( oSettings.oInstance, oSettings.sAjaxSource, aData, function(json) {
	        /* Clear the old information from the table */
	        that.oApi._fnClearTable( oSettings );
	 
	        /* Got the data - add it to the table */
	        var aData =  (oSettings.sAjaxDataProp !== "") ?
	            that.oApi._fnGetObjectDataFn( oSettings.sAjaxDataProp )( json ) : json;
	 
	        for ( var i=0 ; i<aData.length ; i++ )
	        {
	            that.oApi._fnAddData( oSettings, aData[i] );
	        }
	 
	        oSettings.aiDisplay = oSettings.aiDisplayMaster.slice();
	 
	        that.fnDraw();
	 
	        if ( bStandingRedraw === true )
	        {
	            oSettings._iDisplayStart = iStart;
	            that.oApi._fnCalculateEnd( oSettings );
	            that.fnDraw( false );
	        }
	 
	        that.oApi._fnProcessingDisplay( oSettings, false );
	 
	        /* Callback user function - for event handlers etc */
	        if ( typeof fnCallback == 'function' && fnCallback !== null )
	        {
	            fnCallback( oSettings );
	        }
	    }, oSettings );
	};
});
