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
<link rel="stylesheet" type="text/css" href="resources/slick/slick.css">
<link rel="stylesheet" type="text/css"
	href="resources/slick/slick-theme.css">
<link href="resources/css/custom.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
	<%@ include file="/WEB-INF/pages/vendor/templetes/header.jsp"%>

	<div class="container">
		<%@ include file="steps_header.jsp"%>
		<div class="row">
			<div class="col-md-12">
				<div class="col-md-12 vender-form mTop30">
					<h5 class="service-heading">Enter Demographic Details</h5>
					<form id="create_service_form" class="form-horizontal" role="form" action="vendor/update_service" method="POST">
						<c:if test="${not empty errors}">
							<div id="login-alert" class="alert alert-danger col-sm-12">
								<strong>Error!</strong> ${errors}
							</div>
						</c:if>
						<form:errors path="*" cssClass="error" />
						<form:hidden path="service_creation_bean.service_id" />
						<div class="form-group">
							<label for="firstname" class="col-md-2 control-label">Service *</label>
							<div class="col-md-4">
								<form:select class="form-control" name="" path="service_creation_bean.service_type">
									<form:option value="Select"/>
									<form:options items="${service_list}" itemLabel="displayName" />
								</form:select>
							</div>
						</div>
						<div class="form-group">
							<label for="lastname" class="col-md-2 control-label">Service Name *</label>
							<div class="col-md-4">
								<form:input type="text" class="form-control" name="lastname" path="service_creation_bean.service_name"
									placeholder="Service Name"/>
							</div>
						</div>
						<div class="form-group">
							<label for="phone" class="col-md-2 control-label">Phone	Number *</label>
							<div class="col-md-4">
								<form:input type="text" class="form-control" name="phone" path="service_creation_bean.service_phone" placeholder="Phone Number"/>
							</div>
						</div>
						<div class="form-group">
							<label for="email" class="col-md-2 control-label">Description</label>
							<div class="col-xs-12 col-md-4">
								<form:textarea name="" class="form-control" placeholder="Description" path="service_creation_bean.service_description"
									rows="4"/>
							</div>
						</div>
						<div class="form-group">
							<label for="email" class="col-md-2 control-label">Address 1 *</label>
							<div class="col-md-4 bottom-xs">
								<form:textarea name="" class="form-control" path="service_creation_bean.service_address1"
									placeholder="Address Line 1" rows="4"></form:textarea>
							</div>
							<label for="email" class="col-md-2 control-label">Address 2</label>
							<div class="col-md-4">
								<form:textarea name="" class="form-control" path="service_creation_bean.service_address2"
									placeholder="Address Line 2" rows="4"></form:textarea>
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-md-2 control-label">Country *</label>
							<div class="col-md-4">
								<%-- <form:input type="text" class="form-control" name="Country" path="service_creation_bean.service_country"
									placeholder="Country"/> --%>
								<form:select class="form-control" name="" path="service_creation_bean.service_country" id="_select_country">
									<form:option value="Select Country"/>
									<form:options items="${countries}" itemLabel="country_name" itemValue="country_name"/>
								</form:select>
							</div>
							<label for="" class="col-md-2 control-label">State *</label>
							<div class="col-md-4 bottom-xs"> 
								<%-- <form:input type="text" class="form-control" name="state" path="service_creation_bean.service_state"
									placeholder="State"/> --%>
									<form:select class="form-control" name="" path="service_creation_bean.service_state" id="_select_state">
										<form:option value="Select State"/>
										<form:options items="${states}" itemLabel="state_name" itemValue="state_name"/>
									</form:select>
							</div>
						</div>
						<div class="form-group">
							<label for="city" class="col-md-2 control-label">City *</label>
							<div class="col-md-4 bottom-xs">
								<%-- <form:input type="text" class="form-control" name="city" path="service_creation_bean.service_city"
									placeholder="City"/> --%>
									<form:select class="form-control" name="" path="service_creation_bean.service_city" id="_select_city">
										<form:option value="Select City"/>
										<form:options items="${cities}" itemLabel="city_name" itemValue="city_name"/>
									</form:select>
							</div>
							<label for="icode" class="col-md-2 control-label">Pin Code</label>
							<div class="col-md-4">
								<form:input type="text" class="form-control" name="pin" path="service_creation_bean.service_pin"
									placeholder="Pin Code"/>
							</div>
						</div>
						<div class="form-group">
							<label for="password" class="col-md-2 control-label">Web Site</label>
							<div class="col-md-4 bottom-xs">
								<form:input type="text" class="form-control" name="website" path="service_creation_bean.service_website"
									placeholder="Web Site"/>
							</div>
							<label for="icode" class="col-md-2 control-label">Email</label>
							<div class="col-md-4">
								<form:input type="text" class="form-control" name="email" path="service_creation_bean.service_email"
									placeholder="Email"/>
							</div>
						</div>
						<div class="form-group">
							<!-- Button -->
							<div class="col-md-offset-3 col-md-9 text-right">
									<input id="btn-signup" class="btn custom-button" type="submit" value="Save" name="_save1">
								<!-- <input name="submit" type="submit" value="Next" id="btn-signup"
									class="btn custom-button" /> -->
								<!-- <a href="vendor-step-3.html" id="btn-signup" type="button"
									class="btn custom-button"><i class="icon-hand-right"></i>Next</a> -->
									<input id="btn-signup" class="btn custom-button" type="submit" value="Next" name="_target1">
									<input id="btn-signup" class="btn custom-button" type="submit" value="Cancel" name="_cancel">
									<input id="btn-signup" class="btn custom-button" type="hidden" value="0" name="_page">
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
	<script src="resources/slick/slick.js" type="text/javascript"
		charset="utf-8"></script>
	<script src="resources/js/custom.js" type="text/javascript"></script>
	<script>
		$(document).ready(function() {
			$('.mesmerizing').slick({
				dots : true,
				infinite : false,
				speed : 300,
				slidesToShow : 4,
				slidesToScroll : 4,
				responsive : [ {
					breakpoint : 992,
					settings : {
						slidesToShow : 3,
						slidesToScroll : 3,
						infinite : true,
						dots : true
					}
				}, {
					breakpoint : 600,
					settings : {
						slidesToShow : 2,
						slidesToScroll : 2
					}
				}, {
					breakpoint : 480,
					settings : {
						slidesToShow : 2,
						slidesToScroll : 2
					}
				}
				// You can unslick at a given breakpoint now by adding:
				// settings: "unslick"
				// instead of a settings object
				]
			});

			// mouthwatering slide
			$('.mouthwatering').slick({
				dots : true,
				infinite : false,
				speed : 300,
				slidesToShow : 4,
				slidesToScroll : 4,
				responsive : [ {
					breakpoint : 1024,
					settings : {
						slidesToShow : 3,
						slidesToScroll : 3,
						infinite : true,
						dots : true
					}
				}, {
					breakpoint : 600,
					settings : {
						slidesToShow : 2,
						slidesToScroll : 2
					}
				}, {
					breakpoint : 480,
					settings : {
						slidesToShow : 2,
						slidesToScroll : 2
					}
				}
				// You can unslick at a given breakpoint now by adding:
				// settings: "unslick"
				// instead of a settings object
				]
			});

			// photography

			$('.photography').slick({
				dots : true,
				infinite : false,
				speed : 300,
				slidesToShow : 4,
				slidesToScroll : 4,
				responsive : [ {
					breakpoint : 1024,
					settings : {
						slidesToShow : 3,
						slidesToScroll : 3,
						infinite : true,
						dots : true
					}
				}, {
					breakpoint : 600,
					settings : {
						slidesToShow : 2,
						slidesToScroll : 2
					}
				}, {
					breakpoint : 480,
					settings : {
						slidesToShow : 2,
						slidesToScroll : 2
					}
				}
				// You can unslick at a given breakpoint now by adding:
				// settings: "unslick"
				// instead of a settings object
				]
			});
		});
	</script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#step_reg,#step_media,#step_preview").removeClass('active');
			$("#step_demograph").addClass('active');
		});
		
		$("#_select_country").change(function(){
		    var country_name = $(this).val();
		    alert(country_name);
		    $.ajax({
		        type: "GET",
		        url: "vendor/getStatesByCountry",
		        data: {"country_name" : country_name },
		        success: function(data){
		           var slctSubcat = $("#_select_state"), option= "";
		            slctSubcat.empty();
		            option = option + "<option value=''>Select State</option>";
		            for(var sb =0; sb<data.length; sb++){
		                option = option + "<option value='" + data[sb].state_name + "'>" +data[sb].state_name + "</option>";
		            }
		            slctSubcat.append(option);
		        },
		        error:function(){
		           alert("error");
		        }
		   });

		});
		
		$("#_select_state").change(function(){
		    var state_name = $(this).val();
		    alert(state_name);
		    $.ajax({
		        type: "GET",
		        url: "vendor/getCitiesByState",
		        data: {"state_name" : state_name },
		        success: function(data){
		           var slctSubcat = $("#_select_city"), option= "";
		            slctSubcat.empty();
		            option = option + "<option value=''>Select City</option>";
		            for(var sb =0; sb<data.length; sb++){
		                option = option + "<option value='" + data[sb].city_name + "'>" +data[sb].city_name + "</option>";
		            }
		            slctSubcat.append(option);
		        },
		        error:function(){
		           alert("error");
		        }
		   });

		});
	</script>
</body>
</html>