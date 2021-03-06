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
<title>CelebrateKaro</title>
<link rel="shortcut icon" href="resources/images/logo.ico" type="image/x-icon">
<base
	href="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/" />
<!-- Bootstrap -->
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="resources/slick/slick.css">
<link rel="stylesheet" type="text/css"
	href="resources/slick/slick-theme.css">
<link href="resources/css/custom.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<style>
	#search-result{
		padding: 0;		
	}
	#search-result li{
		background-color: #949494;
		padding: 10px 2px;
		list-style: none;
		color: #fff;
		font-weight: 500;
	}
	</style>
</head>
<body>
	<%@ include file="templetes/header.jsp"%>
	<div class="container-fluid">
		<div class="row slider-top">
			<div class="search-div">
				<div class="search">
					<div class="input-group stylish-input-group" id="search-home">
						<input type="text" id="tagQuery" name="tagQuery" class="form-control" onFocus="inputFocus(this)" onBlur="inputBlur(this)" placeholder="Search">
						<a href="javascript:void(0);" id="_tagquerylist"><i class="fa fa-search search-placeholder-icon" aria-hidden="true"></i></a>
                        <div class="search-items">
							
                        </div>
						<!-- <input id="tagQuery" type="text" name="tagQuery" class="form-control" placeholder="Search" onFocus="inputFocus(this)" onBlur="inputBlur(this)">
						<ul id="search-result"></ul> -->
					</div>
				</div>
			</div>
			<div id="carousel-example-generic" class="carousel slide"
				data-ride="carousel">
				<!-- Indicators -->
				<ol class="carousel-indicators">
					<c:forEach items="${slider_images}" var="slider_image"
						varStatus="loop">
						<li data-target="#carousel-example-generic"
							data-slide-to="${loop.index}"
							${loop.index == 0 ? 'class = "active"' : ''}></li>
					</c:forEach>
				</ol>
				<!-- Wrapper for slides -->
				<div class="carousel-inner" role="listbox">
					<c:forEach items="${slider_images}" var="slider_image"
						varStatus="loop">
						<div
							${loop.index == 0 ? 'class = "item active"' : 'class = "item"'}>
							<img src="${slider_image.slider_url}" alt="...">
							<div class="carousel-caption">...</div>
						</div>
					</c:forEach>
				</div>
				<!-- Controls -->
				<a class="left carousel-control" href="#carousel-example-generic"
					role="button" data-slide="prev"> <span
					class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</a> <a class="right carousel-control" href="#carousel-example-generic"
					role="button" data-slide="next"> <span
					class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</a>
			</div>
		</div>
	</div>
	<!-- end of slider  -->
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h5 class="service-heading">
					<a href="Venue/service_listing">Mesmerizing Venues</a>
				</h5>
				<section class="mesmerizing slider">
					<c:forEach items="${venue_list}" var="venue" varStatus="loop">
						<div>
							<c:choose>
						    <c:when test="${loggedIn}">
								    <a href="Venue/${venue.service_id}/service_details">
								    <c:choose>
								    	<c:when test="${not empty venue.imagesEntities}">
								    		<img src="${venue.imagesEntities.iterator().next().image_url}">
								    	</c:when>
								    	<c:otherwise>
								    		<img src="resources/images/no_image_available.jpg">
								    	</c:otherwise>
								    </c:choose>
									<div class="overlay">${venue.service_name}</div>
								    </a>
						    </c:when>
						    <c:otherwise>
								    <a href="Venue/${venue.service_id}/service_par_listing">
								    <c:choose>
								    	<c:when test="${not empty venue.imagesEntities}">
								    		<img src="${venue.imagesEntities.iterator().next().image_url}">
								    	</c:when>
								    	<c:otherwise>
								    		<img src="resources/images/no_image_available.jpg">
								    	</c:otherwise>
								    </c:choose>
									<div class="overlay">${venue.service_name}</div>
								    </a>
						    </c:otherwise>
						    </c:choose>
						</div>
					</c:forEach>
				</section>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h5 class="service-heading">
					<a href="Caterers/service_listing">Mouth Watering Caterers</a>
				</h5>
				<section class="mouthwatering slider">
					<c:forEach items="${caterers_list}" var="caterer" varStatus="loop">
						<div>
							<c:choose>
						    <c:when test="${loggedIn}">
								    <a href="Caterers/${caterer.service_id}/service_details">
								    <c:choose>
								    	<c:when test="${not empty caterer.imagesEntities}">
								    		<img src="${caterer.imagesEntities.iterator().next().image_url}">
								    	</c:when>
								    	<c:otherwise>
								    		<img src="resources/images/no_image_available.jpg">
								    	</c:otherwise>
								    </c:choose>
									<div class="overlay">${caterer.service_name}</div>
								    </a>
						    </c:when>
						    <c:otherwise>
								    <a href="Caterers/${caterer.service_id}/service_par_listing">
								    <c:choose>
								    	<c:when test="${not empty caterer.imagesEntities}">
								    		<img src="${caterer.imagesEntities.iterator().next().image_url}">
								    	</c:when>
								    	<c:otherwise>
								    		<img src="resources/images/no_image_available.jpg">
								    	</c:otherwise>
								    </c:choose>
									<div class="overlay">${caterer.service_name}</div>
								    </a>
						    </c:otherwise>
						    </c:choose>
						</div>
					</c:forEach>
				</section>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h5 class="service-heading">
					<a href="Photography/service_listing">Mind Blowing
						Photography</a>
				</h5>
				<section class="photography slider">
					<c:forEach items="${photography_list}" var="photography"
						varStatus="loop">
						<div>
							<c:choose>
						    <c:when test="${loggedIn}">
								    <a href="Photography/${photography.service_id}/service_details">
								    <c:choose>
								    	<c:when test="${not empty photography.imagesEntities}">
								    		<img src="${photography.imagesEntities.iterator().next().image_url}">
								    	</c:when>
								    	<c:otherwise>
								    		<img src="resources/images/no_image_available.jpg">
								    	</c:otherwise>
								    </c:choose>
									<div class="overlay">${photography.service_name}</div>
								    </a>
						    </c:when>
						    <c:otherwise>
								    <a href="Photography/${photography.service_id}/service_par_listing">
								    <c:choose>
								    	<c:when test="${not empty photography.imagesEntities}">
								    		<img src="${photography.imagesEntities.iterator().next().image_url}">
								    	</c:when>
								    	<c:otherwise>
								    		<img src="resources/images/no_image_available.jpg">
								    	</c:otherwise>
								    </c:choose>
									<div class="overlay">${photography.service_name}</div>
								    </a>
						    </c:otherwise>
						    </c:choose>
						</div>
					</c:forEach>
				</section>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h5 class="service-heading">
					<a href="#">All Services</a>
				</h5>
				<div class="icon-container">
				<div class="icon">
					<a href="Venue/service_listing">
                    <img src="resources/images/icons/venues.png" alt="">
                    <p>Venues</p>
                    </a>
                </div>
                <div class="icon">
                	<a href="Caterers/service_listing">
                    <img src="resources/images/icons/catering.png" alt="">
                    <p>Caterers</p>
                    </a>
                </div>
                <div class="icon">
                	<a href="Photography/service_listing">
                    <img src="resources/images/icons/photographers.png" alt="">
                    <p>Photographers</p>
                     </a>
                </div>
                <div class="icon">
                	<a href="EventPlanners/service_listing">
                    <img src="resources/images/icons/event-planer.png" alt="">
                    <p>Event Planners</p>
                     </a>
                </div>
                <div class="icon">
                	<a href="EventDesigners/service_listing">
                    <img src="resources/images/icons/event-desinger.png" alt="">
                    <p>Event Designers</p>
                     </a>
                </div>
                <div class="icon">
                	<a href="Florists/service_listing">
                    <img src="resources/images/icons/florists.png" alt="">
                    <p>Florists</p>
                     </a>
                </div>
                <div class="icon">
                	<a href="Pandits/service_listing">
                    <img src="resources/images/icons/pandits.png" alt="">
                    <p>Pandits</p>
                     </a>
                </div>
                <div class="icon">
                	<a href="Baaraat/service_listing">
                    <img src="resources/images/icons/baarat.png" alt="">
                    <p>Baaraat</p>
                     </a>
                </div>
                <div class="icon">
                	<a href="D.J/service_listing">
                    <img src="resources/images/icons/dj.png" alt="">
                    <p>D.J</p>
                     </a>
                </div>
                <div class="icon">
                	<a href="Entertainers/service_listing">
                    <img src="resources/images/icons/entertainers.png" alt="">
                    <p>Entertainers</p>
                     </a>
                </div>
                <div class="icon">
                	<a href="CardDesigners/service_listing">
                    <img src="resources/images/icons/cards.png" alt="">
                    <p>Card Designers</p>
                     </a>
                </div>
                <div class="icon">
                	<a href="MakeupArtists/service_listing">
                    <img src="resources/images/icons/beauticians.png" alt="">
                    <p>Makeup Artists</p>
                     </a>
                </div>
                <div class="icon">
                	<a href="MehendiArtists/service_listing">
                    <img src="resources/images/icons/mehandi.png" alt="">
                    <p>Mehendi Artists</p>
                     </a>
                </div>
                <div class="icon">
                	<a href="Musicians/service_listing">
                    <img src="resources/images/icons/musicians.png" alt="">
                    <p>Musicians</p>
                     </a>
                </div>
                <div class="icon">
                	<a href="Choreographer/service_listing">
                    <img src="resources/images/icons/choreographers.png" alt="">
                    <p>Choreographer</p>
                     </a>
                </div>
                <div class="icon">
                	<a href="TravelAgency/service_listing">
                    <img src="resources/images/icons/travel.png" alt="">
                    <p>Travel Agency</p>
                     </a>
                </div>
				</div>
			</div>
		</div>
	</div>
	<!-- <div class="container">
		<div class="row">
			<div class="col-md-4 service-info-box">
				<div class="wrapper">
					<h5 class="service-heading text-center">Become a partner</h5>
					<p>It is a long established fact that a reader will be
						distracted by the readable content of a page when looking at its
						layout. The point.</p>
					<button type="submit" class="btn custom-button more">More</button>
				</div>
			</div>
			<div class="col-md-4 service-info-box">
				<div class="wrapper">
					<h5 class="service-heading text-center">Need Help</h5>
					<p>It is a long established fact that a reader will be
						distracted by the readable content of a page when looking at its
						layout. The point.</p>
					<button type="submit" class="btn custom-button more">More</button>
				</div>
			</div>
			<div class="col-md-4 service-info-box">
				<div class="wrapper">
					<h5 class="service-heading text-center">Testimonials</h5>
					<p>It is a long established fact that a reader will be
						distracted by the readable content of a page when looking at its
						layout. The point.</p>
					<button type="submit" class="btn custom-button more">More</button>
				</div>
			</div>
		</div>
	</div> -->
	<%@ include file="templetes/footer.jsp"%>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/slick/slick.js" type="text/javascript" charset="utf-8"></script>
	<script src="resources/js/custom.js" type="text/javascript"></script>
	<script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
	<script type="text/javascript" src="resources/js/timeme.js"></script>
	<script type="text/javascript">
	
		/* TimeMe.initialize({
		    currentPageName: "Home - Page", // page name
		    idleTimeoutInSeconds: 15 // time before user considered idle
		});
		
		window.onbeforeunload = function(){
		    xmlhttp=new XMLHttpRequest();
		    xmlhttp.open("POST","ENTER_URL_HERE", false);
		    xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		    var timeSpentOnPage = TimeMe.getTimeOnCurrentPageInSeconds();
		    xmlhttp.send(timeSpentOnPage);
		}; */
		
		$(document).ready(function() {
			$("#servicesx,#estimatesx,#favoritesx,#estimatesx,#offersx").removeClass('active');
				$("#homex").addClass('active');
			$('.mesmerizing, .mouthwatering, .photography').slick({
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
			
			//attach autocomplete
			$('body').on("click", function(e){
				if ($(e.target).hasClass('ui-autocomplete-input')) {
					//$("#tagQuery").trigger("autocompleteselect");
					return false;
				}
				$(".search-items").empty();
				
			});
			
			$('#_tagquerylist').on("click", function(e){
				var name = $("#tagQuery").val();        
			    if (name && name.length > 2) {
			        window.location = 'services/search?_q=' +encodeURIComponent(name);
			    }
			});
			
			$('#tagQuery').on("keypress", function(e) {
		        if (e.keyCode == 13) {
		        	var name = $("#tagQuery").val();
		        	if (name && name.length > 2) {
		        		window.location = 'services/search?_q=' +encodeURIComponent(name);
		        	}
		            return false; // prevent the button click from happening
		        }
			});
		
			$('#tagQuery').click(function() {
			   $('#autocomplete').trigger("focus"); //or "click", at least one should work
			});
		
			$("#tagQuery").autocomplete({
				minLength: 3,
				delay: 300,
				autoFocus: true,
				//define callback to format results
				source: function (request, response) {
					$(".search-items").empty();
					$.getJSON("simulateSearch", request, function(result) {
						console.log(result);
						response($.map(result, function(item) {
							
								$(".search-items").append('<a href="'+item.service_type+'/'+item.service_id+'/service_par_listing">'+ item.service_name +'</a>');
							
						}));
					});
				},

				//define select handler
				select : function(event, ui) {
					if (ui.item) {
						console.log(ui.item);
						event.preventDefault();
						//$("#selected_tags").append('<li class="search-result" href=" + ui.item.tag_url + " target="_blank">'+ ui.item.label +'</li>');
						//$("#tagQuery").value = $("#tagQuery").defaultValue
						var defValue = $("#tagQuery").prop('defaultValue');
						$("#tagQuery").val(defValue);
						$("#tagQuery").blur();
						return false;
					}
				}
			});
		});
		
		function inputFocus(i){
			if(i.value==i.defaultValue){ i.value=""; i.style.color="#000"; }
		}
		
		function inputBlur(i){
			if(i.value==""){ i.value=i.defaultValue; i.style.color="#848484"; }
		}
	</script>
</body>
</html>