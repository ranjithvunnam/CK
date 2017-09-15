<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tag" uri="/WEB-INF/taglibs/customTaglib.tld"%>
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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="resources/css/star-rating.css">
<link rel="stylesheet" href="resources/css/jssor.css">
<link href="resources/css/custom.css" rel="stylesheet">
<!-- Arrow Navigator Skin Begin -->
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
		<div class="row">
			<div class="col-md-12 service-box-right white-bg">
				<div class="top-share-icon">
					<a href="vendor/getSRCreationForm">
						<span class="share"><img src="resources/images/icons/create_service.png" alt="">Create New</span>
					</a>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<h5 class="service-heading">
					quick links place holder
					<div class="pull-right">
						Total Items: <span>${count}</span>
					</div>
				</h5>
			</div>
		</div>
		<c:choose>
			<c:when test="${empty services}">
		        No data available
		    </c:when>
			<c:otherwise>
				<c:forEach items="${services}" var="service" varStatus="loop">
					<div ${loop.index == 0 ? 'class = "row"' : 'class = "row mTop10"'}
						class="row">
						<div class="col-md-4 col-sm-12 col-xs-12 service-box-gallery">
							<div id="'slider${loop.index}_container'" class="service_slider"
								style="position: relative; top: 0px; left: 0px; width: 840px; height: 480px; background: #191919; overflow: hidden;">

								<!-- Loading Screen -->
								<div u="loading"
									style="position: absolute; top: 0px; left: 0px;">
									<div
										style="filter: alpha(opacity =     70); opacity: 0.7; position: absolute; display: block; background-color: #000000; top: 0px; left: 0px; width: 100%; height: 100%;">
									</div>
									<div
										style="position: absolute; display: block; background: url(resources/images/loading.gif) no-repeat center center; top: 0px; left: 0px; width: 100%; height: 100%;">
									</div>
								</div>

								<!-- Slides Container -->
								<div u="slides" style="cursor: move; position: absolute; left: 0px; top: 0px; width: 720px; height: 480px; overflow: hidden;">
									<!-- Images -->
									<c:if test="${empty service.imagesEntities && empty service.videosEntities}">
										<div>
											<img u="image" src="resources/images/no_image_available.jpg" /> <img u="thumb"
												src="resources/images/no_image_available.jpg" />
										</div>
									</c:if>
									<c:forEach items="${service.imagesEntities}" var="image" varStatus="loop_image">
										<div>
											<img u="image" src="${image.image_url}" /> <img u="thumb"
												src="${image.image_url}" />
										</div>
									</c:forEach>
									<!-- Videos -->
									<c:forEach items="${service.videosEntities}" var="video" varStatus="loop_video">
										<div>
											<video class="gallery_video" width="100%"
												src="${video.video_url}"></video>
											<img u="thumb" src="${video.video_thumbnail}" />
											<div class="playpause"></div>
										</div>
									</c:forEach>
								</div>
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
						<div class="col-md-8 col-sm-12 col-xs-12 service-box-bg">
							<div
								class="col-md-12 col-sm-12 col-xs-12 service-box-right white-bg">
								<div class="top-share-icon">
									<span class="share"><img src="resources/images/icons/share.png" alt="">share <i class="fa fa-caret-down" aria-hidden="true"></i>
				                        <div class="social-networks">
											<ul>
												<li class="social-twitter"><a
													data-js="${pageContext.request.contextPath}/${service.service_type.description}/${service.service_id}/service_details"
													class="twitterShare"><i class="fa fa-twitter"></i></a></li>
												<li class="social-facebook"><a
													data-js="${pageContext.request.contextPath}/${service.service_type.description}/${service.service_id}/service_details"
													class="facebookShare"><i class="fa fa-facebook"></i></a></li>
												<li class="social-gplus"><a
													data-js="${pageContext.request.contextPath}/${service.service_type.description}/${service.service_id}/service_details"
													class="googleShare"><i class="fa fa-google-plus"></i></a></li>
												<li class="social-watsapp">
					                            	<a data-js="${pageContext.request.contextPath}/${service.service_type.description}/${service.service_id}/service_details" class="watsappshare"><i class="fa fa-whatsapp"></i></a>
					                            </li>
					                            <li class="social-copyclipboard">
					                            	<a data-js="${pageContext.request.contextPath}/${service.service_type.description}/${service.service_id}/service_details" class="copytoclipboard"><i class="fa fa-clipboard"></i></a>
					                            </li>
					                            <li class="social-email">
					                            	<a data-js="${pageContext.request.contextPath}/${service.service_type.description}/${service.service_id}/service_details" class="emailshare"><i class="fa fa-envelope"></i></a>
					                            </li>
											</ul>
										</div>
				                    </span>
								</div>
								<a href="vendor/${service.service_type.description}/${service.service_id}/service_details">
									<p class="name">${service.service_name}</p>
								</a>
								<p class="contact">	${service.addressEntity.address_1}, &nbsp
										<c:if test="${not empty service.addressEntity.address_2}">
										${service.addressEntity.address_2}, &nbsp
										</c:if>
										${service.addressEntity.city}, &nbsp
										${service.addressEntity.state}, &nbsp
										${service.addressEntity.country}
										<c:if test="${not empty service.addressEntity.pincode}">
										, &nbsp
										${service.addressEntity.pincode}
										</c:if>
								</p>
								<br>
								<p class="phone">Phone : ${service.service_phone}</p>
								<c:if test="${not empty service.service_website}">
									| &nbsp;&nbsp;<p class="phone">Website : ${service.service_website}</p>
								</c:if>
								<c:if test="${not empty service.service_email}">
									| &nbsp;&nbsp;<p class="phone">Email : ${service.service_email}</p>
								</c:if>
								<div class="icons-div">
									<c:if test="${service.service_type eq 'SER_VENUE' || service.service_type eq 'SER_CATERERS'}">
										<div class="specifications">
											<img src="resources/images/icons/capacity.png" alt="">
											<p>Capacity</p>
											<p>${service.amenitiyEntity.capacity}</p>
										</div>
									</c:if>
									<c:if test="${service.service_type eq 'SER_VENUE'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Rooms</p>
											<p>${service.amenitiyEntity.rooms}</p>
										</div>
									</c:if>
									<div class="specifications">
										<img src="resources/images/icons/price.png" alt="">
											<p>Price</p>
											<p>${service.amenitiyEntity.price}</p>
									</div>
									<c:if test="${service.service_type eq 'SER_VENUE'}">
										<div class="specifications">
											<img src="resources/images/icons/car.png" alt="">
											<p>Parking</p>
											<a class="${service.amenitiyEntity.parking ? 'active' : ''}">Yes</a>
											<a class="${service.amenitiyEntity.parking ? '' : 'active'}">No</a>
										</div>
									</c:if>
									<c:if test="${service.service_type eq 'SER_VENUE'}">
										<div class="specifications">
											<img src="resources/images/icons/liquor.png" alt="">
											<p>Liquor</p>
											<a class="${service.amenitiyEntity.liquor ? 'active' : ''}">Yes</a>
											<a class="${service.amenitiyEntity.liquor ? '' : 'active'}">No</a>
										</div>
									</c:if>
									<c:if test="${service.service_type eq 'SER_VENUE'}">
										<div class="specifications">
											<img src="resources/images/icons/ac.png" alt="">
											<p>Ac</p>
											<a class="${service.amenitiyEntity.air_condition ? 'active' : ''}">Yes</a>
											<a class="${service.amenitiyEntity.air_condition ? '' : 'active'}">No</a>
										</div>
									</c:if>
									<c:if test="${service.service_type eq 'SER_VENUE'}">
										<div class="specifications">
											<img src="resources/images/icons/wifi.png" alt="">
											<p>Wifi</p>
											<a class="${service.amenitiyEntity.wifi ? 'active' : ''}">Yes</a>
											<a class="${service.amenitiyEntity.wifi ? '' : 'active'}">No</a>
										</div>
									</c:if>
									<c:if test="${service.service_type eq 'SER_CATERERS'}">
										<div class="specifications">
											<img src="resources/images/icons/caterer_type.png" alt="">
											<p>Type</p>
											<p>${service.amenitiyEntity.type}</p>
										</div>
									</c:if>
									<c:if test="${service.service_type eq 'SER_PHOTOGRAPHY'}">
										<div class="specifications">
											<img src="resources/images/icons/photographers.png" alt="">
											<p>Type</p>
											<p>${service.amenitiyEntity.type}</p>
										</div>
									</c:if>
									<c:if test="${service.service_type eq 'SER_ENTERTAINERS'}">
										<div class="specifications">
											<img src="resources/images/icons/entertainers.png" alt="">
											<p>Type</p>
											<p>${service.amenitiyEntity.type}</p>
										</div>
									</c:if>
									<c:if test="${service.service_type eq 'SER_BEAUTICIANS'}">
										<div class="specifications">
											<img src="resources/images/icons/beauticians.png" alt="">
											<p>Type</p>
											<p>${service.amenitiyEntity.type}</p>
										</div>
									</c:if>
									<%-- <c:if test="${service.service_type eq 'SER_CATERERS'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Cusine</p>
											<p>${service.amenitiyEntity.cusine}</p>
										</div>
									</c:if>
									<c:if test="${service.service_type eq 'SER_CATERERS' || service.service_type eq 'SER_EVENT_PLANNERS'
										|| service.service_type eq 'SER_EVENT_DESIGNERS' || service.service_type eq 'SER_PANDITS'
										|| service.service_type eq 'SER_CHOREOGRAPHERS'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Occasion</p>
											<p>${service.amenitiyEntity.occasion}</p>
										</div>
									</c:if> --%>
									<c:if test="${service.service_type eq 'SER_BEAUTICIANS'}">
										<div class="specifications">
											<img src="resources/images/icons/gender_type.png" alt="">
											<p>Gender</p>
											<p>${service.amenitiyEntity.gender}</p>
										</div>
									</c:if>
									<c:if test="${service.service_type eq 'SER_CHOREOGRAPHERS'}">
										<div class="specifications">
											<img src="resources/images/icons/choreographers.png" alt="">
											<p>Dance Style</p>
											<p>${service.amenitiyEntity.dance_style}</p>
										</div>
									</c:if>
									<c:if test="${service.service_type eq 'SER_TRAVEL'}">
										<div class="specifications">
											<img src="resources/images/icons/travel.png" alt="">
											<p>Fleet</p>
											<p>${service.amenitiyEntity.fleet}</p>
										</div>
									</c:if>
								</div>
								<div class="ratings">
									Photos <span class="photos">${service.imagesEntities.size()}</span>
									videos <span class="videos">${service.videosEntities.size()}</span>
									<span class="fav" data-serviceid="${service.service_id}">comments
									<img src="resources/images/icons/comments.png" alt="">
									<span class="comments">${service.commentsEntities.size()}</span>
									<div class="rating-readonly">
										<form>
											<input id="" value="${service.service_avg_rating}"
												type="text" class="rating" data-min=0 data-max=5
												data-step=0.2 data-size="xs" title="" disabled captio="none">
										</form>
									</div>
									<span class="comments">(${service.commentsEntities.size()})</span>
									</span>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<div class="row">
			<div class="col-md-12 text-right mTop10">
				<tag:paginate max="10" offset="${offset}" count="${count}"
					uri="vendor/home" next="&raquo;"
					previous="&laquo;" />
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/pages/templetes/footer.jsp"%>
	<!-- Comments Model -->
	<div class="modal fade" id="comments_modal" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content" style="border-radius: unset;">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body" id="mod_comm" style="overflow-x: auto;">
					
				</div>
			</div>
		</div>
	</div>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/slick/slick.js" type="text/javascript" charset="utf-8"></script>
	<script src="resources/js/custom.js" type="text/javascript"></script>
	<script type="text/javascript" src="resources/js/star-rating.js"></script>
	<script type="text/javascript" src="resources/js/custom-jssor.js"></script>
	<script type="text/javascript" src="resources/js/jssor.slider.js"></script>
	<script type="text/javascript" src="resources/js/jssor.js"></script>
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
	<script src="resources/js/socialauth.js"></script>
</body>
</html>