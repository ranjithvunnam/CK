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
	<%@ include file="/WEB-INF/pages/vendor/templetes/header.jsp"%>
	<div class="container">
		<%@ include file="steps_header.jsp"%>
		<div class="row">
			<div class="col-md-12">
				<div class="col-md-12 vender-form mTop30">
					<h5 class="service-heading">Please login to proceed</h5>
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
										${success}</div>
								</c:if>
								<div class="social-icons">
									<p>
										<a class="btn btn-primary social-login-btn social-facebook"
											onclick="facebookLogin()">Continue with &nbsp;&nbsp;<i
											class="fa fa-facebook"></i></a>
									</p>
									<p>
										<a class="btn btn-primary social-login-btn social-google"
											onclick="auth()">Continue with &nbsp;&nbsp;<i
											class="fa fa-google-plus"></i></a>
									</p>
									<!-- <a class="btn btn-primary social-login-btn social-twitter" href="/auth/twitter"><i class="fa fa-twitter"></i></a> -->
								</div>
								<form id="loginform" class="form-horizontal" role="form"
									action="<c:url value='/vendor/j_spring_security_check'/>"
									method="post">
									<div style="margin-bottom: 25px" class="input-group">
										<span class="input-group-addon"><i
											class="glyphicon glyphicon-user"></i></span> <input
											id="login-username" type="text" class="form-control"
											name="j_username" placeholder="Email">
									</div>
									<div style="margin-bottom: 25px" class="input-group">
										<span class="input-group-addon"><i
											class="glyphicon glyphicon-lock"></i></span> <input
											id="login-password" type="password" class="form-control"
											name="j_password" placeholder="Password">
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
										<a href="vendor/forgotpassword">Forgot password?</a>
									</div>
									<div style="margin-top: 10px" class="form-group">
										<!-- Button -->
										<div class="col-sm-12 controls text-center">
											<input name="submit" type="submit" value="Login"
												id="btn-login" class="btn custom-button" />
										</div>
									</div>
									<div class="form-group">
										<div class="col-md-12 control">
											<div
												style="border-top: 1px solid #888; padding-top: 15px; font-size: 85%">
												Don't have an account! <a href="vendor/register">Sign
													Up Here</a>
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
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
							action="vendor/socialregistration" method="POST">
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
	<%@ include file="/WEB-INF/pages/templetes/footer.jsp"%>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/js/custom.js" type="text/javascript"></script>
	<script
		src="https://cdn.jsdelivr.net/jquery.validation/1.15.1/jquery.validate.min.js"></script>
	<script src="resources/js/validations.js"></script>
	<script type="text/javascript">
	//Facebook
	window.fbAsyncInit = function() {
		FB.init({
			appId : '119347835388438',
			cookie : true,
			xfbml : true,
			version : 'v2.0',
			status : true
		});
	};

	(function(d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id)) {
			return;
		}
		js = d.createElement(s);
		js.id = id;
		js.src = "//connect.facebook.net/en_US/sdk.js";
		fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));

	function facebookLogin() {
		var FB = window.FB;
		FB.getLoginStatus(function(response) {
			statusChangeCallback(response);
		});
	}

	function statusChangeCallback(response) {
		console.log('statusChangeCallback');
		console.log(response);
		// The response object is returned with a status field that lets the
		// app know the current login status of the person.
		// Full docs on the response object can be found in the documentation
		// for FB.getLoginStatus().
		if (response.status === 'connected') {
			// Logged intconnectedo your app and Facebook.
			console.log('connected');
			FB.api('/me', {
				fields : 'first_name,last_name,email'
			}, function(response) {
				console.log(JSON.stringify(response));
				$
						.ajax({
							url : 'vendor/faceBookLogin',
							type : 'POST',
							contentType : 'application/json; charset=utf-8',
							data : JSON.stringify({
								first_name : response.first_name,
								last_name : response.last_name,
								email : response.email,
								fb_login_id : response.id,
								provider : 'FACEBOOK'
							}),
							success : function(data) {
								if (data.redirectUrl == null && data.bean != null) {
									$('input[name="first_name"]').val(
											data.bean.first_name);
									$('input[name="last_name"]').val(
											data.bean.last_name);
									$('input[name="email"]').val(data.bean.email);
									$('input[name="phone_primary"]').val(
											data.bean.phone_primary);
									$('input[name="google_id"]').val(
											data.bean.google_id);
									$('input[name="fb_login_id"]').val(
											data.bean.fb_login_id);
									$("#registration_modal").modal('show');
								}
								if (data.redirectUrl != null && data.bean == null) {
									window.location = data.redirectUrl;
								}
							},
							error : function(jqXHR, textStatus) {
								console.log('Error : ' + textStatus);
							}
						});
			});
		} else {
			console.log('Not connected');
			FB.login();
		}
	}

	//Google
	
	(function() {
	    var po = document.createElement('script');
	    po.type = 'text/javascript'; po.async = true;
	    po.src = 'https://plus.google.com/js/client:plusone.js';
	    var s = document.getElementsByTagName('script')[0];
	    s.parentNode.insertBefore(po, s);
	  })();
	
	var accessToken = null;
	var config = {
	    'client_id': '676581082318-gmqf9jp5njrmjp6064qe9j15f3g6j052.apps.googleusercontent.com',
	    'scope': 'https://www.googleapis.com/auth/userinfo.profile',
	}; 

	function auth() {
	 
	    gapi.auth.authorize(config, function() {
	        accessToken = gapi.auth.getToken().access_token;
	        console.log('We have got our token....');
	        console.log(accessToken);
	        console.log('We are now going to validate our token....');
	        validateToken();
	               
	    });
	}
	 
	function validateToken() {
	    $.ajax({
	        url: 'https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=' + accessToken,
	        data: null,
	        success: function(response){  
	            console.log('Our token is valid....');
	            console.log('We now want to get info about the user using our token....');
	            getUserInfo();
	        },  
	        error: function(error) {
	            console.log('Our token is not valid....');
	        },
	        dataType: "jsonp" 
	    });
	}
	 
	function getUserInfo() {
	    $.ajax({
	        url: 'https://www.googleapis.com/oauth2/v1/userinfo?access_token=' + accessToken,
	        data: null,
	        success: function(response) {
				console.log(response);
	            $.ajax({
					url : 'vendor/faceBookLogin',
					type : 'POST',
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify({
						first_name : response.given_name,
						last_name : response.family_name,
						email : response.email,
						google_id : response.id,
						provider : 'GOOGLE'
					}),
					success : function(data, textStatus, xhr) {
						if (data.redirectUrl == null && data.bean != null){
							$('input[name="first_name"]').val(data.bean.first_name);
							$('input[name="last_name"]').val(data.bean.last_name);
							$('input[name="email"]').val(data.bean.email);
							$('input[name="phone_primary"]').val(data.bean.phone_primary);
							$('input[name="google_id"]').val(data.bean.google_id);
							$('input[name="fb_login_id"]').val(data.bean.fb_login_id);
							$("#registration_modal").modal('show');
						}
						if (data.redirectUrl != null && data.bean == null) {
							window.location = data.redirectUrl;
						}
					},
					error : function(jqXHR, textStatus) {
						console.log('Error : '+textStatus);
					}
				});
	        },
	        dataType: "jsonp"
	    });
	}
	</script>
</body>
</html>