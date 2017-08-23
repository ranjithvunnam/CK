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
<title>WISP</title>
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
									<c:if test="${empty service.service_fav_list_entity.imagesEntities && empty service.service_fav_list_entity.videosEntities}">
										<div>
											<img u="image" src="resources/images/no_image_available.jpg" />
											<img u="thumb" src="resources/images/no_image_available.jpg" />
										</div>
									</c:if>
									<c:forEach items="${service.service_fav_list_entity.imagesEntities}" var="image"
										varStatus="loop">
										<div>
											<img u="image" src="${image.image_url}" /> <img u="thumb"
												src="${image.image_url}" />
										</div>
									</c:forEach>
									<!-- Videos -->
									<c:forEach items="${service.service_fav_list_entity.videosEntities}" var="video" varStatus="loop_video">
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
									<span class="fav">
										<img  id="ser_fav${service.service_fav_list_entity.service_id}" onclick="toggleFavorite(event, '${service.service_fav_list_entity.service_id}','1')" 
														src="resources/images/icons/favourite.png" alt="">Favourite</span>
									<span class="share"><img
										src="resources/images/icons/share.png" alt="">share</span>
								</div>
									<a href="${service.service_fav_list_entity.service_type.description}/${service.service_fav_list_entity.service_id}/service_details">
										<p class="name">${service.service_fav_list_entity.service_name}</p>
									</a>
									<p class="contact">	${service.service_fav_list_entity.addressEntity.address_1} 
										${service.service_fav_list_entity.addressEntity.address_2}
										${service.service_fav_list_entity.addressEntity.city}
										${service.service_fav_list_entity.addressEntity.state}
										${service.service_fav_list_entity.addressEntity.country}
										${service.service_fav_list_entity.addressEntity.pincode}
									</p>
									<p class="phone">Phone : ${service.service_fav_list_entity.service_phone}</p>
									<p class="web">Website : ${service.service_fav_list_entity.service_website}</p>
								<div class="icons-div">
									<c:if test="${service.service_fav_list_entity.service_type eq 'SER_VENUE' || service.service_fav_list_entity.service_type eq 'SER_CATERERS'}">
										<div class="specifications">
											<img src="resources/images/icons/capacity.png" alt="">
											<p>Capacity</p>
											<p>${service.service_fav_list_entity.amenitiyEntity.capacity}</p>
										</div>
									</c:if>
									<c:if test="${service.service_fav_list_entity.service_type eq 'SER_VENUE'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Rooms</p>
											<p>${service.service_fav_list_entity.amenitiyEntity.rooms}</p>
										</div>
									</c:if>
									<div class="specifications">
										<img src="resources/images/icons/price.png" alt="">
											<p>Price</p>
											<p>${service.service_fav_list_entity.amenitiyEntity.price}</p>
									</div>
									<c:if test="${service.service_fav_list_entity.service_type eq 'SER_VENUE'}">
										<div class="specifications">
											<img src="resources/images/icons/car.png" alt="">
											<p>Parking</p>
											<a class="${service.service_fav_list_entity.amenitiyEntity.parking ? 'active' : ''}">Yes</a>
											<a class="${service.service_fav_list_entity.amenitiyEntity.parking ? '' : 'active'}">No</a>
										</div>
									</c:if>
									<c:if test="${service.service_fav_list_entity.service_type eq 'SER_VENUE'}">
										<div class="specifications">
											<img src="resources/images/icons/liquor.png" alt="">
											<p>Liquor</p>
											<a class="${service.service_fav_list_entity.amenitiyEntity.liquor ? 'active' : ''}">Yes</a>
											<a class="${service.service_fav_list_entity.amenitiyEntity.liquor ? '' : 'active'}">No</a>
										</div>
									</c:if>
									<c:if test="${service.service_fav_list_entity.service_type eq 'SER_VENUE'}">
										<div class="specifications">
											<img src="resources/images/icons/ac.png" alt="">
											<p>Ac</p>
											<a class="${service.service_fav_list_entity.amenitiyEntity.air_condition ? 'active' : ''}">Yes</a>
											<a class="${service.service_fav_list_entity.amenitiyEntity.air_condition ? '' : 'active'}">No</a>
										</div>
									</c:if>
									<c:if test="${service.service_fav_list_entity.service_type eq 'SER_VENUE'}">
										<div class="specifications">
											<img src="resources/images/icons/wifi.png" alt="">
											<p>Wifi</p>
											<a class="${service.service_fav_list_entity.amenitiyEntity.wifi ? 'active' : ''}">Yes</a>
											<a class="${service.service_fav_list_entity.amenitiyEntity.wifi ? '' : 'active'}">No</a>
										</div>
									</c:if>
									<c:if test="${service.service_fav_list_entity.service_type eq 'SER_CATERERS' || service.service_fav_list_entity.service_type eq 'SER_PHOTOGRAPHY' 
										|| service.service_fav_list_entity.service_type eq 'SER_ENTERTAINERS' || service.service_fav_list_entity.service_type eq 'SER_BEAUTICIANS'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Type</p>
											<p>${service.service_fav_list_entity.amenitiyEntity.type}</p>
										</div>
									</c:if>
									<c:if test="${service.service_fav_list_entity.service_type eq 'SER_CATERERS'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Cusine</p>
											<p>${service.service_fav_list_entity.amenitiyEntity.cusine}</p>
										</div>
									</c:if>
									<c:if test="${service.service_fav_list_entity.service_type eq 'SER_CATERERS' || service.service_fav_list_entity.service_type eq 'SER_EVENT_PLANNERS'
										|| service.service_fav_list_entity.service_type eq 'SER_EVENT_DESIGNERS' || service.service_fav_list_entity.service_type eq 'SER_PANDITS'
										|| service.service_fav_list_entity.service_type eq 'SER_CHOREOGRAPHERS'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Occasion</p>
											<p>${service.service_fav_list_entity.amenitiyEntity.occasion}</p>
										</div>
									</c:if>
									<c:if test="${service.service_fav_list_entity.service_type eq 'SER_BEAUTICIANS'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Gender</p>
											<p>${service.service_fav_list_entity.amenitiyEntity.gender}</p>
										</div>
									</c:if>
									<c:if test="${service.service_fav_list_entity.service_type eq 'SER_CHOREOGRAPHERS'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Dance Style</p>
											<p>${service.service_fav_list_entity.amenitiyEntity.dance_style}</p>
										</div>
									</c:if>
									<c:if test="${service.service_fav_list_entity.service_type eq 'SER_TRAVEL'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Fleet</p>
											<p>${service.service_fav_list_entity.amenitiyEntity.fleet}</p>
										</div>
									</c:if>
								</div>
								<div class="ratings">
									Photos <span class="photos">${service.service_fav_list_entity.imagesEntities.size()}</span>
									videos <span class="videos">${service.service_fav_list_entity.videosEntities.size()}</span>
									comments 
									<c:choose>
										<c:when test="${loggedIn}">
											<img src="resources/images/icons/comments.png" alt="" data-toggle="modal" data-target="#comments_modal${service.service_fav_list_entity.service_id}">		
										</c:when>
										<c:otherwise>
											<img src="resources/images/icons/comments.png" alt="">
										</c:otherwise>
									</c:choose>
									<span class="comments">${service.service_fav_list_entity.commentsEntities.size()}</span>
									<%-- <fieldset class="rating">
										<div class="rating-readonly"><span class="stars-container stars-
										<fmt:formatNumber value="${service.service_avg_rating * 20}" minFractionDigits="0" maxFractionDigits="0"/>">★★★★★</span></div>
									</fieldset> --%>
									<div class="rating-readonly">
			                            <form>
			                                <input id="" value="${service.service_fav_list_entity.service_avg_rating}" type="text" class="rating" data-min=0 data-max=5 data-step=0.2 data-size="xs"
			                                        title="" disabled captio="none">
			                            </form>
			                        </div>
								</div>
							</div>
						</div>
					</div>
					<c:if test="${loggedIn && not empty service.service_fav_list_entity.commentsEntities}">
					<!-- Comments Model -->
					<div class="modal fade" id="comments_modal${service.service_fav_list_entity.service_id}" role="dialog">
						<div class="modal-dialog modal-lg">
							<div class="modal-content" style="border-radius: unset;">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<!-- <h4 class="modal-title">Send an Enquiry</h4> -->
								</div>
								<div class="modal-body" id="mod_comm" style="overflow-x: auto;">
									<c:forEach items="${service.service_fav_list_entity.commentsEntities}" var="comment">
									<div class="panel panel-white post panel-shadow">
										<div class="post-heading">
											<div class="pull-left image">
												<img src="http://images.clipartpanda.com/user-clipart-dagobert83_female_user_icon.png"
													class="img-circle avatar" alt="user profile image">
											</div>
											<div class="pull-left meta">
												<div class="title h5">
													<a href="#"><b>${comment.user_comments_entity.first_name}</b></a> made a post.
													<div class="rating-readonly">
														<form>
															<input id="" value="${comment.rating}" type="text" class="rating" data-min=0
																data-max=5 data-step=0.2 data-size="xs" title="" disabled>
														</form>
													</div>
												</div>
												<h6 class="text-muted time">
													<fmt:formatDate type="both" dateStyle="medium" timeStyle="medium" value="${comment.comment_created}" />
												</h6>
											</div>
										</div>
										<div class="post-description">
											<p>${comment.comment_desc}</p>
										</div>
									</div>
								</c:forEach>
								</div>
							</div>
						</div>
					</div>
					</c:if>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<div class="row">
			<div class="col-md-12 text-right mTop10">
				<tag:paginate max="15" offset="${offset}" count="${count}"
					uri="favorites" next="&raquo;"
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
	<!-- <script src="slick/slick.js" type="text/javascript" charset="utf-8"></script> -->
	<script src="resources/js/custom.js" type="text/javascript"></script>
	<script type="text/javascript" src="resources/js/star-rating.js"></script>
	<script type="text/javascript" src="resources/js/custom-jssor.js"></script>
	<script type="text/javascript" src="resources/js/jssor.slider.js"></script>
	<script type="text/javascript" src="resources/js/jssor.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#homex,#estimatesx,#servicesx,#estimatesx,#offersx").removeClass('active');
			$("#favoritesx").addClass('active');
		});
		function toggleFavorite(event, serviceId, status) {
			$.ajax({
				url : 'toggleFavorite?&service_id='+serviceId+'&status='+status,
				type : 'GET',
				contentType : 'application/json; charset=utf-8',
				success : function(result, msg, xhr) {
					var fullPath = $('#'+event.target.id).attr('src');
					var imageName = fullPath.replace(/^.*[\\\/]/, '');
					if(imageName == "favourite.png"){
						$('#'+event.target.id).attr('src',"resources/images/icons/favorite.png");
					} else {
						$('#'+event.target.id).attr('src',"resources/images/icons/favourite.png");
					}
					window.location.reload();
				},
				error : function(jqXHR, textStatus) {
					alert(textStatus);
				}
			});
		};
	</script>
</body>
</html>