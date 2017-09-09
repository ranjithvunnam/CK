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
				<div class="col-xs-12 col-md-12 upload-images">
					<div class="col-xs-12 col-md-12 vender-form mTop30">
						<div class="col-xs-12 col-md-4 big-image bottom-xs text-center">
							<h5 class="service-heading pull-left">Upload Images and Videos</h5>
							<c:if test="${not empty errors}">
								<div id="login-alert" class="alert alert-danger col-sm-12">
									<strong>Error!</strong> ${errors}
								</div>
							</c:if>
							<form:hidden path="service_creation_bean.service_id" />
							<img id="showSelectionImg" src="resources/images/banner2.jpg"
								alt=""> <label for="file-upload"
								class="custom-file-upload mTop10"> <i
								class="fa fa-cloud-upload"></i> Custom Upload
							</label>
							<input id="file-upload" type="file" name="images" multiple="multiple" path="service_creation_bean.images"/>
						</div>
						<form id="create_service_form" class="form-horizontal" role="form" enctype="multipart/form-data" action="vendor/update_service" method="POST">
						<div class="col-xs-12 col-md-8">
							<hr class="display-xs">
							<h5 class="service-heading">Your Uploded Files</h5>
							<div class="uploaded-container">
								<!-- Data will be added dynamically -->
								<c:if test="${not empty service_creation_bean.imagesBean}">
									<c:forEach items="${service_creation_bean.imagesBean}" var="images" varStatus="img_bean_status">
										<div class="thumb-images">
			                                <img src="${images.url}" alt="" id="${images.url}">
			                                <div class="thumb-close"><i class="fa fa-times" aria-hidden="true"></i></div>
			                            </div>
									</c:forEach>
								</c:if>
								<c:if test="${not empty service_creation_bean.videosBeans}">
									<c:forEach items="${service_creation_bean.videosBeans}" var="videos" varStatus="video_bean_status">
										<div class="thumb-images">
			                                <img src="${videos.video_thumbnail}" alt="" id="${videos.video_url}">
			                                <div class="thumb-close"><i class="fa fa-times" aria-hidden="true"></i></div>
			                            </div>
									</c:forEach>
								</c:if>
							</div>
						</div>
						<div
							class="col-md-12 col-sm-12 col-xs-12 service-box-right mTop10">
							<h5 class="service-heading">Amenities</h5>

							<div class="icons-div ">
								<c:if
									test="${service_creation_bean.service_type eq 'SER_VENUE' || service_creation_bean.service_type eq 'SER_CATERERS'}">
									<div class="specifications">
										<img src="resources/images/icons/capacity.png" alt="">
										<p>Capacity</p>
										<form:select class="form-control custom-select" name=""
											path="service_creation_bean.amenityBean.capacity"
											style="height: 35px;">
											<form:option value="">Select</form:option>
											<form:option value="500 - 1000">500 - 1000</form:option>
											<form:option value="1000 - 1500">1000 - 1500</form:option>
											<form:option value="1500-2000">1500-2000</form:option>
											<form:option value="2500 +">2500 +</form:option>
										</form:select>
									</div>
								</c:if>
								<c:if
									test="${service_creation_bean.service_type eq 'SER_VENUE'}">
									<div class="specifications">
										<img src="resources/images/icons/rooms.png" alt="">
										<p>Rooms</p>
										<form:select class="form-control custom-select" name=""
											path="service_creation_bean.amenityBean.rooms"
											style="height: 35px;">
											<form:option value="">Select</form:option>
											<form:option value="10">10</form:option>
											<form:option value="15">15</form:option>
											<form:option value="25">25</form:option>
										</form:select>
									</div>
								</c:if>
								<div class="specifications">
									<img src="resources/images/icons/price.png" alt="">
									<p>Price</p>
									<form:input type="text" class="form-control select-custom" name="price"
										path="service_creation_bean.amenityBean.price" />
								</div>
								<!-- Air Condition -->
								<c:if test="${service_creation_bean.service_type eq 'SER_VENUE'}">
									<div class="specifications">
										<img src="resources/images/icons/ac.png" alt="">
										<p>Ac</p>
										<div class="checkbox-div">
											<label class="custom_switch">
					                            <form:checkbox id="togBtn" path="service_creation_bean.amenityBean.air_condition"/>
					                            <div class="slider round">
					                                <!--ADDED HTML --><span class="on"><i class="fa fa-check" aria-hidden="true"></i></span><span class="off"></span>
					                                <!--END-->
					                            </div>
					                        </label>
										</div>
									</div>
								</c:if>
								<!-- Liquor -->
								<c:if test="${service_creation_bean.service_type eq 'SER_VENUE'}">
									<div class="specifications">
										<img src="resources/images/icons/liquor.png" alt="">
										<p>Liquor</p>
										<div class="checkbox-div">
											<label class="custom_switch">
					                            <form:checkbox id="togBtn" path="service_creation_bean.amenityBean.liquor"/>
					                            <div class="slider round">
					                                <!--ADDED HTML --><span class="on"><i class="fa fa-check" aria-hidden="true"></i></span><span class="off"></span>
					                                <!--END-->
					                            </div>
					                        </label>
										</div>
									</div>
								</c:if>
								<!-- Parking -->
								<c:if test="${service_creation_bean.service_type eq 'SER_VENUE'}">
									<div class="specifications">
										<img src="resources/images/icons/car.png" alt="">
										<p>Parking</p>
										<div class="checkbox-div">
											<label class="custom_switch">
					                            <form:checkbox id="togBtn" path="service_creation_bean.amenityBean.parking"/>
					                            <div class="slider round">
					                                <!--ADDED HTML --><span class="on"><i class="fa fa-check" aria-hidden="true"></i></span><span class="off"></span>
					                                <!--END-->
					                            </div>
					                        </label>
										</div>
									</div>
								</c:if>
								<!-- WiFi -->
								<c:if test="${service_creation_bean.service_type eq 'SER_VENUE'}">
									<div class="specifications">
										<img src="resources/images/icons/wifi.png" alt="">
										<p>Wifi</p>
										<div class="checkbox-div">
											<label class="custom_switch">
					                            <form:checkbox id="togBtn" path="service_creation_bean.amenityBean.wifi"/>
					                            <div class="slider round">
					                                <!--ADDED HTML --><span class="on"><i class="fa fa-check" aria-hidden="true"></i></span><span class="off"></span>
					                                <!--END-->
					                            </div>
					                        </label>
										</div>
									</div>
								</c:if>
								<c:if test="${service_creation_bean.service_type eq 'SER_CATERERS' || service_creation_bean.service_type eq 'SER_PHOTOGRAPHY' 
									|| service_creation_bean.service_type eq 'SER_ENTERTAINERS' || service_creation_bean.service_type eq 'SER_BEAUTICIANS'}">
									<div class="specifications">
										<img src="resources/images/icons/rooms.png" alt="">
										<p>Type</p>
										<form:input type="text" class="form-control select-custom" name="type" path="service_creation_bean.amenityBean.type"/>
									</div>
								</c:if>
								<c:if test="${service_creation_bean.service_type eq 'SER_CATERERS'}">
									<div class="specifications">
										<img src="resources/images/icons/rooms.png" alt="">
										<p>Cusine</p>
										<form:input type="text" class="form-control" name="cusine" path="service_creation_bean.amenityBean.cusine"/>
									</div>
								</c:if>
								<c:if test="${service_creation_bean.service_type eq 'SER_CATERERS' || service_creation_bean.service_type eq 'SER_EVENT_PLANNERS'
									|| service_creation_bean.service_type eq 'SER_EVENT_DESIGNERS' || service_creation_bean.service_type eq 'SER_PANDITS'
									|| service_creation_bean.service_type eq 'SER_CHOREOGRAPHERS'}">
									<div class="specifications">
										<img src="resources/images/icons/rooms.png" alt="">
										<p>Occasion</p>
										<form:input type="text" class="form-control select-custom" name="occasion" path="service_creation_bean.amenityBean.occasion"/>
									</div>
								</c:if>
								<c:if test="${service_creation_bean.service_type eq 'SER_BEAUTICIANS'}">
									<div class="specifications">
										<img src="resources/images/icons/rooms.png" alt="">
										<p>Gender</p>
										<form:select class="form-control custom-select" name="gender" path="service_creation_bean.amenityBean.gender">
											<option value="">Select</option>
											<option value="Women">Women</option>
											<option value="Men">Men</option>
											<option value="Unisex">Unisex</option>
										</form:select>
									</div>
								</c:if>
								<c:if test="${service_creation_bean.service_type eq 'SER_CHOREOGRAPHERS'}">
									<div class="specifications">
										<img src="resources/images/icons/rooms.png" alt="">
										<p>Dance Style</p>
										<form:input type="text" class="form-control select-custom" name="dance_style" path="service_creation_bean.amenityBean.dance_style"/>
									</div>
								</c:if>
								<c:if test="${service_creation_bean.service_type eq 'SER_TRAVEL'}">
									<div class="specifications">
										<img src="resources/images/icons/rooms.png" alt="">
										<p>Fleet</p>
										<form:input type="text" class="form-control select-custom" name="fleet" path="service_creation_bean.amenityBean.fleet"/>
									</div>
								</c:if>
							</div>
						</div>

						<!-- Button -->
						<div
							class="col-xs-12 col-md-offset-3 col-md-9 text-right mTop10 pbot10">
							<input id="btn-signup" class="btn custom-button" type="submit"
								value="Previous" name="_target0"> <input id="btn-signup"
								class="btn custom-button" type="submit" value="Next"
								name="_target2"> <input id="btn-signup"
								class="btn custom-button" type="submit" value="Save"
								name="_save2"> <input id="btn-signup"
								class="btn custom-button" type="submit" value="Cancel"
								name="_cancel"> <input id="btn-signup"
								class="btn custom-button" type="hidden" value="1" name="_page">
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
			$('#file-upload').change(function(e){
	        	   var oMyForm = new FormData();
	               oMyForm.append("file", this.files[0]);
	               $.ajax({
						url : 'vendor/uploadImage',
						type : 'POST',
						contentType : 'application/json; charset=utf-8',
						data : oMyForm,
						enctype: 'multipart/form-data',
						processData: false, 
	                    contentType:false,
						success : function(msg) {
							var createImageContainer = '<div class="thumb-images"><img src="'+msg.THUMBNAIL+'" alt="" id="'+msg.URL+'">'+
			                '<div class="thumb-close"><i class="fa fa-times" aria-hidden="true"></i></div></div>';
			                $(".uploaded-container").append(createImageContainer);
						},
						error : function(jqXHR, textStatus) {
							alert(textStatus);
						}
					});
		    });
		    // upload-images
				$(".uploaded-container").on("click", ".thumb-images", function() {
				  $('.upload-images .thumb-close').hide();
					$(this).children('.thumb-close').show();
				});
				$(".uploaded-container").on("click", ".thumb-images img", function() {
					var selectedImage = $(this).attr('src');
					$(".upload-images #showSelectionImg").attr("src", selectedImage);

				});
				$(".uploaded-container").on("click", ".thumb-close", function() {
					var index = $(this).siblings("img").attr("id");
					var _this = $(this);
					console.log("Close index "+index, $(this));
					var removeForm = new FormData();
					removeForm.append("filePath", index);
					$.ajax({
						url : 'vendor/removeImage',
						type : 'POST',
						contentType : 'application/json; charset=utf-8',
						data : removeForm,
						processData: false, 
	                    contentType:false,
						success : function(msg) {
							console.log("this",_this);
							_this.parent().remove();
						},
						error : function(jqXHR, textStatus) {
							console.log(textStatus);
							alert(textStatus);
						}
					});
				});

				// get smallest image height
				var imageHeight = 0;
				$(".upload-images .thumb-images").each(function(i, e) {
					if (imageHeight < $(e).height()) {
						imageHeight = $(e).height();
					}
					console.log(imageHeight);
				});
				$(".upload-images .thumb-images").css({ 'height': imageHeight + "px" });
		});
	</script>
</body>
</html>