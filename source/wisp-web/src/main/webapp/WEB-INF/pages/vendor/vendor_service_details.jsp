<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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

	<%@ include file="/WEB-INF/pages/vendor/templetes/header.jsp"%>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h5 class="service-heading"></h5>
			</div>
			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="col-md-12 col-sm-12 col-xs-12 service-box-right white-bg">
					<div class="top-share-icon">
						<input type="hidden" value="${service_details.service_id}" id="service_id" name="service_id"/>
						<c:if test="${service_details.approval_status != 1}">
							<a href="vendor/${service_details.service_id}/edit_service"><span class="share"><img src="resources/images/icons/edit.png" alt="">Edit</span></a>
						</c:if>
						<c:choose>
							<c:when test="${service_details.approval_status == 0}">
								<span class="share"><img src="resources/images/icons/status.png" alt="">Yet to Submit</span>
							</c:when>
							<c:when test="${service_details.approval_status == 1}">
								<span class="share"><img src="resources/images/icons/status.png" alt="">Pending Approval</span>
							</c:when>
							<c:when test="${service_details.approval_status == 2}">
								<span class="share"><img src="resources/images/icons/status.png" alt="">Approved</span>
							</c:when>
							<c:when test="${service_details.approval_status == 3}">
								<span class="share"><img src="resources/images/icons/status.png" alt="">Rejected</span>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
						<span class="share"><img src="resources/images/icons/share.png" alt="">share <i class="fa fa-caret-down" aria-hidden="true"></i>
	                        <div class="social-networks">
								<ul>
									<li class="social-twitter"><a
										data-js="${pageContext.request.contextPath}/${service_details.service_type.description}/${service_details.service_id}/service_details"
										class="twitterShare"><i class="fa fa-twitter"></i></a></li>
									<li class="social-facebook"><a
										data-js="${pageContext.request.contextPath}/${service_details.service_type.description}/${service_details.service_id}/service_details"
										class="facebookShare"><i class="fa fa-facebook"></i></a></li>
									<li class="social-gplus"><a
										data-js="${pageContext.request.contextPath}/${service_details.service_type.description}/${service_details.service_id}/service_details"
										class="googleShare"><i class="fa fa-google-plus"></i></a></li>
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
						<a href="vendor/home"><span class="share"><img src="resources/images/icons/back.png" alt="">Back</span></a>
					</div>
					<p class="name">${service_details.service_name}</p>
					<p class="contact">	${service_details.addressEntity.address_1} , &nbsp
										${service_details.addressEntity.address_2}, &nbsp
										${service_details.addressEntity.city}, &nbsp
										${service_details.addressEntity.state}, &nbsp
										${service_details.addressEntity.country}, &nbsp
										${service_details.addressEntity.pincode}
								</p>
								<br>
								<p class="phone">Phone : ${service_details.service_phone}</p>
								<c:if test="${service_details.service_website != null}">
									| &nbsp;&nbsp;<p class="phone">Website : ${service_details.service_website}</p>
								</c:if>
								<c:if test="${service_details.service_email != null}">
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
						<c:if test="${empty service_details.imagesEntities && empty service_details.videosEntities}">
							<div>
								<img u="image" src="resources/images/no_image_available.jpg" />
								<img u="thumb" src="resources/images/no_image_available.jpg" />
							</div>
						</c:if>
						<!-- Images -->
						<c:forEach items="${service_details.imagesEntities}" var="image" varStatus="loop_image">
							<div>
								<img u="image" src="${image.image_url}" /> <img u="thumb" src="${image.image_url}" />
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
						<span class="fav" data-serviceid="${service_details.service_id}">comments 
						<img src="resources/images/icons/comments.png" alt=""> <span
							class="comments">${service_details.commentsEntities.size()}</span>
							<div class="rating-readonly">
								<form>
									<input id="" value="${service_details.service_avg_rating}" type="text"
										class="rating" data-min=0 data-max=5 data-step=1
										data-size="xs" title="" disabled captio="none">
								</form>
							</div>
							<span class="comments">(${service_details.commentsEntities.size()})</span>
							</span>
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
            <div class="col-md-12">
                <div class="col-md-12 white-bg pTop10 mTop10">
                    <form class="form-inline text-center" id="daterange_chart">
                        <div class="input-group input-daterange">
                            <!-- <input name="fromDate" placeholder="From Date" type="text" class="form-control" value="2012-04-05"> -->
                            <div class='input-group date' id=example1>
	                            <input name="fromDate" type='text' class="form-control"  placeholder="From Date" />
	                            <span class="input-group-addon">
		                            <span class="fa fa-calendar"></span>
		                        </span>
	                      	</div>
                            <div class="input-group-addon">to</div>
                            <!-- <input name="toDate"  placeholder="To Date" type="text" class="form-control" value="2012-04-19"> -->
                        	<div class='input-group date' id='example2'>
                                <input name="toDate" type='text' class="form-control" placeholder="To Date" />
                                <span class="input-group-addon">
                               	 	<span class="fa fa-calendar"></span>
	                        	</span>
	                      	</div>
                        </div>
                        <button type="submit" id="insights_refresh" class="btn custom-button more">Refresh</button>
                        <a href="javascript:void(0)" id="service_insights" class="btn custom-button more">Get Details</a>
                        <!-- <button type="submit" class="btn custom-button more">Get Details</button> -->
                    </form>
                    <div id="chart_div"></div>
                </div>
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
	<script src="resources/js/socialauth.js"></script>
    <script>
        $(document).ready(function(){
        	
        	$("#homex,#estimatesx,#favoritesx,#estimatesx,#offersx").removeClass('active');
			$("#servicesx").addClass('active');
			
			Date.prototype.yyyymmdd = function() {
            	  var yyyy = this.getFullYear().toString();
            	  var mm = (this.getMonth()+1).toString(); // getMonth() is zero-based
            	  var dd  = this.getDate().toString();
            	  return yyyy + "-" + (mm[1]?mm:"0"+mm[0]) + "-" + (dd[1]?dd:"0"+dd[0]); // padding
            	};
            $('.input-daterange input').each(function() {
            	$(this).datepicker({
					format: 'yyyy-mm-dd'
				 });
                $(this).datepicker('clearDates', { minDate: 0});
            });
			var id = $("#service_id").val();
            $("#insights_refresh").on("click", function(e){
            	e.preventDefault();
            	createChart(id,$("[name='fromDate']").val(),$("[name='toDate']").val());
                
            });
            	
            var date = new Date();
        	var fromDate = date.yyyymmdd();
        	var date1 = new Date();
        	date1.setMonth(date1.getMonth() - 6);
        	var toDate = date1.yyyymmdd();
        	createChart(id,toDate,fromDate);
        	
            $(window).resize(function(){
                google.charts.load('current', {packages: ['corechart', 'line']});
                google.charts.setOnLoadCallback(drawBasic);
            });
            
            $('#example1').datepicker({
                format: "dd/mm/yyyy",
                autoclose: true
            });
            
            $('#example2').datepicker({
                format: "dd/mm/yyyy"
            }).on('change', function () {
                $('.datepicker').hide();
            });
            
        });
        
        $("#service_insights").on("click", function(e){
        	var id = $("#service_id").val();
        	var fromDate = $("[name='fromDate']").val();
        	var toDate = $("[name='toDate']").val();
        	if(id && fromDate && toDate) {
        		var form = document.createElement("form");
                var element1 = document.createElement("input"); 
                var element2 = document.createElement("input");
                var element3 = document.createElement("input");

                form.method = "GET";
                form.action = "vendor/downloadInsights";   

                element1.value=id;
                element1.name="id";
                form.appendChild(element1);  

                element2.value=fromDate;
                element2.name="fromDate";
                form.appendChild(element2);
                
                element3.value=toDate;
                element3.name="toDate";
                form.appendChild(element3);

                document.body.appendChild(form);

                form.submit();
        	} else {
        		alert('Please select from and to dates..!');
        	}
        	
        });
        
        function createChart(id, toDate, fromDate){
        	console.log(id);
        	google.charts.load('current', {packages: ['corechart', 'line']});
            google.charts.setOnLoadCallback(drawBasic);
            function drawBasic() {
                  var data = new google.visualization.DataTable();
                  data.addColumn('date', 'Date');
                  data.addColumn('number', 'Views');
                  $.ajax({
                    url: "vendor/getAccessHistory/"+id+"/"+toDate+"/"+fromDate+"",
                    /* data: "GET", */
                    success: function(arr){
                       for (var i = 0; i < arr.length; i++) {
                             data.addRow([new Date(parseInt(arr[i].year), parseInt(arr[i].month-1),parseInt(arr[i].day)), arr[i].hits_count]);
                        }
                      var options = {
                        hAxis: {
                          title: 'Dates',
                          gridlines: {
                              color: 'transparent'
                          }
                        },
                        vAxis: {
                          title: 'No Of Views',
                          gridlines: {
                              color: 'transparent'
                          }
                        }
                      };
                  var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
                  chart.draw(data, options);
                    }
                  });
                } // end drawBasis function
        }
        
        
    </script>
</body>
</html>