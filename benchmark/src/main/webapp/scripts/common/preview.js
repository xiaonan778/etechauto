   //ͼƬ�ϴ�Ԥ��    IE�������˾���
        function previewImage(file,flag)
        {
        	var div = document.getElementById('preview'+flag);
          switch(flag){
          	case 0:
          		var MAXWIDTH  = 152; 
                var MAXHEIGHT = 204;
          	    break;
          	case 1:
          		var MAXWIDTH  = 35; 
                var MAXHEIGHT = 32;
          		break;
          	case 2:
          		var MAXWIDTH  = 144; 
                var MAXHEIGHT = 144;
          		break;
          	case 3:
          		var MAXWIDTH  = 32; 
                var MAXHEIGHT = 32;
          		break;
          	case 4:
          		var MAXWIDTH  = 256; 
                var MAXHEIGHT = 160;
          		break;          		
          }
          if (file.files && file.files[0])
          {
              div.innerHTML ='<img id=imghead'+flag+'>';
              var img = document.getElementById('imghead'+flag);
              img.onload = function(){
                var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
                img.width  =  rect.width;
                img.height =  rect.height;
//                 img.style.marginLeft = rect.left+'px';
                img.style.marginTop = rect.top+'px';
              }
              var reader = new FileReader();
              reader.onload = function(evt){img.src = evt.target.result;}
              reader.readAsDataURL(file.files[0]);
          }
          else //����IE
          {
            var sFilter='filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';
            file.select();
            var src = document.selection.createRange().text;
            div.innerHTML ='<img id=imghead'+flag+'>';
            var img = document.getElementById('imghead'+flag);
            img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
            var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
            status =('rect:'+rect.top+','+rect.left+','+rect.width+','+rect.height);
            div.innerHTML = "<div id=divhead style='width:"+rect.width+"px;height:"+rect.height+"px;margin-top:"+rect.top+"px;"+sFilter+src+"\"'></div>";
          }
        }
        function clacImgZoomParam( maxWidth, maxHeight, width, height ){
            var param = {top:0, left:0, width:width, height:height};
            if( width>maxWidth || height>maxHeight )
            {
                rateWidth = width / maxWidth;
                rateHeight = height / maxHeight;
                 
                if( rateWidth > rateHeight )
                {
                    param.width =  maxWidth;
                    param.height = Math.round(height / rateWidth);
                }else
                {
                    param.width = Math.round(width / rateHeight);
                    param.height = maxHeight;
                }
            }
             
            param.left = Math.round((maxWidth - param.width) / 2);
            param.top = Math.round((maxHeight - param.height) / 2);
            return param;
        }
