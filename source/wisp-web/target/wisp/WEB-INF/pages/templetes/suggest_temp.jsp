<div class="row">
	<div class="col-md-12">
		<h5 class="service-heading">You may also need below</h5>
	</div>
</div>
<div class="row">
	<div class="col-md-12 col-xs-12">
		<div class="col-md-12 small-slider mTop10">
			<section class="service-small-slider slider">
				<c:if test="${service_details.service_type ne 'SER_VENUE'}">
					<div class="icon">
						<a href="venue/service_listing.do"> <img
							src="resources/images/icons/venues.png" alt="">
							<p>Venues</p>
						</a>
					</div>
				</c:if>
				<c:if test="${service_details.service_type ne 'SER_CATERERS'}">
					<div class="icon">
						<a href="caterers/service_listing.do"><img
							src="resources/images/icons/catering.png" alt="">
							<p>Caterers</p> </a>
					</div>
				</c:if>
				<c:if test="${service_details.service_type ne 'SER_PHOTOGRAPHY'}">
					<div class="icon">
						<a href="photography/service_listing.do"> <img
							src="resources/images/icons/photographers.png" alt="">
							<p>Photographers</p>
						</a>
					</div>
				</c:if>
				<c:if test="${service_details.service_type ne 'SER_EVENT_PLANNERS'}">
					<div class="icon">
						<a href="event_planners/service_listing.do"> <img
							src="resources/images/icons/event-planer.png" alt="">
							<p>Event Planners</p>
						</a>
					</div>
				</c:if>
				<c:if
					test="${service_details.service_type ne 'SER_EVENT_DESIGNERS'}">
					<div class="icon">
						<a href="event_designers/service_listing.do"> <img
							src="resources/images/icons/event-desinger.png" alt="">
							<p>Event Designers</p>
						</a>
					</div>
				</c:if>
				<c:if test="${service_details.service_type ne 'SER_FLORIST'}">
					<div class="icon">
						<a href="florists/service_listing.do"> <img
							src="resources/images/icons/florists.png" alt="">
							<p>Florists</p>
						</a>
					</div>
				</c:if>
				<c:if test="${service_details.service_type ne 'SER_PANDITS'}">
					<div class="icon">
						<a href="pandits/service_listing.do"> <img
							src="resources/images/icons/pandits.png" alt="">
							<p>Pandits</p>
						</a>
					</div>
				</c:if>
				<c:if test="${service_details.service_type ne 'SER_BAARAAT'}">
					<div class="icon">
						<a href="baaraat/service_listing.do"> <img
							src="resources/images/icons/baarat.png" alt="">
							<p>Baaraat</p>
						</a>
					</div>
				</c:if>
				<c:if test="${service_details.service_type ne 'SER_DJ'}">
					<div class="icon">
						<a href="dj/service_listing.do"> <img
							src="resources/images/icons/dj.png" alt="">
							<p>D.J</p>
						</a>
					</div>
				</c:if>
				<c:if test="${service_details.service_type ne 'SER_ENTERTAINERS'}">
					<div class="icon">
						<a href="entertainers/service_listing.do"> <img
							src="resources/images/icons/entertainers.png" alt="">
							<p>Entertainers</p>
						</a>
					</div>
				</c:if>
				<c:if test="${service_details.service_type ne 'SER_CARDS'}">
					<div class="icon">
						<a href="cards/service_listing.do"> <img
							src="resources/images/icons/cards.png" alt="">
							<p>Card Designers</p>
						</a>
					</div>
				</c:if>
				<c:if test="${service_details.service_type ne 'SER_BEAUTICIANS'}">
					<div class="icon">
						<a href="beauticians/service_listing.do"> <img
							src="resources/images/icons/beauticians.png" alt="">
							<p>Makeup Artists</p>
						</a>
					</div>
				</c:if>
				<c:if test="${service_details.service_type ne 'SER_MEHANDI'}">
					<div class="icon">
						<a href="mehandi/service_listing.do"> <img
							src="resources/images/icons/mehandi.png" alt="">
							<p>Mehendi Artists</p>
						</a>
					</div>
				</c:if>
				<c:if test="${service_details.service_type ne 'SER_MUSICIANS'}">
					<div class="icon">
						<a href="musicians/service_listing.do"> <img
							src="resources/images/icons/musicians.png" alt="">
							<p>Musicians</p>
						</a>
					</div>
				</c:if>
				<c:if test="${service_details.service_type ne 'SER_CHOREOGRAPHERS'}">
					<div class="icon">
						<a href="choreographers/service_listing.do"> <img
							src="resources/images/icons/choreographers.png" alt="">
							<p>Choreographer</p>
						</a>
					</div>
				</c:if>
				<c:if test="${service_details.service_type ne 'SER_TRAVEL'}">
					<div class="icon">
						<a href="travel/service_listing.do"> <img
							src="resources/images/icons/travel.png" alt="">
							<p>Travel Agency</p>
						</a>
					</div>
				</c:if>
			</section>
		</div>
	</div>
</div>