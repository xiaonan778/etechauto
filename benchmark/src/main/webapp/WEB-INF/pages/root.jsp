<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<jsp:include page="common/meta.jsp" />
<jsp:include page="common/resources2.jsp" />
<link rel="stylesheet" type="text/css" href="${path }/resources/imgcss/css/normalize.css" />
<link rel="stylesheet" type="text/css" href="${path }/resources/imgcss/css/demo.css" />
<link rel="stylesheet" type="text/css" href="${path }/resources/imgcss/css/set1.css" />
</head>

<body class="keBody">
    <jsp:include page="common/header2.jsp" />
	<div class="kePublic">
		<!--效果html开始-->
		<div class="container">
			<div class="content">
				<div class="grid">
				
					<figure class="effect-layla">
						<img src="${path }/images/1.png" alt="" />
						<figcaption>
							<h2>
								<!-- Engine<br> -->
								<br>
								<span>整车</span>
							</h2>
							<p></p>
							<a href="${path }/engine">View more</a>
						</figcaption>
					</figure>
					
					<figure class="effect-layla">
						<img src="${path }/images/1.png" alt="img03" />
						<figcaption>
							<h2>
								<br>
								<span>动力总成</span>
							</h2>
							<p></p>
							<a href="javascript:void(0);">View more</a>
						</figcaption>
					</figure>
					
					<figure class="effect-layla">
                        <img src="${path }/images/1.png" alt="" />
                        <figcaption>
                            <h2>
								<br>
								<span>底盘</span>
                            </h2>
                            <p></p>
                            <a href="javascript:void(0);">View more</a>
                        </figcaption>
                    </figure>
                    
                    <figure class="effect-layla">
                        <img src="${path }/images/1.png" alt="img03" />
                        <figcaption>
                            <h2>
								<br>
								<span>内外饰</span>
                            </h2>
                            <p></p>
                            <a href="javascript:void(0);">View more</a>
                        </figcaption>
                    </figure>
                    <figure class="effect-layla">
                        <img src="${path }/images/1.png" alt="img03" />
                        <figcaption>
                            <h2>
								<br>
								<span>安全</span>
                            </h2>
                            <p></p>
                            <a href="javascript:void(0);">View more</a>
                        </figcaption>
                    </figure>	
                    <figure class="effect-layla">
                        <img src="${path }/images/1.png" alt="img03" />
                        <figcaption>
                            <h2>
								<br>
								<span>车联网</span>
                            </h2>
                            <p></p>
                            <a href="javascript:void(0);">View more</a>
                        </figcaption>
                    </figure>	                    				
				</div>
			</div>
		</div>
		<!-- /container -->

		<div class="clear"></div>
	</div>
	<div class="keBottom"></div>
	
	<script>
	   function resizeContainer() {
		   var height = $(window).height();
		   height = height -80 < 580 ? 580 : height -80;
		   $(".kePublic").height(height);
	   }
	   resizeContainer();
	   $(window).resize(function(){
		   resizeContainer();
	   });
	</script>
</body>

</html>
