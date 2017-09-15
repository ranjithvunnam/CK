<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
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

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via tes
    file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body>
	<%@ include file="/WEB-INF/pages/templetes/header.jsp"%>

	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12">
			<form id="filter_search_form" role="form" action="filterServices" method="POST">
				<div class="col-sm-12 col-sm-12 col-xs-12 filter-area">
						<div class="dropdown">
							<button class=" dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
	                            <span class="menuselected">Services</span>
	                            <span class="caret"></span>
	                        </button>
							<form:select class="dropdown-menu _servicefilter" name="" path="serviceFilterBean.service_type">
								<form:options items="${service_list}" itemLabel="displayName" />
							</form:select>
						</div>
						<div class="dropdown">
							<button class=" dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
	                            <span class="menuselected">Location</span>
	                            <span class="caret"></span>
	                        </button>
	                        <form:select class="dropdown-menu" name="" path="serviceFilterBean.location">
								<form:options items="${city_list}" />
							</form:select>
						</div>
						<input type="hidden" value="${serviceFilterBean.location}" id="filter_location"/>
						<c:if test="${serviceFilterBean.service_type eq 'SER_VENUE' || serviceFilterBean.service_type eq 'SER_CATERERS'}">
							<div class="dropdown">
								<button class=" dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
		                            <span class="menuselected">Capacity</span>
		                            <span class="caret"></span>
		                        </button>
		                        <form:select class="dropdown-menu" name="" path="serviceFilterBean.amenityBean.capacity" id="_capacityfilter">
									<form:option value="">Capacity</form:option>
									<form:option value="500 - 1000">500 - 1000</form:option>
									<form:option value="1000 - 1500">1000 - 1500</form:option>
									<form:option value="1500-2000">1500-2000</form:option>
									<form:option value="2500 +">2500 +</form:option>
								</form:select>
							</div>
						</c:if>
						<c:if test="${serviceFilterBean.service_type eq 'SER_VENUE'}">
							<div class="dropdown">
								<button class=" dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
		                            <span class="menuselected">Rooms</span>
		                            <span class="caret"></span>
		                        </button>
		                        <form:select class="dropdown-menu" name="" path="serviceFilterBean.amenityBean.rooms" id="_roomsfilter">
									<form:option value="">Rooms</form:option>
									<form:option value="10">10</form:option>
									<form:option value="15">15</form:option>
									<form:option value="25">25</form:option>
								</form:select>
							</div>
						</c:if>
						<c:if test="${serviceFilterBean.service_type eq 'SER_VENUE'}">
							<div class="checkbox-div">
								Air Con
								<label class="custom_switch">
		                            <form:checkbox id="togBtnAC" path="serviceFilterBean.amenityBean.air_condition" />
		                            <div class="slider round">
		                                <!--ADDED HTML --><span class="on"><i class="fa fa-check" aria-hidden="true"></i></span><span class="off"></span>
		                                <!--END-->
		                            </div>
		                        </label>
							</div>
						</c:if>
						<c:if test="${serviceFilterBean.service_type eq 'SER_VENUE'}">
							<div class="checkbox-div">
								Liquor
								<label class="custom_switch">
		                            <form:checkbox id="togBtn" path="serviceFilterBean.amenityBean.liquor" />
		                            <div class="slider round">
		                                <!--ADDED HTML --><span class="on"><i class="fa fa-check" aria-hidden="true"></i></span><span class="off"></span>
		                                <!--END-->
		                            </div>
		                        </label>
							</div>
						</c:if>
						<c:if test="${serviceFilterBean.service_type eq 'SER_VENUE'}">
							<div class="checkbox-div">
								Parking 
								<label class="custom_switch">
		                            <form:checkbox id="togBtn" path="serviceFilterBean.amenityBean.parking" />
		                            <div class="slider round">
		                                <!--ADDED HTML --><span class="on"><i class="fa fa-check" aria-hidden="true"></i></span><span class="off"></span>
		                                <!--END-->
		                            </div>
		                        </label>
							</div>
						</c:if>
						<c:if test="${serviceFilterBean.service_type eq 'SER_VENUE'}">
							<div class="checkbox-div">
								WiFi 
								<label class="custom_switch">
		                            <form:checkbox id="togBtn" path="serviceFilterBean.amenityBean.wifi" />
		                            <div class="slider round">
		                                <!--ADDED HTML --><span class="on"><i class="fa fa-check" aria-hidden="true"></i></span><span class="off"></span>
		                                <!--END-->
		                            </div>
		                        </label>
							</div>
						</c:if>
						<c:if test="${serviceFilterBean.service_type eq 'SER_BEAUTICIANS'}">
							<div class="dropdown">
									<button class=" dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
			                            <span class="menuselected">Select Gender</span>
			                            <span class="caret"></span>
			                        </button>
								<form:select class="dropdown-menu" name="" path="serviceFilterBean.amenityBean.gender" id="_genderfilter">
									<form:option value="">Select Gender</form:option>
									<form:option value="Women">Women</form:option>
									<form:option value="Men">Men</form:option>
									<form:option value="Unisex">Unisex</form:option>
								</form:select>
							</div>
						</c:if>
						<div class="filter-search-div">
						<form:input type="text" class="form-control" placeholder="Search" name="" path="serviceFilterBean.searchTerm" />
						<div class="input-group">
							<button type="submit">
								<span class="glyphicon glyphicon-search"></span>
							</button>
						</div>
					</div>
				</div>
				</form>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4 col-sm-12 col-xs-12 service-box-gallery">
				<div id="'slider0_container'" class="service_slider"
					style="position: relative; top: 0px; left: 0px; width: 840px; height: 480px; background: #191919; overflow: hidden;">

					<!-- Loading Screen -->
					<div u="loading" style="position: absolute; top: 0px; left: 0px;">
						<div
							style="filter: alpha(opacity =       70); opacity: 0.7; position: absolute; display: block; background-color: #000000; top: 0px; left: 0px; width: 100%; height: 100%;">
						</div>
						<div
							style="position: absolute; display: block; background: url(resources/images/loading.gif) no-repeat center center; top: 0px; left: 0px; width: 100%; height: 100%;">
						</div>
					</div>

					<!-- Slides Container -->
					<div u="slides"
						style="cursor: move; position: absolute; left: 0px; top: 0px; width: 720px; height: 480px; overflow: hidden;">
						<c:if test="${empty service_details.imagesEntities && empty service_details.videosEntities}">
							<div>
								<img u="image" src="resources/images/no_image_available.jpg" />
								<img u="thumb" src="resources/images/no_image_available.jpg" />
							</div>
						</c:if>
						<c:forEach items="${service_details.imagesEntities}" var="image"
							varStatus="loop">
							<div>
								<img u="image" src="${image.image_url}" /> <img u="thumb"
									src="${image.image_url}" />
							</div>
						</c:forEach>
						<!-- Videos -->
						<c:forEach items="${service_details.videosEntities}" var="video"
							varStatus="loop_video">
							<div>
								<video class="gallery_video" width="100%"
									src="${video.video_url}"></video>
								<img u="thumb" src="${video.video_thumbnail}" />
								<div class="playpause"></div>
							</div>
						</c:forEach>
					</div>

					<!-- Arrow Navigator Skin Begin -->
					<style>
