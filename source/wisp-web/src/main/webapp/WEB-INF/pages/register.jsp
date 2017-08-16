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
	<%@ include file="templetes/header.jsp"%>

	<div class="container">
		<div id="signupbox" style="margin-top: 50px"
			class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
			<div class="panel panel-info">
				<div class="panel-heading">
					<div class="panel-title">Sign Up</div>
					<div
						style="float: right; font-size: 85%; position: relative; top: -18px">
						<a id="signinlink" href="login.do">Already joined? &nbsp;
							Sign In</a>
					</div>
				</div>
				<div class="panel-body">
					<form id="signupform" class="form-horizontal" role="form" action="registration.do" method="POST">
						<c:if test="${not empty error}">
							<div id="signupalert" class="alert alert-danger">
								<p>Error: ${error}</p>
							</div>
						</c:if>
						<div class="form-group">
							<label for="firstname" class="col-md-3 control-label">First	Name</label>
							<div class="col-md-9">
								<form:input class="form-control" path="bean.first_name" name="first_name"
									placeholder="First Name"/>
							</div>
						</div>
						<div class="form-group">
							<label for="lastname" class="col-md-3 control-label">Last Name</label>
							<div class="col-md-9">
								<form:input path="bean.last_name" class="form-control" name="last_name"
									placeholder="Last Name"/>
							</div>
						</div>
						<div class="form-group">
							<label for="phone" class="col-md-3 control-label">Phone Number</label>
							<div class="col-md-9">
								<form:input path="bean.phone_primary" class="form-control" name="phone_primary"
									placeholder="Phone Number"/>
							</div>
						</div>
						<div class="form-group">
							<label for="email" class="col-md-3 control-label">Email</label>
							<div class="col-md-9">
								<form:input path="bean.email" class="form-control" name="email"
									placeholder="Email Address"/>
							</div>
						</div>
						<div class="form-group">
							<label for="password" class="col-md-3 control-label">Password</label>
							<div class="col-md-9">
								<form:input path="bean.password" type="password" class="form-control" name="password"
									placeholder="Password"/>
							</div>
						</div>
						<div class="form-group">
							<label for="icode" class="col-md-3 control-label">Confirm Password</label>
							<div class="col-md-9">
								<form:input path="bean.confirm_password" type="password" class="form-control" name="confirm_password"
									placeholder="Confirm Password"/>
							</div>
						</div>
						<div class="form-group">
							<!-- Button -->
							<div class="col-md-offset-3 col-md-9">
								<!-- <button id="btn-signup" type="button" class="btn custom-button">
									<i class="icon-hand-right"></i>Sign Up
								</button> -->
								<input name="submit" type="submit" value="Sign Up" id="btn-signup"
									class="btn custom-button" />
								<span style="margin-left: 8px; margin-right: 8px">or</span> <a
									class="btn btn-primary social-login-btn social-facebook"
									href="#"><i class="fa fa-facebook"></i></a> <a
									class="btn btn-primary social-login-btn social-twitter"
									href="/auth/twitter"><i class="fa fa-twitter"></i></a> <a
									class="btn btn-primary social-login-btn social-google" href="#"><i
									class="fa fa-google-plus"></i></a>
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
	<script type="text/javascript" src="resources/js/custom-jssor.js"></script>
	<script type="text/javascript" src="resources/js/jssor.slider.js"></script>
	<script type="text/javascript" src="resources/js/jssor.js"></script>
</body>
</html>