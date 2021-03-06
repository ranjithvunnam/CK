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
<link href="resources/css/custom.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<%@ include file="templetes/simple_header.jsp"%>

	<div class="container">
		<div id="signupbox" style="margin-top: 50px"
			class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
			<div class="panel panel-info">
				<div class="panel-heading">
					<div class="panel-title">Sign Up</div>
					<div
						style="float: right; font-size: 85%; position: relative; top: -18px">
						<a id="signinlink" href="login">Already joined? &nbsp;
							Sign In</a>
					</div>
				</div>
				<div class="panel-body">
					<form id="signupform" class="form-horizontal" role="form" action="registration" method="POST">
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
								<span style="margin-left: 8px; margin-right: 8px">or</span>
								<a class="btn btn-primary social-login-btn social-facebook"	onclick="facebookLogin()">
									<i class="fa fa-facebook"></i>
								</a> 
								<a class="btn btn-primary social-login-btn social-google" onclick="auth()">
									<i class="fa fa-google-plus"></i>
								</a>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
<!-- Social registration complete Modal -->
	<div class="modal fade" id="registration_modal" role="dialog">
		<div class="modal-dialog modal-lg">
			<!-- Modal content-->
			<div class="modal-content" style="border-radius: unset;">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Create your personal account</h4>
				</div>
				<div class="modal-body" id="mod_comm" style="overflow-x: scroll;">
					<div class="col-md-12">
						<form id="signupform" class="form-horizontal" role="form"
							action="socialregistration" method="POST">
							<div class="form-group">
								<label for="firstname" class="col-md-3 control-label">First
									Name</label>
								<div class="col-md-9">
									<form:input class="form-control" path="bean.first_name"
										name="first_name" placeholder="First Name" />
								</div>
							</div>
							<div class="form-group">
								<label for="lastname" class="col-md-3 control-label">Last
									Name</label>
								<div class="col-md-9">
									<form:input path="bean.last_name" class="form-control"
										name="last_name" placeholder="Last Name" />
								</div>
							</div>
							<div class="form-group">
								<label for="phone" class="col-md-3 control-label">Phone
									Number</label>
								<div class="col-md-9">
									<form:input path="bean.phone_primary" class="form-control"
										name="phone_primary" placeholder="Phone Number" />
								</div>
							</div>
							<div class="form-group">
								<label for="email" class="col-md-3 control-label">Email</label>
								<div class="col-md-9">
									<form:input path="bean.email" class="form-control" name="email"
										placeholder="Email Address" />
								</div>
							</div>
							<div class="form-group">
								<label for="password" class="col-md-3 control-label">Password</label>
								<div class="col-md-9">
									<form:input path="bean.password" type="password"
										class="form-control" name="password" placeholder="Password" />
								</div>
							</div>
							<form:hidden path="bean.google_id" name="google_id"/>
							<form:hidden path="bean.fb_login_id" name="fb_login_id"/>
							<div class="form-group">
								<label for="icode" class="col-md-3 control-label">Confirm
									Password</label>
								<div class="col-md-9">
									<form:input path="bean.confirm_password" type="password"
										class="form-control" name="confirm_password"
										placeholder="Confirm Password" />
								</div>
							</div>
							<div class="form-group" style="text-align: right;">
								<!-- Button -->
								<div class="col-md-offset-3 col-md-9">
									<input name="submit" type="submit" value="Sign Up"
										id="btn-signup" class="btn custom-button" />
								</div>
							</div>
						</form>
					</div>
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
	<script
		src="https://cdn.jsdelivr.net/jquery.validation/1.15.1/jquery.validate.min.js"></script>
	<script src="resources/js/validations.js"></script>
	<script src="resources/js/socialauth.js"></script>
</body>
</html>