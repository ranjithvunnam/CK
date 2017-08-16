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
<title>WISP</title>
<base
	href="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/" />
<!-- Bootstrap -->
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="resources/slick/slick.css">
<link rel="stylesheet" type="text/css" href="resources/slick/slick-theme.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="resources/css/star-rating.css">
<link rel="stylesheet" href="resources/css/jssor.css">
<link rel="stylesheet" type="text/css" href="resources/css/pignose.calendar.css" />
<link href="resources/css/custom.css" rel="stylesheet">
<link rel="stylesheet" href="resources/css/bootstrap-datepicker.min.css">
<style>
	.jssora05l,.jssora05r,.jssora05ldn,.jssora05rdn {
		position: absolute;
		cursor: pointer;
		display: block;
		background: url(resources/images/a17.png) no-repeat;
		overflow: hidden;
	}
	
	.jssora05l {
		background-position: -10px -40px;
	}
	
	.jssora05r {
		background-position: -70px -40px;
	}
	
	.jssora05l:hover {
		background-position: -130px -40px;
	}
	
	.jssora05r:hover {
		background-position: -190px -40px;
	}
	
	.jssora05ldn {
		background-position: -250px -40px;
	}
	
	.jssora05rdn {
		background-position: -310px -40px;
	}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/pages/vendor/templetes/header.jsp"%>

	<div class="container">
		<%@ include file="steps_header.jsp"%>
		<div class="row">
			<form id="create_service_form" class="form-horizontal" role="form" action="vendor/update_service.do" method="POST">
			<div class="col-xs-12 col-md-12 upload-images">
				<div class="col-xs-12 col-md-12 vender-form mTop30">
					<div class="col-xs-12 col-md-4 big-image bottom-xs text-center">
						<h5 class="service-heading pull-left">Preview Page</h5>
					</div>
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12 mTop10">
							<div
								class="col-md-12 col-sm-12 col-xs-12 service-box-right white-bg">
								<h5 class="service-heading">${service_creation_bean.service_name}</h5>
								<p class="address">${service_creation_bean.service_description}</p>
								
							</div>
						</div>
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="col-md-12 col-sm-12 col-xs-12 service-box-right white-bg">
								<p class="name">${service_creation_bean.service_name}</p>
								<p class="contact">${service_creation_bean.service_address1} ${service_creation_bean.service_address2} ${service_creation_bean.service_phone}</p>
								<p class="web">${service_creation_bean.service_website}</p>
							</div>
						</div>
					</div>
					<c:if test="${not empty service_creation_bean.imagesBean || not empty service_creation_bean.videosBeans}">
						<div class="row">
							<div class="col-md-12 col-sm-12 col-xs-12 service-box-gallery mTop10">
								<div id="slider1_container" class="service_slider"
									style="position: relative; top: 0px; left: 0px; width: 840px; height: 480px; background: #191919; overflow: hidden;">
									<!-- Loading Screen -->
									<div u="loading" style="position: absolute; top: 0px; left: 0px;">
										<div
											style="filter: alpha(opacity = 70); opacity: 0.7; position: absolute; display: block; background-color: #000000; top: 0px; left: 0px; width: 100%; height: 100%;">
										</div>
										<div
											style="position: absolute; display: block; background: url(resources/images/loading.gif) no-repeat center center; top: 0px; left: 0px; width: 100%; height: 100%;">
										</div>
									</div>
									<!-- Slides Container -->
									<div u="slides"	style="cursor: move; position: absolute; left: 0px; top: 0px; width: 720px; height: 480px; overflow: hidden;">
										<!-- Images -->
										<c:forEach items="${service_creation_bean.imagesBean}" var="images" varStatus="img_bean_status">
				                            <div>
												<img u="image" src="${images.url}" /> <img u="thumb"
													src="${images.url}" />
											</div>
										</c:forEach>
										<!-- Videos -->
										<c:forEach items="${service_creation_bean.videosBeans}" var="videos" varStatus="video_bean_status">
				                            <div>
												<video class="gallery_video" width="100%" src="${videos.video_url}"></video>
												<img u="thumb" src="${videos.video_thumbnail}" />
												<div class="playpause"></div>
											</div>
										</c:forEach>
									</div>
									<!-- Arrow Navigator Skin Begin -->
									<!-- Arrow Left -->
									<span u="arrowleft" class="jssora05l"
										style="width: 40px; height: 40px; top: 158px; left: 30px;">
									</span>
									<!-- Arrow Right -->
									<span u="arrowright" class="jssora05r"
										style="width: 40px; height: 40px; top: 158px; right: 150px">
									</span>
									<!-- Arrow Navigator Skin End -->
									<!-- Thumbnail Navigator Skin 02 Begin -->
									<div u="thumbnavigator" class="jssort02"
										style="position: absolute; width: 120px; height: 480px; left: 720px; bottom: 0px;">
										<!-- Thumbnail Item Skin Begin -->
										<div u="slides" style="cursor: move;">
											<div u="prototype" class="p"
												style="position: absolute; width: 99px; height: 66px; top: 0; left: 0;">
												<div class=w>
													<div u="thumbnailtemplate"
														style="width: 100%; height: 100%; border: none; position: absolute; top: 0; left: 0;"></div>
												</div>
												<div class=c></div>
											</div>
										</div>
										<!-- Thumbnail Item Skin End -->
									</div>
									<!-- Thumbnail Navigator Skin End -->
								</div>
							</div>
							<div class="col-md-12 col-sm-12 col-xs-12 mTop10">
								<div class="col-md-12 col-sm-12 col-xs-12 service-box-right white-bg">
									<div class="ratings">
										Photos <span class="photos">${service_creation_bean.imagesBean.size()}</span> videos <span class="videos">${service_creation_bean.videosBeans.size()}</span>
									</div>
								</div>
							</div>
						</div>
					</c:if>
					<div class="row">
						<div class="col-md-12">
							<div
								class="col-md-12 col-sm-12 col-xs-12 service-box-right white-bg mTop10 pbot10">
								<h5 class="service-heading">Amenities</h5>
								<div class="icons-div">
									<c:if test="${service_creation_bean.service_type eq 'SER_VENUE' || service_creation_bean.service_type eq 'SER_CATERERS'}">
										<div class="specifications">
											<img src="resources/images/icons/capacity.png" alt="">
											<p>Capacity</p>
											<p>${service_creation_bean.amenityBean.capacity}</p>
										</div>
									</c:if>
									<c:if test="${service_creation_bean.service_type eq 'SER_VENUE'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Rooms</p>
											<p>${service_creation_bean.amenityBean.rooms}</p>
										</div>
									</c:if>
									<div class="specifications">
										<img src="resources/images/icons/price.png" alt="">
											<p>Price</p>
											<p>${service_creation_bean.amenityBean.price}</p>
									</div>
									<c:if test="${service_creation_bean.service_type eq 'SER_VENUE'}">
										<div class="specifications">
											<img src="resources/images/icons/car.png" alt="">
											<p>Parking</p>
											<a class="${service_creation_bean.amenityBean.parking ? 'active' : ''}">Yes</a>
											<a class="${service_creation_bean.amenityBean.parking ? '' : 'active'}">No</a>
										</div>
									</c:if>
									<c:if test="${service_creation_bean.service_type eq 'SER_VENUE'}">
										<div class="specifications">
											<img src="resources/images/icons/liquor.png" alt="">
											<p>Liquor</p>
											<a class="${service_creation_bean.amenityBean.liquor ? 'active' : ''}">Yes</a>
											<a class="${service_creation_bean.amenityBean.liquor ? '' : 'active'}">No</a>
										</div>
									</c:if>
									<c:if test="${service_creation_bean.service_type eq 'SER_VENUE'}">
										<div class="specifications">
											<img src="resources/images/icons/ac.png" alt="">
											<p>Ac</p>
											<a class="${service_creation_bean.amenityBean.air_condition ? 'active' : ''}">Yes</a>
											<a class="${service_creation_bean.amenityBean.air_condition ? '' : 'active'}">No</a>
										</div>
									</c:if>
									<c:if test="${service_creation_bean.service_type eq 'SER_VENUE'}">
										<div class="specifications">
											<img src="resources/images/icons/wifi.png" alt="">
											<p>Wifi</p>
											<a class="${service_creation_bean.amenityBean.wifi ? 'active' : ''}">Yes</a>
											<a class="${service_creation_bean.amenityBean.wifi ? '' : 'active'}">No</a>
										</div>
									</c:if>
									<c:if test="${service_creation_bean.service_type eq 'SER_CATERERS' || service_creation_bean.service_type eq 'SER_PHOTOGRAPHY' 
										|| service_creation_bean.service_type eq 'SER_ENTERTAINERS' || service_creation_bean.service_type eq 'SER_BEAUTICIANS'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Type</p>
											<p>${service_creation_bean.amenityBean.type}</p>
										</div>
									</c:if>
									<c:if test="${service_creation_bean.service_type eq 'SER_CATERERS'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Cusine</p>
											<p>${service_creation_bean.amenityBean.cusine}</p>
										</div>
									</c:if>
									<c:if test="${service_creation_bean.service_type eq 'SER_CATERERS' || service_creation_bean.service_type eq 'SER_EVENT_PLANNERS'
										|| service_creation_bean.service_type eq 'SER_EVENT_DESIGNERS' || service_creation_bean.service_type eq 'SER_PANDITS'
										|| service_creation_bean.service_type eq 'SER_CHOREOGRAPHERS'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Occasion</p>
											<p>${service_creation_bean.amenityBean.occasion}</p>
										</div>
									</c:if>
									<c:if test="${service_creation_bean.service_type eq 'SER_BEAUTICIANS'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Gender</p>
											<p>${service_creation_bean.amenityBean.gender}</p>
										</div>
									</c:if>
									<c:if test="${service_creation_bean.service_type eq 'SER_CHOREOGRAPHERS'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Dance Style</p>
											<p>${service_creation_bean.amenityBean.dance_style}</p>
										</div>
									</c:if>
									<c:if test="${service_creation_bean.service_type eq 'SER_TRAVEL'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Fleet</p>
											<p>${service_creation_bean.amenityBean.fleet}</p>
										</div>
									</c:if>
								</div>
							</div>
						</div>
					</div>
					<!-- Button -->
					<div
						class="col-xs-12 col-md-offset-3 col-md-9 text-right mTop10 pbot10">
							<input id="btn-signup" class="btn custom-button" type="submit" value="Previous" name="_target1">
							<input id="btn-signup" class="btn custom-button" type="submit" value="Finish" name="_finish">
							<input id="btn-signup" class="btn custom-button" type="submit" value="Cancel" name="_cancel">
							<input id="btn-signup" class="btn custom-button" type="hidden" value="2" name="_page">
					</div>
				</div>
			</div>
			</form>
		</div>
	</div>

	<%@ include file="/WEB-INF/pages/templetes/footer.jsp"%>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script type="text/javascript"
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script type="text/javascript" src="resources/js/moment.latest.min.js"></script>
	<script type="text/javascript" src="resources/js/pignose.calendar.js"></script>
	<script src="resources/js/bootstrap-datepicker.min.js"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="resources/slick/slick.js" charset="utf-8"></script>
	<script type="text/javascript" src="resources/js/custom.js"></script>
	<script type="text/javascript" src="resources/js/star-rating.js"></script>
	<script type="text/javascript" src="resources/js/custom-jssor.js"></script>
	<script type="text/javascript" src="resources/js/jssor.slider.js"></script>
	<script type="text/javascript" src="resources/js/jssor.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#step_reg,#step_demograph,#step_preview").removeClass('active');
			$("#step_media").addClass('active');
		});
	</script>
	<script>
        $(document).ready(function(){
            $('.service-small-slider').slick({
              dots: true,
              infinite: false,
              speed: 300,
              slidesToShow: 7,
              slidesToScroll: 4,
              responsive: [
                {
                  breakpoint: 992,
                  settings: {
                    slidesToShow: 5,
                    slidesToScroll: 3,
                    infinite: true,
                    dots: true
                  }
                },
                {
                  breakpoint: 600,
                  settings: {
                    slidesToShow: 4,
                    slidesToScroll: 2
                  }
                },
                {
                  breakpoint: 480,
                  settings: {
                    slidesToShow: 2,
                    slidesToScroll: 1
                  }
                }
              ]
            });
        });
    </script>
    <script type="text/javascript">
		$("#rating").rating({
                starCaptions: function (val) {
                    console.log(val);
					$("#rating").val(val);
                    if (val < 3) {
                        return val;
                    } else {
                        return 'high';
                    }
                },
                starCaptionClasses: function (val) {
                    if (val < 3) {
                        return 'label label-danger';
                    } else {
                        return 'label label-success';
                    }
                },
                hoverOnClear: false
        });
	</script>
</body>
</html>