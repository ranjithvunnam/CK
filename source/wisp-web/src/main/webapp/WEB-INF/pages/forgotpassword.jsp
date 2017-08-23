<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html lang="en">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<base
	href="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/" />
<title>CelebrateKaro</title>
<link rel="shortcut icon" href="resources/images/logo.ico" type="image/x-icon">
<!-- Bootstrap -->
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="resources/slick/slick.css">
<link rel="stylesheet" type="text/css" href="resources/slick/slick-theme.css">
<link href="resources/css/custom.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="resources/css/rating.css">
<link rel="stylesheet" href="resources/css/jssor.css">
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>

	<%@ include file="templetes/simple_header.jsp"%>
	<div class="container">
		<div id="loginbox" style="margin-top: 50px;"
			class="mainbox col-md-4 col-md-offset-4 col-sm-8 col-sm-offset-2">
			<div class="panel panel-info">
				<div class="panel-heading">
					<div class="panel-title">Forgot Password</div>
				</div>
				<div style="padding-top: 30px" class="panel-body">
					<div style="display: none" id="login-alert"
						class="alert alert-danger col-sm-12"></div>
					<div class="col-sm-12 forget-password-image text-center">
						<img src="resources/images/key.ico" alt="">
						<h5>Enter your Email address and we will send you a link to
							reset your password</h5>
					</div>
					<c:if test="${not empty error}">
							<div id="signupalert" class="alert alert-danger">
								<p>Error: ${error}</p>
							</div>
						</c:if>
					<form id="loginform" class="form-horizontal" role="form" action="forgotpassword" method="POST">
						<div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"><i
								class="glyphicon glyphicon-user"></i></span> <form:input path="forgotPass.email" id="login-username"
								type="text" class="form-control" name="email" value=""
								placeholder="Your Email Id"/>
						</div>
						<div class="form-group">
							<div style="width: 100%" class="input-group text-center">
							<input name="submit" type="submit" value="Send
									Me Link" id="btn-signup"
									class="btn custom-button" />
								<!-- <a href="forgotpassword2.html" id="btn-signup" type="button"
									class="btn custom-button"><i class="icon-hand-right"></i>Send
									Me Link</a> -->
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-12 control">
								<div
									style="border-top: 1px solid #888; padding-top: 15px; font-size: 85%">
									Don't have an account! <a href="register">Sign Up
										Here</a>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>

	</div>
	<%@ include file="templetes/footer.jsp"%>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="resources/js/bootstrap.min.js"></script>
	<!-- <script src="slick/slick.js" type="text/javascript" charset="utf-8"></script> -->
	<!-- <script src="js/custom.js" type="text/javascript"></script> -->
	<script type="text/javascript" src="resources/js/custom-jssor.js"></script>
	<script type="text/javascript" src="resources/js/jssor.slider.js"></script>
	<script type="text/javascript" src="resources/js/jssor.js">

    </script>
</body>
</html>