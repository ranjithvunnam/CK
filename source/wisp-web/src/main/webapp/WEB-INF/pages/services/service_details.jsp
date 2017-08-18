<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
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
<link rel="stylesheet" type="text/css" href="resources/slick/slick-theme.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="resources/css/star-rating.css">
<link rel="stylesheet" href="resources/css/jssor.css">
<link rel="stylesheet" type="text/css" href="resources/css/pignose.calendar.css" />
<link href="resources/css/custom.css" rel="stylesheet">

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
				<h5 class="service-heading">quick links place holder</h5>
			</div>
			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="col-md-12 col-sm-12 col-xs-12 service-box-right white-bg">
					<div class="top-share-icon">
						<c:set var="isFavorite" value="false" />
						<c:forEach items="${service_details.favoritesEntities}" var="favoritesEntities">
							<c:if test="${favoritesEntities.user_fav_entity.email == email}">
								<c:set var="isFavorite" value="true" />
							</c:if>
						</c:forEach>
						<c:choose>
							<c:when test="${isFavorite eq true}">
								<span class="fav" ><img	src="resources/images/icons/favourite.png" alt="" 
									id="ser_fav${service_details.service_id}" onclick="toggleFavorite(event, '${service_details.service_id}','1')" >Favourite</span>
							</c:when>
							<c:otherwise>
								<span class="fav" ><img
										src="resources/images/icons/favorite.png" alt="" 
										id="ser_fav${service_details.service_id}" onclick="toggleFavorite(event, '${service_details.service_id}','0')" >Favourite</span>
							</c:otherwise>
						</c:choose>
						<span class="share"><img src="resources/images/icons/share.png" alt="">share</span>
					</div>
					<p class="name">${service_details.service_name}</p>
					<p class="contact">	${service_details.addressEntity.address_1} 
										${service_details.addressEntity.address_2}
										${service_details.addressEntity.city}
										${service_details.addressEntity.state}
										${service_details.addressEntity.country}
										${service_details.addressEntity.pincode}
					</p>
					<p class="phone">Phone : ${service_details.service_phone}</p>
					<p class="web">Website : ${service_details.service_website}</p>
				</div>
			</div>
		</div>
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
					<div u="slides"
						style="cursor: move; position: absolute; left: 0px; top: 0px; width: 720px; height: 480px; overflow: hidden;">
						<c:if
							test="${empty service_details.imagesEntities && empty service_details.videosEntities}">
							<div>
								<img u="image" src="resources/images/no_image_available.jpg" />
								<img u="thumb" src="resources/images/no_image_available.jpg" />
							</div>
						</c:if>
						<!-- Images -->
						<c:forEach items="${service_details.imagesEntities}" var="image" varStatus="loop">
							<div>
								<img u="image" src="${image.image_url}" /> <img u="thumb"
									src="${image.image_url}" />
							</div>
						</c:forEach>
						<!-- Videos -->
						<c:forEach items="${service_details.videosEntities}" var="video" varStatus="loop_video">
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
					<!-- Thumbnail Navigator Skin End -->
				</div>
			</div>
			<div class="col-md-12 col-sm-12 col-xs-12 mTop10">
				<div
					class="col-md-12 col-sm-12 col-xs-12 service-box-right white-bg">
					<h5 class="service-heading"></h5>
					<p class="address">${service_details.service_description}</p>
					<div class="ratings">
						Photos <span class="photos">${service_details.imagesEntities.size()}</span> videos <span class="videos">${service_details.videosEntities.size()}</span>
						comments <img src="resources/images/icons/comments.png" alt=""> <span
							class="comments">${service_details.commentsEntities.size()}</span>
							<div class="rating-readonly">
								<form>
									<input id="" value="${service_details.service_avg_rating}" type="text"
										class="rating" data-min=0 data-max=5 data-step=1
										data-size="xs" title="" disabled captio="none">
								</form>
							</div>
							<span class="comments">(${service_details.commentsEntities.size()})</span>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div
					class="col-md-12 col-sm-12 col-xs-12 service-box-right white-bg mTop10 pbot10">
					<h5 class="service-heading">Amenities</h5>
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
									<c:if test="${service_details.service_type eq 'SER_CATERERS' || service_details.service_type eq 'SER_PHOTOGRAPHY' 
										|| service_details.service_type eq 'SER_ENTERTAINERS' || service_details.service_type eq 'SER_BEAUTICIANS'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Type</p>
											<p>${service_details.amenitiyEntity.type}</p>
										</div>
									</c:if>
									<c:if test="${service_details.service_type eq 'SER_CATERERS'}">
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
									</c:if>
									<c:if test="${service_details.service_type eq 'SER_BEAUTICIANS'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Gender</p>
											<p>${service_details.amenitiyEntity.gender}</p>
										</div>
									</c:if>
									<c:if test="${service_details.service_type eq 'SER_CHOREOGRAPHERS'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Dance Style</p>
											<p>${service_details.amenitiyEntity.dance_style}</p>
										</div>
									</c:if>
									<c:if test="${service_details.service_type eq 'SER_TRAVEL'}">
										<div class="specifications">
											<img src="resources/images/icons/rooms.png" alt="">
											<p>Fleet</p>
											<p>${service_details.amenitiyEntity.fleet}</p>
										</div>
									</c:if>
								</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-md-12 mTop10 availability">
				<div class="col-xs-12 col-md-5 col-lg-5 date pbot10">
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
							<h5 class="service-heading">Check Availability</h5>
						</div>
						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
							<p class="mTop20">Select Event Date</p>
						</div>
						<!-- <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 text-center">

							<div class="calendar"></div>
							<button class="btn custom-button mTop10">Enquiry</button>
						</div> -->
					</div>
				</div>
				<div class="col-xs-12 col-md-7 col-lg-7 feedback-box">
					<div class="col-md-12 feedback pbot12">
						<h5 class="service-heading">Your feedback</h5>
						<c:set var="feedback_status" value="false"/>
						<c:forEach items="${service_details.commentsEntities}" var="comments">
							<c:if test="${comments.user_comments_entity.email == email}">
								<c:set var="feedback_status" value="true" />
								<c:set var="feedback_rating" value="${comments.rating}" />
								<c:set var="feedback_comment" value="${comments.comment_desc}" />
							</c:if>
						</c:forEach>
						<!-- Submitted feedback -->
						<c:choose>
							<c:when test="${feedback_status}">
								<form class="form-horizontal" id="feedback_form">
									<div class="form-group rating-user">
										<label for="inputEmail3" class="col-sm-2 control-label">Rate</label>
										<div class="col-sm-10">
											<div class="rating-readonly">
												<input id="" value="${feedback_rating}" type="text"
													class="rating" data-min=0 data-max=5 data-step=0.2
													data-size="xs" title="" disabled captio="none">
											</div>
										</div>
									</div>
									<div class="form-group">
										<label for="inputEmail3" class="col-sm-2 control-label">Comments</label>
										<div class="col-sm-10">
											<p class="form-control">${feedback_comment}</p>
										</div>
									</div>
								</form>
							</c:when>
							<c:otherwise>
								<form class="form-horizontal" id="feedback_form">
									<input type="hidden" name="feedback_ser_id"
										value="${service_details.service_id}" />
									<div class="form-group rating-user">
										<label for="inputEmail3" class="col-sm-2 control-label">Rate</label>
										<div class="col-sm-10">
											<input id="rating" value="0" type="text"
												name="feedback_rating" class="rating" data-min=0 data-max=5
												data-step=0.2 data-size="xs" title="">
										</div>
									</div>
									<div class="form-group">
										<label for="inputEmail3" class="col-sm-2 control-label">Comments</label>
										<div class="col-sm-10">
											<textarea class="form-control" rows="3"
												name="feedback_comments"></textarea>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-offset-2 col-sm-10">
											<button type="submit" class="btn custom-button">Submit</button>
										</div>
									</div>
								</form>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-md-12 mTop10">
				<c:forEach items="${service_details.commentsEntities}" var="comment">
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
		<%@ include file="/WEB-INF/pages/templetes/suggest_temp.jsp"%>
	</div>
	<%@ include file="/WEB-INF/pages/templetes/footer.jsp"%>
	<!-- Modal -->
					<div class="modal fade" id="myModal" role="dialog">
						<div class="modal-dialog modal-lg">
							
							<!-- Modal content-->
							<div class="modal-content" style="border-radius: unset;">
								<div class="modal-header">
								  <button type="button" class="close" data-dismiss="modal">&times;</button>
								  <h4 class="modal-title">Send an Enquiry</h4>
								</div>
								<div class="modal-body" id="mod_comm" style="overflow-x: scroll;">
								<section id="contact" style="">
								<div class="col-md-12">
									<form name="contactusform" id="contactForm" role="form" action="sendEnquiry" method="POST">
										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<form:input type="text" name="name" class="form-control"
														placeholder="Your Name *" id="name" required=""
														path="contactUs.name"
														data-validation-required-message="Please enter your name." />
													<p class="help-block text-danger"></p>
												</div>
												<div class="form-group">
													<form:input type="email" name="email" class="form-control"
														placeholder="Your Email *" id="email" required=""
														path="contactUs.email"
														data-validation-required-message="Please enter your email address." />
													<p class="help-block text-danger"></p>
												</div>
												<div class="form-group">
													<form:input type="text" maxlength="10" name="mobile"
														class="form-control" placeholder="Your Phone *" id="phone"
														required="" path="contactUs.phone"
														data-validation-required-message="Please enter your phone number." />
													<p class="help-block text-danger"></p>
												</div>
											</div>
											<div class="col-md-6">
												<div class="form-group">
													<form:textarea class="form-control" name="yourmessage"
														placeholder="Your Message *" id="message" required=""
														path="contactUs.message"
														data-validation-required-message="Please enter a message."></form:textarea>
													<p class="help-block text-danger"></p>
												</div>
												<div style="text-align: right;">
													<div id="success"></div>
													<button type="submit" class="btn custom-button">Submit</button>
													<button type="reset" class="btn custom-button">Reset</button>
												</div>
											</div>
											<div class="clearfix"></div>
										</div>
									</form>
								</div>
							</section>
							</div>
							</div>
						</div>
					</div>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script type="text/javascript"
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script type="text/javascript" src="resources/js/moment.latest.min.js"></script>
	<script type="text/javascript" src="resources/js/pignose.calendar.js"></script>
	<script type="text/javascript">
    $(function() {
        function onClickHandler(date, obj) {
			alert("service3.html - you have selected "+ date[0].format('YYYY-MM-DD'));
			$('#myModal').modal('show');            
        }

        // Default Calendar
        $('.calendar').pignoseCalendar({
            select: onClickHandler
        });

        // This use for DEMO page tab component.
        $('.menu .item').tab();
    });
    </script>
    <script type="text/javascript">
	    var frm = $('#contactForm');
	    frm.submit(function (e) {
	        e.preventDefault();
	        $.ajax({
	            type: frm.attr('method'),
	            url: frm.attr('action'),
	            data: frm.serialize(),
	            success: function (data) {
	                console.log('Submission was successful.');
	                console.log(data);
	                $('#myModal').modal('hide'); 
	            },
	            error: function (data) {
	                console.log('An error occurred.');
	                console.log(data);
	            },
	        });
	    });
	</script>
	<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="resources/slick/slick.js" charset="utf-8"></script>
	<script type="text/javascript" src="resources/js/custom.js"></script>
	<script type="text/javascript" src="resources/js/star-rating.js"></script>
	<script type="text/javascript" src="resources/js/custom-jssor.js"></script>
	<script type="text/javascript" src="resources/js/jssor.slider.js"></script>
	<script type="text/javascript" src="resources/js/jssor.js"></script>
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
                // You can unslick at a given breakpoint now by adding:
                // settings: "unslick"
                // instead of a settings object
              ]
            });
        });
    </script>
    <script type="text/javascript">
		$(document).ready(function(){
			$("#homex,#estimatesx,#favoritesx,#estimatesx,#offersx").removeClass('active');
			$("#servicesx").addClass('active');
		});
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
		$( "#feedback_form" ).submit(function( event ) {
			/* stop form from submitting normally */
            event.preventDefault();
            var service_id = $(event.target).find('[name="feedback_ser_id"]').val();
            var rating = $(event.target).find('[name="feedback_rating"]').val();
            var comment_desc = $(event.target).find('[name="feedback_comments"]').val();
			$.ajax({
				url : 'submitFeedBack',
				type : 'POST',
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify({
					service_id : service_id,
					rating : rating,
					comment_desc : comment_desc
				}),
				success : function(msg) {
					$('#feedback_form')[0].reset();
					alert("FeedBack submitted..");
					$("#feedback_form").empty();
					$("#feedback_form").append('<div class="form-group rating-user">'+'<label for="inputEmail3" class="col-sm-2 control-label">Rate</label>'
							+'<div class="col-sm-10"><div class="rating-readonly"><input id="" value="'+rating+'" type="text" '
							+'class="rating" data-min=0 data-max=5 data-step=0.2 data-size="xs" title="" disabled captio="none"></div></div>'
							+'</div><div class="form-group"><label for="inputEmail3" class="col-sm-2 control-label">Comments</label>'
							+'<div class="col-sm-10"><p class="form-control">'+comment_desc+'</p></div></div>');
				},
				error : function(jqXHR, textStatus) {
					alert(textStatus);
				}
			});
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
					
				},
				error : function(jqXHR, textStatus) {
					alert(textStatus);
				}
			});
		};
	</script>

</body>

</html>