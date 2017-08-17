<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html lang="en">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<base
	href="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/" />
<title>WISP - Login</title>
<!-- Bootstrap -->
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="resources/slick/slick.css">
<link rel="stylesheet" type="text/css"
	href="resources/slick/slick-theme.css">
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
	<%@ include file="/WEB-INF/pages/admin/templetes/header.jsp"%>
	<div class="container">
		<div id="loginbox" style="margin-top: 50px;"
			class="mainbox col-md-4 col-md-offset-4 col-sm-8 col-sm-offset-2">
			<div class="panel panel-info">
				<div class="panel-heading">
					<div class="panel-title">Sign In</div>
				</div>
				<div style="padding-top: 30px" class="panel-body">
					<c:if test="${not empty errors}">
						<div id="login-alert" class="alert alert-danger col-sm-12">
							<strong>Error!</strong> ${errors}
						</div>
					</c:if>
					<c:if test="${not empty success}">
						<div id="login-alert" class="alert alert-success col-sm-12">
							${success}
						</div>
					</c:if>
					<div class="social-icons">
						<p>
							<a class="btn btn-primary social-login-btn social-facebook"
								href="#">Continue with &nbsp;&nbsp;<i class="fa fa-facebook"></i></a>
						</p>
						<p>
							<a class="btn btn-primary social-login-btn social-google"
								href="#">Continue with &nbsp;&nbsp;<i
								class="fa fa-google-plus"></i></a>
						</p>
						<!-- <a class="btn btn-primary social-login-btn social-twitter" href="/auth/twitter"><i class="fa fa-twitter"></i></a> -->
					</div>
					<form id="loginform" class="form-horizontal" role="form"
						action="<c:url value='/admin/j_spring_security_check'/>" method="post">
						<div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"><i
								class="glyphicon glyphicon-user"></i></span> <input id="login-username"
								type="text" class="form-control" name="j_username"
								placeholder="Email">
						</div>
						<div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"><i
								class="glyphicon glyphicon-lock"></i></span> <input id="login-password"
								type="password" class="form-control" name="j_password"
								placeholder="Password">
						</div>
						<div class="input-group">
							<div class="checkbox">
								<label> <input id="login-remember" type="checkbox"
									name="remember-me" value="1"> Remember me
								</label>
							</div>
						</div>

						<div
							style="float: right; font-size: 80%; position: relative; top: -16px">
							<a href="forgotpassword">Forgot password?</a>
						</div>
						<div style="margin-top: 10px" class="form-group">
							<!-- Button -->
							<div class="col-sm-12 controls text-center">
								<input name="submit" type="submit" value="Login" id="btn-login"
									class="btn custom-button" />
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-12 control">
								<div
									style="border-top: 1px solid #888; padding-top: 15px; font-size: 85%">
									Don't have an account! <a href="register">Sign Up Here</a>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/pages/templetes/footer.jsp"%>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="resources/js/bootstrap.min.js"></script>
	<!-- <script src="slick/slick.js" type="text/javascript" charset="utf-8"></script> -->
	<!-- <script src="js/custom.js" type="text/javascript"></script> -->
	<script type="text/javascript" src="resources/js/custom-jssor.js"></script>
	<script type="text/javascript" src="resources/js/jssor.slider.js"></script>
	<script type="text/javascript" src="resources/js/jssor.js"></script>
</body>
</html>