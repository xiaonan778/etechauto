<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<jsp:include page="common/meta.jsp" />
<jsp:include page="common/resources.jsp" />
<link rel="stylesheet" type="text/css" href="${path }/resources/imgcss/css/normalize.css" />
<link rel="stylesheet" type="text/css" href="${path }/resources/imgcss/css/demo.css" />
<link rel="stylesheet" type="text/css" href="${path }/resources/imgcss/css/set1.css" />
</head>

<body class="keBody">
    <jsp:include page="common/header.jsp" />
	<div class="kePublic">
		<!--效果html开始-->
		<div class="container">
			<h1 class="keTitle"></h1>
			<div class="content">
				<div class="grid">
				
					<figure class="effect-layla">
						<img src="${path }/images/engine.png" alt="" />
						<figcaption>
							<h2>
								Engine<br><span>发动机</span>
							</h2>
							<p></p>
							<a href="${path }/engine">View more</a>
						</figcaption>
					</figure>
					
					<figure class="effect-layla">
						<img src="${path }/images/wheel.jpg" alt="img03" />
						<figcaption>
							<h2>
								Wheel<br><span>车轮</span>
							</h2>
							<p></p>
							<a href="javascript:void(0);">View more</a>
						</figcaption>
					</figure>
					
					<figure class="effect-layla">
                        <img src="${path }/images/engine.png" alt="" />
                        <figcaption>
                            <h2>
                                Engine<br><span>发动机</span>
                            </h2>
                            <p></p>
                            <a href="javascript:void(0);">View more</a>
                        </figcaption>
                    </figure>
                    
                    <figure class="effect-layla">
                        <img src="${path }/images/wheel.jpg" alt="img03" />
                        <figcaption>
                            <h2>
                                Wheel<br><span>车轮</span>
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
</body>

</html>
