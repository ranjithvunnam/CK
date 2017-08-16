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
			<div class="col-xs-12 col-sm-12 col-md-12">
				<div class="col-sm-12 col-sm-12 col-xs-12 filter-area">
					<div class="dropdown">
						<button class=" dropdown-toggle" type="button" id="dropdownMenu1"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
							Services <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
							<li><a href="#">Action</a></li>
							<li><a href="#">Another action</a></li>
							<li><a href="#">Something else here</a></li>
							<li role="separator" class="divider"></li>
							<li><a href="#">Separated link</a></li>
						</ul>
					</div>
					<div class="dropdown">
						<button class="dropdown-toggle" type="button" id="dropdownMenu1"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
							Location <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
							<li><a href="#">Action</a></li>
							<li><a href="#">Another action</a></li>
							<li><a href="#">Something else here</a></li>
							<li role="separator" class="divider"></li>
							<li><a href="#">Separated link</a></li>
						</ul>
					</div>
					<div class="dropdown">
						<button class="dropdown-toggle" type="button" id="dropdownMenu1"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
							Capacity <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
							<li><a href="#">Action</a></li>
							<li><a href="#">Another action</a></li>
							<li><a href="#">Something else here</a></li>
							<li role="separator" class="divider"></li>
							<li><a href="#">Separated link</a></li>
						</ul>
					</div>
					<div class="checkbox-div">
						Air Con <label class="custom_switch"> <input
							type="checkbox" id="togBtn">
							<div class="slider round">
								<!--ADDED HTML -->
								<span class="on"><i class="fa fa-check"
									aria-hidden="true"></i></span><span class="off"></span>
								<!--END-->
							</div>
						</label>
					</div>
					<div class="checkbox-div">
						Liquor <label class="custom_switch"> <input
							type="checkbox" id="togBtn">
							<div class="slider round">
								<!--ADDED HTML -->
								<span class="on"><i class="fa fa-check"
									aria-hidden="true"></i></span><span class="off"></span>
								<!--END-->
							</div>
						</label>
					</div>
					<div class="checkbox-div">
						Parking <label class="custom_switch"> <input
							type="checkbox" id="togBtn">
							<div class="slider round">
								<!--ADDED HTML -->
								<span class="on"><i class="fa fa-check"
									aria-hidden="true"></i></span><span class="off"></span>
								<!--END-->
							</div>
						</label>
					</div>
					<div class="filter-search-div">
						<input type="text" class="form-control" placeholder="Search">
						<div class="input-group">
							<button type="submit">
								<span class="glyphicon glyphicon-search"></span>
							</button>
						</div>
					</div>
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
									<c:forEach items="${service.favoritesEntities}"	var="favoritesEntities">
										<c:choose>
											<c:when
												test="${favoritesEntities.user_fav_entity.email == email}">
												<span class="fav">
												<img  id="ser_fav${service.service_id}" onclick="toggleFavorite(event, '${service.service_id}','1')" 
												src="resources/images/icons/favourite.png" alt="">Favourite</span>
											</c:when>
											<c:otherwise>
												<span class="fav"><img
													src="resources/images/icons/favorite.png" alt=""  id="ser_fav${service.service_id}"
													onclick="toggleFavorite(event, '${service.service_id}','0')">Favourite</span>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<c:if test="${empty service.favoritesEntities}">
										<span class="fav" ><img
													src="resources/images/icons/favorite.png" alt="" id="ser_fav${service.service_id}"
													onclick="toggleFavorite(event, '${service.service_id}','0')">Favourite</span>
									</c:if>
									<span class="share"><img src="resources/images/icons/share.png" alt="">share</span>
								</div>
									<a href="${service_type}/${service.service_id}/service_details.do">
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
									comments 
									<c:choose>
									<c:when test="${loggedIn}">
										<img src="resources/images/icons/comments.png" alt="" data-toggle="modal" data-target="#myModal">		
									</c:when>
									<c:otherwise>
										<img src="resources/images/icons/comments.png" alt="">
									</c:otherwise>
									</c:choose>
									<span class="comments">${service.commentsEntities.size()}</span>
									<div class="rating-readonly">
			                            <form>
			                                <input id="" value="${service.service_avg_rating}" type="text" class="rating" data-min=0 data-max=5 data-step=0.2 data-size="xs"
			                                        title="" disabled captio="none">
			                            </form>
			                        </div>
			                        <span class="comments">(${service.commentsEntities.size()})</span>
								</div>
							</div>
						</div>
					</div>
					<!-- Modal -->
					  <div class="modal fade" id="myModal" role="dialog">
					    <div class="modal-dialog">
					    
					      <!-- Modal content-->
					      <div class="modal-content">
					        <div class="modal-body" id="mod_comm" style="overflow-x: scroll;">
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
				<tag:paginate max="15" offset="${offset}" count="${count}"
					uri="${service_type}/service_listing.do" next="&raquo;"
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
			$("#homex,#estimatesx,#favoritesx,#estimatesx,#offersx").removeClass('active');
			$("#servicesx").addClass('active');
			/* $(".top-share-icon .fav").on("click", function(){
				var fullPath = $(this).find('img').attr('src');
				console.log(fullPath)
				var imageName = fullPath.replace(/^.*[\\\/]/, '');
				if(imageName == "favourite.png"){
					$(this).find('img').attr("src", "resources/images/icons/favorite.png");
				}
				else{
					$(this).find('img').attr("src", "resources/images/icons/favourite.png");
				}
			}); */
		});
		/* function removeFavorite(event, serviceId) {
			$.ajax({
				url : 'removeFavorite.do?&service_id='+serviceId,
				type : 'DELETE',
				contentType : 'application/json; charset=utf-8',
				success : function(msg) {
					alert(msg);
				},
				error : function(jqXHR, textStatus) {
					alert(textStatus);
				}
			});
		};
		function addFavorite(event, serviceId) {
			$.ajax({
				url : 'addFavorite.do?&service_id='+serviceId,
				type : 'GET',
				contentType : 'application/json; charset=utf-8',
				success : function(msg) {
					alert(msg);
				},
				error : function(jqXHR, textStatus) {
					alert(textStatus);
				}
			});
		}; */
		function toggleFavorite(event, serviceId, status) {
			$.ajax({
				url : 'toggleFavorite.do?&service_id='+serviceId+'&status='+status,
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
					
				},
				error : function(jqXHR, textStatus) {
					alert(textStatus);
				}
			});
		};
	</script>
</body>
</html>