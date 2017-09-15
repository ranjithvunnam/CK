<security:authorize var="loggedIn" access="isAuthenticated()">
	<security:authentication var="email" property="principal.username" />
	<security:authentication var="first_name" property="principal.firstname" />
</security:authorize>
<nav class="navbar navbar-default" id="custom-navbar">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="home"><img src="resources/images/logo.svg" alt="logo"></a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav center-menu">
					<li id="homex"><a href="home">Home <span class="sr-only">(current)</span></a></li>
					<li class="dropdown" id="servicesx"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Services <span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li id="venuex"><a href="Venue/service_listing">Venues</a></li>
							<li id="catererx"><a href="Caterers/service_listing">Caterers</a></li>
							<li id="photox"><a href="Photography/service_listing">Photographers</a></li>
							<li id="evtplanx"><a href="EventPlanners/service_listing">Event Planners</a></li>
							<li id="evtplanx"><a href="EventDesigners/service_listing">Event Designers</a></li>
							<li id="evtplanx"><a href="Florists/service_listing">Florists</a></li>
							<li id="evtplanx"><a href="Pandits/service_listing">Pandits</a></li>
							<li id="evtplanx"><a href="Baaraat/service_listing">Baaraat</a></li>
							<li id="evtplanx"><a href="D.J/service_listing">D.J</a></li>
							<li id="evtplanx"><a href="Entertainers/service_listing">Entertainers</a></li>
							<li id="evtplanx"><a href="CardDesigners/service_listing">Card Designers</a></li>
							<li id="evtplanx"><a href="MakeupArtists/service_listing">Makeup Artists</a></li>
							<li id="evtplanx"><a href="MehendiArtists/service_listing">Mehendi Artists</a></li>
							<li id="evtplanx"><a href="Musicians/service_listing">Musicians</a></li>
							<li id="evtplanx"><a href="Choreographer/service_listing">Choreographer</a></li>
							<li id="evtplanx"><a href="TravelAgency/service_listing">Travel Agency</a></li>
						</ul>
					</li>
					<li id="favoritesx"><a href="favorites">Favorites</a></li>
					<li id="estimatesx"><a href="estimates">Estimate</a></li>
					<li id="offersx"><a href="offers">Offers</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false"><i class="fa fa-map-marker"
							aria-hidden="true"></i>
							<c:out default="None" escapeXml="true" value="${not empty location?location:'Location'}"/>
							<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<c:forEach items = "${city_list}" var="city" varStatus="city_var">
								<li><a href="updateLocation?location=${city}">${city}</a></li>
								<li><a href="resetLocation">Reset Location</a></li>
							</c:forEach>
						</ul>
					</li>
					<c:choose>
					    <c:when test="${loggedIn}">
					        <li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown" role="button" aria-haspopup="true"
								aria-expanded="true"><i class="fa fa-user" aria-hidden="true"></i>
									${first_name} <span class="caret"></span></a>
								<ul class="dropdown-menu">
									<li><a href="changepass">Change Password</a></li>
									<li><a href="j_spring_security_logout">Logout</a></li>
								</ul>
							</li>
					    </c:when>
					    <c:otherwise>
					        <li><a href="login"><span class="btn btn-info signin">Sign In</span></a></li>
					    </c:otherwise>
					</c:choose>
					<li><a href="vendor/home"><span class="btn btn-info vendor">Vendor</span></a>
					</li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>