/* jssor slider arrow navigator skin 05 css */
/*
														                        .jssora05l              (normal)
														                        .jssora05r              (normal)
														                        .jssora05l:hover        (normal mouseover)
														                        .jssora05r:hover        (normal mouseover)
														                        .jssora05ldn            (mousedown)
														                        .jssora05rdn            (mousedown)
														                        */
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
				<div
					class="col-md-12 col-sm-12 col-xs-12 service-box-right white-bg">
					<div class="top-share-icon">
						<span class="share"><img src="resources/images/icons/share.png" alt="">share <i class="fa fa-caret-down" aria-hidden="true"></i>
	                        <div class="social-networks">
	                          <ul>
	                          	<li class="social-twitter">
	                            	<a data-js="${pageContext.request.contextPath}/${service_details.service_type.description}/${service_details.service_id}/service_details" class="twitterShare"><i class="fa fa-twitter"></i></a>
	                            </li>
	                            <li class="social-facebook">
	                            	<a data-js="${pageContext.request.contextPath}/${service_details.service_type.description}/${service_details.service_id}/service_details" class="facebookShare"><i class="fa fa-facebook"></i></a>
	                            </li>
	                            <li class="social-gplus">
	                            	<a data-js="${pageContext.request.contextPath}/${service_details.service_type.description}/${service_details.service_id}/service_details" class="googleShare"><i class="fa fa-google-plus"></i></a>
	                            </li>
	                            <li class="social-watsapp">
	                            	<a data-js="${pageContext.request.contextPath}/${service_details.service_type.description}/${service_details.service_id}/service_details" class="watsappshare"><i class="fa fa-whatsapp"></i></a>
	                            </li>
	                            <li class="social-copyclipboard">
	                            	<a data-js="${pageContext.request.contextPath}/${service_details.service_type.description}/${service_details.service_id}/service_details" class="copytoclipboard"><i class="fa fa-clipboard"></i></a>
	                            </li>
	                            <li class="social-email">
	                            	<a data-js="${pageContext.request.contextPath}/${service_details.service_type.description}/${service_details.service_id}/service_details" class="emailshare"><i class="fa fa-envelope"></i></a>
	                            </li>
	                          </ul>
	                        </div>
	                    </span>
						<span class="fav" id="${service.service_id}">
							<img src="resources/images/icons/favorite.png" alt="">Favourite</span>
					</div>
					<p class="name">${service_details.service_name}</p>
					<input type="hidden" name="service_id" value="${service_details.service_id}" />
					<p class="contact">	${service_details.addressEntity.address_1}, &nbsp
										<c:if test="${not empty service_details.addressEntity.address_2}">
										${service_details.addressEntity.address_2}, &nbsp
										</c:if>
										${service_details.addressEntity.city}, &nbsp
										${service_details.addressEntity.state}, &nbsp
										${service_details.addressEntity.country}
										<c:if test="${not empty service_details.addressEntity.pincode}">
										, &nbsp
										${service_details.addressEntity.pincode}
										</c:if>
								</p>
					<br>
					<p class="phone">Phone : ${service_details.service_phone}</p>
					<c:if test="${not empty service_details.service_website}">
									| &nbsp;&nbsp;<p class="phone">Website : ${service_details.service_website}</p>
								</c:if>
								<c:if test="${not empty service_details.service_email}">
									| &nbsp;&nbsp;<p class="phone">Email : ${service_details.service_email}</p>
								</c:if>

					<div class="icons-div">
									<c:if test="${service_details.service_type eq 'SER_VENUE' || service_details.service_type eq 'SER_CATERERS'}">
										<div class="specifications">
											<img src="resources/images/icons/capacity.png" alt="">
											<p>Capacity</p>
											<p>${service_details.amenitiyEntity.capacity}</p>
										</div>
									</c:if>
									<c:if test="${service_details.service_type eq 'SER_VENUE'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Rooms</p>
											<p>${service_details.amenitiyEntity.rooms}</p>
										</div>
									</c:if>
									<div class="specifications">
										<img src="resources/images/icons/price.png" alt="">
											<p>Price</p>
											<p>${service_details.amenitiyEntity.price}</p>
									</div>
									<c:if test="${service_details.service_type eq 'SER_VENUE'}">
										<div class="specifications">
											<img src="resources/images/icons/car.png" alt="">
											<p>Parking</p>
											<a class="${service_details.amenitiyEntity.parking ? 'active' : ''}">Yes</a>
											<a class="${service_details.amenitiyEntity.parking ? '' : 'active'}">No</a>
										</div>
									</c:if>
									<c:if test="${service_details.service_type eq 'SER_VENUE'}">
										<div class="specifications">
											<img src="resources/images/icons/liquor.png" alt="">
											<p>Liquor</p>
											<a class="${service_details.amenitiyEntity.liquor ? 'active' : ''}">Yes</a>
											<a class="${service_details.amenitiyEntity.liquor ? '' : 'active'}">No</a>
										</div>
									</c:if>
									<c:if test="${service_details.service_type eq 'SER_VENUE'}">
										<div class="specifications">
											<img src="resources/images/icons/ac.png" alt="">
											<p>Ac</p>
											<a class="${service_details.amenitiyEntity.air_condition ? 'active' : ''}">Yes</a>
											<a class="${service_details.amenitiyEntity.air_condition ? '' : 'active'}">No</a>
										</div>
									</c:if>
									<c:if test="${service_details.service_type eq 'SER_VENUE'}">
										<div class="specifications">
											<img src="resources/images/icons/wifi.png" alt="">
											<p>Wifi</p>
											<a class="${service_details.amenitiyEntity.wifi ? 'active' : ''}">Yes</a>
											<a class="${service_details.amenitiyEntity.wifi ? '' : 'active'}">No</a>
										</div>
									</c:if>
									<c:if test="${service_details.service_type eq 'SER_CATERERS'}">
										<div class="specifications">
											<img src="resources/images/icons/caterer_type.png" alt="">
											<p>Type</p>
											<p>${service_details.amenitiyEntity.type}</p>
										</div>
									</c:if>
									<c:if test="${service_details.service_type eq 'SER_PHOTOGRAPHY'}">
										<div class="specifications">
											<img src="resources/images/icons/photographers.png" alt="">
											<p>Type</p>
											<p>${service_details.amenitiyEntity.type}</p>
										</div>
									</c:if>
									<c:if test="${service_details.service_type eq 'SER_ENTERTAINERS'}">
										<div class="specifications">
											<img src="resources/images/icons/entertainers.png" alt="">
											<p>Type</p>
											<p>${service_details.amenitiyEntity.type}</p>
										</div>
									</c:if>
									<c:if test="${service_details.service_type eq 'SER_BEAUTICIANS'}">
										<div class="specifications">
											<img src="resources/images/icons/beauticians.png" alt="">
											<p>Type</p>
											<p>${service_details.amenitiyEntity.type}</p>
										</div>
									</c:if>
									<%-- <c:if test="${service_details.service_type eq 'SER_CATERERS'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Cusine</p>
											<p>${service_details.amenitiyEntity.cusine}</p>
										</div>
									</c:if>
									<c:if test="${service_details.service_type eq 'SER_CATERERS' || service_details.service_type eq 'SER_EVENT_PLANNERS'
										|| service_details.service_type eq 'SER_EVENT_DESIGNERS' || service_details.service_type eq 'SER_PANDITS'
										|| service_details.service_type eq 'SER_CHOREOGRAPHERS'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Occasion</p>
											<p>${service_details.amenitiyEntity.occasion}</p>
										</div>
									</c:if> --%>
									<c:if test="${service_details.service_type eq 'SER_BEAUTICIANS'}">
										<div class="specifications">
											<img src="resources/images/icons/gender_type.png" alt="">
											<p>Gender</p>
											<p>${service_details.amenitiyEntity.gender}</p>
										</div>
									</c:if>
									<c:if test="${service_details.service_type eq 'SER_CHOREOGRAPHERS'}">
										<div class="specifications">
											<img src="resources/images/icons/choreographers.png" alt="">
											<p>Dance Style</p>
											<p>${service_details.amenitiyEntity.dance_style}</p>
										</div>
									</c:if>
									<c:if test="${service_details.service_type eq 'SER_TRAVEL'}">
										<div class="specifications">
											<img src="resources/images/icons/travel.png" alt="">
											<p>Fleet</p>
											<p>${service_details.amenitiyEntity.fleet}</p>
										</div>
									</c:if>
								</div>
					<div class="ratings">
						Photos <span class="photos">${service_details.imagesEntities.size()}</span>
						videos <span class="videos">${service_details.videosEntities.size()}</span>
						<span class="fav" data-serviceid="${service_details.service_id}">comments <img src="resources/images/icons/comments.png" alt="">
						<span class="comments">${service_details.commentsEntities.size()}</span>
							<div class="rating-readonly">
								<form>
									<input id="" value="${service_details.service_avg_rating}" type="text"
										class="rating" data-min=0 data-max=5 data-step=0.2
										data-size="xs" title="" disabled captio="none">
								</form>
							</div>
						<span class="comments">(${service.commentsEntities.size()})</span>
			            </span>
					</div>
				</div>
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
	<script type="text/javascript" src="resources/js/star-rating.js"></script>
	<script src="resources/js/selectjs/classie.js"></script>
    <script src="resources/js/selectjs/selectFx.js"></script>
	<script type="text/javascript" src="resources/js/custom.js"></script>
	<script type="text/javascript" src="resources/js/custom-jssor.js"></script>
	<script type="text/javascript" src="resources/js/jssor.slider.js"></script>
	<script type="text/javascript" src="resources/js/jssor.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#homex,#estimatesx,#favoritesx,#estimatesx,#offersx").removeClass('active');
			$("#servicesx").addClass('active');
		});
		// toggle favourite icon
		$(".top-share-icon .fav").on("click", function(){
			var serviceId = $(this).attr('id');
			var fullPath = $(this).find('img').attr('src');
			console.log(fullPath);
			var currentImage = $(this).find('img');
			$.ajax({
				url : 'rest/toggleFavorite?&service_id='+serviceId,
				type : 'GET',
				contentType : 'application/json; charset=utf-8',
				success : function(result, msg, xhr) {
					var imageName = fullPath.replace(/^.*[\\\/]/, '');
					console.log(imageName);
					if(imageName == "favourite.png"){
						console.log($(this));
						currentImage.attr("src", "resources/images/icons/favorite.png");
					}
					else{
						console.log(false);
						currentImage.attr("src", "resources/images/icons/favourite.png")
					}
					
				},
				error : function(jqXHR, textStatus) {
					if (jqXHR.status === 401) { // HTTP Status 401: Unauthorized
			            window.location = 'login';
			        } else {
			        	alert(textStatus);
			        }
				}
			});
		});
	</script>
</body>
</html>