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

	<%@ include file="/WEB-INF/pages/admin/templetes/header.jsp"%>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h5 class="service-heading"></h5>
			</div>
			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="col-md-12 col-sm-12 col-xs-12 service-box-right white-bg">
					<div class="top-share-icon">
						<a href="javascript:function() { return false; }"  id="handleReport" 
							onclick="handleReportedMessage(event, '${service_details.service_id}', '2')"><span class="share"><img src="resources/images/icons/accept.png" alt="">Approve</span></a>
						<%-- <a href="javascript:function() { return false; }"  id="handleReport" 
							onclick="handleReportedMessage(event, '${service_details.service_id}', '3')"><span class="share"><img src="resources/images/icons/reject.png" alt="">Reject</span></a> --%>
						<a href="javascript:function() { return false; }" data-toggle="modal" data-target="#reject_comment_modal" data-whatever="@mdo"><span class="share"><img src="resources/images/icons/reject.png" alt="">Reject</span></a>
					</div>
					<p class="name">${service_details.service_name}</p>
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
					<%-- <h5 class="service-heading">${service_details.service_name}</h5> --%>
					<p class="address">${service_details.service_description}</p>
					<div class="ratings">
						Photos <span class="photos">${service_details.imagesEntities.size()}</span> videos <span class="videos">${service_details.videosEntities.size()}</span>
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
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/pages/templetes/footer.jsp"%>
	<div class="modal fade" id="reject_comment_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-body">
	        <form id="reject_form">
	          <div class="form-group">
	            <input type="hidden" class="form-control" id="service_id" value="${service_details.service_id}">
	          </div>
	          <div class="form-group">
	            <label for="message-text" class="form-control-label">Comments:</label>
	            <textarea class="form-control" id="reject_comment" rows="5"></textarea>
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" onclick="rejectWithMessage(event)">RejectWithMessage</button>
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
		$('#reject_comment_modal').on('hidden.bs.modal', function () {
			$('#reject_comment').val('');
		});
		function rejectWithMessage(event) {
			var service_id = $('#service_id').val();
			var reject_comment = $('#reject_comment').val();
			if($.trim(reject_comment) == ''){
			      alert('Please provide the reason');
			      event.preventDefault();
			  } else {
				  $.ajax({
						url : 'admin/update_status',
						type : 'DELETE',
						contentType : 'application/json; charset=utf-8',
						data : JSON.stringify({
							service_id : service_id,
							status : 3,
							rejectComments : reject_comment
						}),
						success : function(msg) {
							alert("Status updated successfully.");
							window.location = 'admin/dashboard';
						},
						error : function(jqXHR, textStatus) {
							alert(textStatus);
						}
					});  
			  }
		}
		function handleReportedMessage(event, service_id, status) {
			var conBox = confirm("Are you sure ?");
			if (conBox) {
				$.ajax({
					url : 'admin/update_status',
					type : 'DELETE',
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify({
						service_id : service_id,
						status : status
					}),
					success : function(msg) {
						alert("Status updated successfully.");
						window.location = 'admin/dashboard';
					},
					error : function(jqXHR, textStatus) {
						alert(textStatus);
					}
				});
			} else {
				event.preventDefault();
			};
		};
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
</body>
</html>