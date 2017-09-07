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
	<%@ include file="/WEB-INF/pages/templetes/header.jsp"%>

	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12">
			<form id="filter_search_form" role="form" action="filterServices" method="POST">
				<div class="col-sm-12 col-sm-12 col-xs-12 filter-area">
						<form:select class="" name="" path="serviceFilterBean.service_type" id="_servicefilter">
							<form:options items="${service_list}" itemLabel="displayName" />
						</form:select>
						<form:select class="" name="" path="serviceFilterBean.location">
							<form:option value="">Select Location</form:option>
							<form:options items="${city_list}" />
						</form:select>
						<input type="hidden" value="${serviceFilterBean.location}" id="filter_location"/>
						<c:if test="${serviceFilterBean.service_type eq 'SER_VENUE' || serviceFilterBean.service_type eq 'SER_CATERERS'}">
							<form:select class="" name="" path="serviceFilterBean.amenityBean.capacity">
								<form:option value="">Select Capacity</form:option>
								<form:option value="500 - 1000">500 - 1000</form:option>
								<form:option value="1000 - 1500">1000 - 1500</form:option>
								<form:option value="1500-2000">1500-2000</form:option>
								<form:option value="2500 +">2500 +</form:option>
							</form:select>
						</c:if>
						<c:if test="${serviceFilterBean.service_type eq 'SER_VENUE'}">
							<form:select class="" name="" path="serviceFilterBean.amenityBean.rooms">
								<form:option value="">Select Rooms</form:option>
								<form:option value="10">10</form:option>
								<form:option value="15">15</form:option>
								<form:option value="25">25</form:option>
							</form:select>
						</c:if>
						<c:if test="${serviceFilterBean.service_type eq 'SER_VENUE'}">
							<div class="checkbox-div">
								Air Con
								<form:checkbox id="togBtn" path="serviceFilterBean.amenityBean.air_condition" />
									<div class="slider round">
										<span class="on"><i class="fa fa-check"
											aria-hidden="true"></i></span><span class="off"></span>
									</div>
							</div>
						</c:if>
						<c:if test="${serviceFilterBean.service_type eq 'SER_VENUE'}">
							<div class="checkbox-div">
								Liquor 
								<form:checkbox id="togBtn" path="serviceFilterBean.amenityBean.liquor" />
									<div class="slider round">
										<span class="on"><i class="fa fa-check"
											aria-hidden="true"></i></span><span class="off"></span>
									</div>
							</div>
						</c:if>
						<c:if test="${serviceFilterBean.service_type eq 'SER_VENUE'}">
							<div class="checkbox-div">
								Parking 
								<form:checkbox id="togBtn" path="serviceFilterBean.amenityBean.parking" />
									<div class="slider round">
										<span class="on"><i class="fa fa-check"
											aria-hidden="true"></i></span><span class="off"></span>
									</div>
							</div>
						</c:if>
						<c:if test="${serviceFilterBean.service_type eq 'SER_VENUE'}">
							<div class="checkbox-div">
								WiFi 
								<form:checkbox id="togBtn" path="serviceFilterBean.amenityBean.wifi" />
									<div class="slider round">
										<span class="on"><i class="fa fa-check"
											aria-hidden="true"></i></span><span class="off"></span>
									</div>
							</div>
						</c:if>
						<c:if test="${serviceFilterBean.service_type eq 'SER_BEAUTICIANS'}">
							<form:select class="" name="" path="serviceFilterBean.amenityBean.gender">
								<form:option value="">Select Gender</form:option>
								<form:option value="Women">Women</form:option>
								<form:option value="Men">Men</form:option>
								<form:option value="Unisex">Unisex</form:option>
							</form:select>
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
										style="filter: alpha(opacity =   70); opacity: 0.7; position: absolute; display: block; background-color: #000000; top: 0px; left: 0px; width: 100%; height: 100%;">
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
									<c:forEach items="${service.videosEntities}" var="video" varStatus="loop_video">
										<div>
											<video class="gallery_video" width="100%" src="${video.video_url}"></video>
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
									<c:set var="isFavorite" value="false" />
									<c:forEach items="${service.favoritesEntities}" var="favoritesEntities">
										<c:if test="${favoritesEntities.user_fav_entity.email == email}">
											<c:set var="isFavorite" value="true" />
										</c:if>
									</c:forEach>
									<c:choose>
										<c:when test="${isFavorite eq true}">
											<!-- this is user favorite -->
											<span class="fav" id="${service.service_id}">
												<img src="resources/images/icons/favourite.png" alt="">Favourite</span>
										</c:when>
										<c:otherwise>
											<!-- this is not user favorite -->
											<span class="fav" id="${service.service_id}">
												<img src="resources/images/icons/favorite.png" alt="" >Favourite</span>
										</c:otherwise>
									</c:choose>
									<!-- <span class="share" id="fb_share"><img src="resources/images/icons/share.png" alt="">share</span> -->
									<span class="share" id="${service.service_id}"><img src="resources/images/icons/share.png" alt="">share <i class="fa fa-caret-down" aria-hidden="true"></i>
			                        <div class="social-networks">
			                          <ul>
			                            <li class="social-twitter">
			                            	<a data-js="${pageContext.request.contextPath}/${service.service_type.description}/${service.service_id}/service_details" id="twitterShare"><i class="fa fa-twitter"></i></a>
			                            </li>
			                            <li class="social-facebook">
			                            	<a data-js="${pageContext.request.contextPath}/${service.service_type.description}/${service.service_id}/service_details" id="facebookShare"><i class="fa fa-facebook"></i></a>
			                            </li>
			                            <li class="social-gplus">
			                            	<a data-js="${pageContext.request.contextPath}/${service.service_type.description}/${service.service_id}/service_details" id="googleShare"><i class="fa fa-google-plus"></i></a>
			                            </li>
			                            <li class="social-watsapp">
			                            	<a data-js="${pageContext.request.contextPath}/${service.service_type.description}/${service.service_id}/service_details" id="watsappshare"><i class="fa fa-whatsapp"></i></a>
			                            </li>
			                            <li class="social-copyclipboard">
			                            	<a data-js="${pageContext.request.contextPath}/${service.service_type.description}/${service.service_id}/service_details" id="copytoclipboard"><i class="fa fa-clipboard"></i></a>
			                            </li>
			                            <li class="social-email">
			                            	<a data-js="${pageContext.request.contextPath}/${service.service_type.description}/${service.service_id}/service_details" id="emailshare"><i class="fa fa-envelope"></i></a>
			                            </li>
			                          </ul>
			                        </div>
			                    </span>
								</div>
									<a href="${service_type}/${service.service_id}/service_details">
										<p class="name">${service.service_name}</p>
									</a>
								<p class="contact">	${service.addressEntity.address_1} 
										${service.addressEntity.address_2}
										${service.addressEntity.city}
										${service.addressEntity.state}
										${service.addressEntity.country}
										${service.addressEntity.pincode}
								</p>
								<p class="phone">Phone : ${service.service_phone}</p>
								<p class="web">Website : ${service.service_website}</p>
								<p class="web">Email : ${service.service_email}</p>
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
									<c:if test="${service.service_type eq 'SER_CATERERS' || service.service_type eq 'SER_PHOTOGRAPHY' 
										|| service.service_type eq 'SER_ENTERTAINERS' || service.service_type eq 'SER_BEAUTICIANS'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Type</p>
											<p>${service.amenitiyEntity.type}</p>
										</div>
									</c:if>
									<c:if test="${service.service_type eq 'SER_CATERERS'}">
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
									</c:if>
									<c:if test="${service.service_type eq 'SER_BEAUTICIANS'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Gender</p>
											<p>${service.amenitiyEntity.gender}</p>
										</div>
									</c:if>
									<c:if test="${service.service_type eq 'SER_CHOREOGRAPHERS'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Dance Style</p>
											<p>${service.amenitiyEntity.dance_style}</p>
										</div>
									</c:if>
									<c:if test="${service.service_type eq 'SER_TRAVEL'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
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
				                                <input id="" value="${service.service_avg_rating}" type="text" class="rating" data-min=0 data-max=5 data-step=0.2 data-size="xs"
				                                        title="" disabled captio="none">
				                            </form>
				                        </div>
				                        <span class="comments">(${service.commentsEntities.size()})</span>
			                        </span>
								</div>
							</div>
						</div>
					</div>
					<c:if test="${loggedIn && not empty service.commentsEntities}">
					</c:if>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<div class="row">
			<div class="col-md-12 text-right mTop10">
				<tag:paginate max="10" offset="${offset}" count="${count}"
					uri="${service_type}/service_listing" next="&raquo;"
					previous="&laquo;" />
			</div>
		</div>

	</div>
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
	<%@ include file="/WEB-INF/pages/templetes/footer.jsp"%>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/slick/slick.js" type="text/javascript" charset="utf-8"></script>
	<script src="resources/js/custom.js" type="text/javascript"></script>
	<script type="text/javascript" src="resources/js/star-rating.js"></script>
	<script type="text/javascript" src="resources/js/custom.js"></script>
	<script type="text/javascript" src="resources/js/custom-jssor.js"></script>
	<script type="text/javascript" src="resources/js/jssor.slider.js"></script>
	<script type="text/javascript" src="resources/js/jssor.js"></script>
	<script src="resources/js/socialauth.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#homex,#estimatesx,#favoritesx,#estimatesx,#offersx").removeClass('active');
			$("#servicesx").addClass('active');
		});
		
		// toggle favourite icon
		$(".top-share-icon .fav").on(
				"click",
				function() {
					var serviceId = $(this).attr('id');
					var fullPath = $(this).find('img').attr('src');
					console.log(fullPath);
					var currentImage = $(this).find('img');
					$.ajax({
						url : 'rest/toggleFavorite?&service_id=' + serviceId,
						type : 'GET',
						contentType : 'application/json; charset=utf-8',
						success : function(result, msg, xhr) {
							var imageName = fullPath.replace(/^.*[\\\/]/, '');
							console.log(imageName);
							if (imageName == "favourite.png") {
								console.log($(this));
								currentImage.attr("src",
										"resources/images/icons/favorite.png");
							} else {
								console.log(false);
								currentImage.attr("src",
										"resources/images/icons/favourite.png")
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