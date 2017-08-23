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
<link href="resources/css/custom.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
	<script type="text/javascript">
  (function() {
    var po = document.createElement('script');
    po.type = 'text/javascript'; po.async = true;
    po.src = 'https://plus.google.com/js/client:plusone.js';
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(po, s);
  })();
  </script>
</head>
<body>
	<%@ include file="templetes/simple_header.jsp"%>
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
							<a class="btn btn-primary social-login-btn social-facebook" onclick="facebookLogin()">Continue with &nbsp;&nbsp;<i class="fa fa-facebook"></i></a>
						</p>
						<p>
                            <a class="btn btn-primary social-login-btn social-google" onclick="auth()">Continue with &nbsp;&nbsp;<i class="fa fa-google-plus"></i></a>
                        </p>
					</div>
					<form id="loginform" class="form-horizontal" role="form"
						action="<c:url value='/j_spring_security_check'/>" method="post">
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

	<%@ include file="templetes/footer.jsp"%>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/js/custom.js" type="text/javascript"></script>
	<script type="text/javascript">
	
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
				FB.api('/me', {fields : 'first_name,last_name,email'}, function(response) {
					console.log(JSON.stringify(response));
					$.ajax({
						url : 'faceBookLogin',
						type : 'POST',
						contentType : 'application/json; charset=utf-8',
						data : JSON.stringify({
							first_name : response.first_name,
							last_name : response.last_name,
							email : response.email,
							fb_login_id : response.id,
							provider : 'FACEBOOK'
						}),
						success : function(msg) {
							alert("sucess");
							window.location.reload();
						},
						error : function(jqXHR, textStatus) {
							alert(textStatus);
						}
					});
				});
			} else {
				console.log('Not connected');
				FB.login();
			}
		}

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
	</script>
	<!-- <script type="text/javascript">
	var gpclass = (function(){
	
	//Defining Class Variables here
	var response = undefined;
	return {
		//Class functions / Objects
		
		mycoddeSignIn:function(response){
			// The user is signed in
			if (response['access_token']) {
				console.log(response);
				//Get User Info from Google Plus API
				gapi.client.load('plus','v1',this.getUserInformation);
				
			} else if (response['error']) {
				// There was an error, which means the user is not signed in.
				//alert('There was an error: ' + authResult['error']);
			}
		},
		
		getUserInformation: function(){
			var request = gapi.client.plus.people.get( {'userId' : 'me'} );
			request.execute( function(profile) {
				var email = profile['emails'].filter(function(v) {
					return v.type === 'account'; // Filter out the primary email
				})[0].value;
				console.log(JSON.stringify(profile));
				console.log("email "+email);
				console.log("first name "+profile["name"].givenName);
				console.log("last name "+profile["name"].familyName);
				console.log("id "+profile.id);
				$.ajax({
					url : 'faceBookLogin',
					type : 'POST',
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify({
						first_name : profile["name"].givenName,
						last_name : profile["name"].familyName,
						email : email,
						login_id : profile.id,
						provider : 'GOOGLE'
					}),
					success : function(msg) {
						alert("sucess");
						window.location.reload();
					},
					error : function(jqXHR, textStatus) {
						alert(textStatus);
					}
				});
			});
		}
	
	}; //End of Return
	})();
	
	function mycoddeSignIn(gpSignInResponse){
		gpclass.mycoddeSignIn(gpSignInResponse);
	}
	</script> -->
	<script type="text/javascript">
		var accessToken;
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
		            console.log('We have gotten info back....');
		            console.log(response);
		            //$('#user').html(response.name);
		            $.ajax({
						url : 'faceBookLogin',
						type : 'POST',
						contentType : 'application/json; charset=utf-8',
						data : JSON.stringify({
							first_name : response.given_name,
							last_name : response.family_name,
							email : response.email,
							google_id : response.id,
							provider : 'GOOGLE'
						}),
						success : function(msg) {
							alert("sucess");
							window.location.reload();
						},
						error : function(jqXHR, textStatus) {
							alert(textStatus);
						}
					});
		        },
		        dataType: "jsonp"
		    });
		}          
	</script>
</body>
</html>