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
<title>WISP</title>
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
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
	<%@ include file="/WEB-INF/pages/templetes/header.jsp"%>

	<div class="container">
		<%@ include file="steps_header.jsp"%>
		<div class="row">
			<form method="POST" action="vendor/uploadMedia.do" enctype="multipart/form-data" id="media_form">
			<div class="col-xs-12 col-md-12 upload-images">
				<div class="col-xs-12 col-md-12 vender-form mTop30">
					<div class="col-xs-12 col-md-4 big-image bottom-xs text-center">
						<h5 class="service-heading pull-left">Upload Images and
							Videos</h5>
						<img id="showSelectionImg" src="resources/images/banner2.jpg" alt="">
						<%-- <form method="POST" action="vendor/uploadMedia.do" enctype="multipart/form-data" id="media_form"> --%>
							<label for="file-upload" class="custom-file-upload mTop10">
								<i class="fa fa-cloud-upload"></i> Custom Upload
							</label> <input id="file-upload" type="file" />
						<%-- </form> --%>
					</div>
					<div class="col-xs-12 col-md-8">
						<hr class="display-xs">
						<h5 class="service-heading">Your Uploded Files</h5>
						<div class="uploaded-container">
							<!-- Data will be added dynamically -->
						</div>
					</div>

					<div class="row">
						<div class="col-md-12">
							<form action="">
								<div class="form-group">
									<!-- <label for="email" class="col-md-2 control-label">Description</label> -->

									<div class="col-xs-12 col-md-12">
										<h5 class="service-heading">Description</h5>
										<textarea name="" class="form-control"
											placeholder="Description" rows="5"></textarea>
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="col-md-12 col-sm-12 col-xs-12 service-box-right mTop10">
						<h5 class="service-heading">Amenities</h5>

						<div class="icons-div ">
							<div class="specifications">
								<img src="resources/images/icons/capacity.png" alt="">
								<p>Capacity</p>
								<select class="form-control custom-select" name="">
									<option value="">500 - 1000</option>
									<option value="">1000 - 1500</option>
									<option value="">1500-2000</option>
									<option value="">2500 +</option>
								</select>
							</div>
							<div class="specifications">
								<img src="resources/images/icons/rooms.png" alt="">
								<p>Rooms</p>
								<select class="form-control custom-select" name="">
									<option value="">10</option>
									<option value="">15</option>
									<option value="">25</option>
								</select>
							</div>
							<div class="specifications">
								<img src="resources/images/icons/price.png" alt="">
								<p>Price</p>
								<!-- <p>20000</p> -->
								<select class="form-control custom-select" name="">
									<option value="">1000</option>
									<option value="">2000</option>
									<option value="">2500</option>
								</select>
							</div>
							<div class="specifications">
								<img src="resources/images/icons/car.png" alt="">
								<p>Parking</p>
								<div class="checkbox-div">
									<label class="custom_switch"> <input type="checkbox"
										id="togBtn">
										<div class="slider round">
											<!--ADDED HTML -->
											<span class="on"><i class="fa fa-check"
												aria-hidden="true"></i></span><span class="off"></span>
											<!--END-->
										</div>
									</label>
								</div>
							</div>
							<div class="specifications">
								<img src="resources/images/icons/liquor.png" alt="">
								<p>Liquor</p>
								<div class="checkbox-div">
									<label class="custom_switch"> <input type="checkbox"
										id="togBtn">
										<div class="slider round">
											<!--ADDED HTML -->
											<span class="on"><i class="fa fa-check"
												aria-hidden="true"></i></span><span class="off"></span>
											<!--END-->
										</div>
									</label>
								</div>
							</div>
							<div class="specifications">
								<img src="resources/images/icons/ac.png" alt="">
								<p>Ac</p>
								<div class="checkbox-div">
									<label class="custom_switch"> <input type="checkbox"
										id="togBtn">
										<div class="slider round">
											<!--ADDED HTML -->
											<span class="on"><i class="fa fa-check"
												aria-hidden="true"></i></span><span class="off"></span>
											<!--END-->
										</div>
									</label>
								</div>
							</div>
							<div class="specifications">
								<img src="resources/images/icons/wifi.png" alt="">
								<p>Wifi</p>
								<div class="checkbox-div">
									<label class="custom_switch"> <input type="checkbox"
										id="togBtn">
										<div class="slider round">
											<!--ADDED HTML -->
											<span class="on"><i class="fa fa-check"
												aria-hidden="true"></i></span><span class="off"></span>
											<!--END-->
										</div>
									</label>
								</div>
							</div>
						</div>
					</div>

					<!-- Button -->
					<div
						class="col-xs-12 col-md-offset-3 col-md-9 text-right mTop10 pbot10">
						<!-- <a id="btn-signup" type="button" class="btn custom-button"><i
							class="icon-hand-right"></i>Save</a> <a href="vendor.html"
							id="btn-signup" type="button" class="btn custom-button"><i
							class="icon-hand-right"></i>Back</a> <a href="404.html"
							id="btn-signup" type="button" class="btn custom-button"><i
							class="icon-hand-right"></i>Next</a> -->
							<input id="btn-signup" class="btn custom-button" type="submit" value="Previous" name="_target0">
							<input id="btn-signup" class="btn custom-button" type="submit" value="Finish" name="_finish">
							<input id="btn-signup" class="btn custom-button" type="submit" value="Cancel" name="_cancel">
							<input id="btn-signup" class="btn custom-button" type="hidden" value="1" name="_page">
					</div>
				</div>
			</div>
			</form>
		</div>
	</div>

	<%@ include file="/WEB-INF/pages/templetes/footer.jsp"%>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/slick/slick.js" type="text/javascript"
		charset="utf-8"></script>
	<script src="resources/js/custom.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#servicesx,#estimatesx,#favoritesx,#estimatesx,#offersx").removeClass('active');
			$("#homex").addClass('active');
			var allImages = [];
			var id_img = -1;
			$('#file-upload').change(function(e){
				//$('#media_form').trigger("submit", e);
				//var currentImage = ;
				readURL(this);
		    });
			function readURL(input) {
		        if (input.files && input.files[0]) {
		            var reader = new FileReader();
		            reader.onload = function (e) {
						id_img++;						
		                $('#showSelectionImg').attr('src', e.target.result);
						
		                var createImageContainer = '<div class="thumb-images"><img id="'+id_img+'" src="'+e.target.result+'" alt="">'+
		                '<div class="thumb-close"><i class="fa fa-times" aria-hidden="true"></i></div></div>';
		                $(".uploaded-container").append(createImageContainer);
						
		            };
					allImages.push({val: input.files[0], name: id_img+1});
		            reader.readAsDataURL(input.files[0]);
					console.log(allImages);
		        }
			}
           $('#media_form').submit(function( event ){
        	   //event.preventDefault();
        	   console.log("2st", event);
        	   alert("form sub called");
        	   var files = event.target.files;
        	   var oMyForm = new FormData();
               oMyForm.append("file", files[0]);
               $.ajax({
					url : 'vendor/uploadMedia.do',
					type : 'POST',
					contentType : 'application/json; charset=utf-8',
					data : oMyForm,
					enctype: 'multipart/form-data',
					processData: false, 
                    contentType:false,
					success : function(msg) {
						alert("FeedBack submitted.."+msg);
					},
					error : function(jqXHR, textStatus) {
						alert(textStatus);
					}
				});
           });
		   
		    // upload-images
				$(".uploaded-container").on("click", ".thumb-images", function() {
				  $('.upload-images .thumb-close').hide();
					$(this).children('.thumb-close').show();
				});
				$(".uploaded-container").on("click", ".thumb-images img", function() {
					var selectedImage = $(this).attr('src');
					$(".upload-images #showSelectionImg").attr("src", selectedImage);

				});
				$(".uploaded-container").on("click", ".thumb-close", function() {
					var index = $(this).siblings().attr("id");
					console.log('ss', $(this).siblings().attr("id"), allImages);
					$(this).parents(".thumb-images").remove();
					var deleteThis;
					$(allImages).each(function(i, e){
						console.log(allImages[i], index);
						if(allImages[i] == index){	
						deleteThis = i;
						}
					});
					allImages.splice(deleteThis, 1);
					console.log("afterDelete", allImages);
				});

				// get smallest image height
				var imageHeight = 0;
				$(".upload-images .thumb-images").each(function(i, e) {
					if (imageHeight < $(e).height()) {
						imageHeight = $(e).height();
					}
					console.log(imageHeight);
				});
				$(".upload-images .thumb-images").css({ 'height': imageHeight + "px" });
				

		});
	</script>
</body>
</html>