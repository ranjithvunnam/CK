<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>CelebrateKaro</title>
<link rel="shortcut icon" href="resources/images/logo.ico" type="image/x-icon">
<base
	href="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/" />
<!-- Bootstrap -->
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/custom.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<%@ include file="templetes/simple_header.jsp"%>
	<div class="container-fluid" id="contact-us">
		<div class="row">
			<div class="col-md-12">
				<section id="contact" style="">
					<div class="container">
						<div class="row">
							<div class="about_our_company pBot10">
								<h1>Contact Us</h1>
								<div class="titleline-icon"></div>
								<p>Please fill the form below</p>
							</div>
						</div>
						<div class="row">
							<div class="col-md-8">
								<c:if test="${not empty success}">
									<div id="signupalert" class="alert alert-success">
										<p>${success}</p>
									</div>
								</c:if>
								<c:if test="${not empty error}">
									<div id="signupalert" class="alert alert-danger">
										<p>Error: ${error}</p>
									</div>
								</c:if>
							</div>
						</div>
						<div class="row">
							<div class="col-md-8">
									<form name="contactusform" id="contactForm" role="form" action="ContactUs" method="POST">
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<form:input type="text" name="name" class="form-control"
													placeholder="Your Name *" id="name" required=""
													path="contactUs.name"
													data-validation-required-message="Please enter your name." maxlength="45"/>
												<p class="help-block text-danger"></p>
											</div>
											<div class="form-group">
												<form:input type="email" name="email" class="form-control"
													placeholder="Your Email *" id="email" required=""
													path="contactUs.email"
													data-validation-required-message="Please enter your email address." maxlength="45"/>
												<p class="help-block text-danger"></p>
											</div>
											<div class="form-group">
												<form:input type="text" maxlength="10" name="phone"
													class="form-control" placeholder="Your Phone *" id="phone"
													required="" path="contactUs.phone"
													data-validation-required-message="Please enter your phone number." />
												<p class="help-block text-danger"></p>
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<form:textarea class="form-control" name="message"
													placeholder="Your Message *" id="message" required=""
													path="contactUs.message"
													data-validation-required-message="Please enter a message." maxlength="1024"></form:textarea>
												<p class="help-block text-danger"></p>
											</div>
										</div>
										<div class="clearfix"></div>
										<div class="col-lg-12 text-center" style="margin-bottom: 10px;">
											<div id="success"></div>
											<input name="submit" type="submit" value="Submit" class="btn custom-button" />
											<button type="reset" class="btn custom-button">Reset</button>
										</div>
									</div>
									</form>
							</div>
							<div class="col-md-4">
								<p>
									<strong><i class="fa fa-map-marker"></i> Address</strong> <br>
									Madhapur Hyderabad 800081
								</p>
								<p>
									<strong><i class="fa fa-phone"></i> Phone Number</strong> <br>
									(+91)712345600
								</p>
								<p>
									<strong><i class="fa fa-envelope"></i> Email Address</strong> <br>
									celeberatekaro@gmail.com
								</p>
								<p></p>
							</div>
						</div>
					</div>
				</section>
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
</body>
</html>