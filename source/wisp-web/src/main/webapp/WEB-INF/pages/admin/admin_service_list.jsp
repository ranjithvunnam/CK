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

</head>
<body>
	<%@ include file="/WEB-INF/pages/admin/templetes/header.jsp"%>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h5 class="service-heading">
					Total Live Users : ${sessionCount}
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
								<div u="slides"
									style="cursor: move; position: absolute; left: 0px; top: 0px; width: 720px; height: 480px; overflow: hidden;">
									<c:if test="${empty service.imagesEntities && empty service.videosEntities}">
										<div>
											<img u="image" src="resources/images/no_image_available.jpg" />
											<img u="thumb" src="resources/images/no_image_available.jpg" />
										</div>
									</c:if>
									<!-- Images -->
									<c:forEach items="${service.imagesEntities}" var="image"
										varStatus="loop">
										<div>
											<img u="image" src="${image.image_url}" /> <img u="thumb"
												src="${image.image_url}" />
										</div>
									</c:forEach>
									<!-- Videos -->
									<c:forEach items="${service.videosEntities}" var="video"
										varStatus="loop_video">
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
								Thumbnail Navigator Skin End
							</div>
						</div>
						<div class="col-md-8 col-sm-12 col-xs-12 service-box-bg">
							<div class="col-md-12 col-sm-12 col-xs-12 service-box-right white-bg">
								<a href="admin/${service.service_type.description}/${service.service_id}/service_details">
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
							</div>
						</div>
					</div>
					<!-- Modal -->
					<div class="modal fade" id="myModal" role="dialog">
						<div class="modal-dialog">

							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-body" id="mod_comm"
									style="overflow-x: scroll;">
									<c:forEach items="${service.commentsEntities}" var="de_comm"
										varStatus="loop_comm">
										<p>${de_comm.comment_desc}</p>
									</c:forEach>

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
					uri="admin/dashboard" next="&raquo;"
					previous="&laquo;" />
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/pages/templetes/footer.jsp"%>

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
</body>
</html>