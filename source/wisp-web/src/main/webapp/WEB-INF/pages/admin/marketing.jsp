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
<style>
	#img-upload{
    width: 100%;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/pages/admin/templetes/header.jsp"%>
		<div class="container">
			<div class="row">
				<div class="">
					<h5 class="service-heading">
						Arrange home page slider images
					</h5>
				</div>
				<div class="col-md-12 service-box-right">
						<div class="top-share-icon">
							<a href="#" data-toggle="modal" data-target="#image_upload_modal">
								<span class="share"><img src="resources/images/icons/share.png" alt="">Upload Image</span>
							</a>
						</div>
					</div>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<div class="table-responsive">
						<form:form method="POST" action="admin/updateMainSliderData" modelAttribute="mainSliderResponseBean">
						<table class="table table-bordered table-hover">
							<thead>
								<tr>
									<th>#</th>
									<th>Name</th>
									<th>Description</th>
									<th>Order</th>
									<th>Status</th>
									<th>Actions</th>
								</tr>
							</thead>
							<c:choose>
								<c:when test="${empty mainSliderResponseBean.mainSlider}">
									<tfoot>
										<tr>
											<td colspan="6" class="text-center"> <h5>No data available.</h5></td>
										</tr>
									</tfoot>
								</c:when>
								<c:otherwise>
									<tbody>
										<c:forEach items="${mainSliderResponseBean.mainSlider}" var="mainSlider" varStatus="status">
							    			<tr>
												<td>${status.count}</td>
												<form:input type="hidden" path="mainSlider[${status.index}].id"/>
												<form:input type="hidden" path="mainSlider[${status.index}].slider_url"/>
												<form:input type="hidden" path="mainSlider[${status.index}].slider_name"/>
												<form:input type="hidden" path="mainSlider[${status.index}].slider_description"/>
												<td>${mainSlider.slider_name}</td>
												<td>${mainSlider.slider_description}</td>
												<td><div class="col-md-3">
														<form:input path="mainSlider[${status.index}].slider_order" name="mainSlider[${status.index}].slider_order" class="form-control" type="number" value="${mainSlider.slider_order}"/>
													</div>
												</td>
												<form:input type="hidden" path="mainSlider[${status.index}].slider_status"/>
												<td><input id="_status_checkbox" type="checkbox" value="Enabled" ${mainSlider.slider_status == '1' ? 'checked="checked"' : ''} onchange="updateMainSlider(event,${mainSlider.id})"/></td>
												<td><a href="javascript:function() { return false; }"  id="deleteBanner" 
												onclick="deleteBannerImage(event, '${mainSlider.id}', '${mainSlider.slider_url}')"><i class="fa fa-trash-o" aria-hidden="true"></i></a></td>
											</tr>
							    		</c:forEach>
						    		</tbody>
								</c:otherwise>
							</c:choose>
						</table>
						<div class="col-md-offset-3 col-md-9 text-right">
							<input id="btn-signup" class="btn custom-button" type="submit" value="Update Slider">
						</div>
						</form:form>
					</div>
				</div>
			</div>
			<!-- Venue -->
			<div class="row">
				<div class="">
					<h5 class="service-heading">
						Arrange venues
					</h5>
				</div>
				<div class="col-xs-12">
					<div class="table-responsive">
						<table class="table table-bordered table-hover">
							<thead>
								<tr>
									<th>#</th>
									<th>Name</th>
									<th>Order</th>
									<th>Status</th>
									<th>Actions</th>
								</tr>
							</thead>
							<c:choose>
								<c:when test="${empty service_venue_list}">
									<tfoot>
										<tr>
											<td colspan="5" class="text-center"> <h5>No data available.</h5></td>
										</tr>
									</tfoot>
								</c:when>
								<c:otherwise>
									<tbody>
										<c:forEach items="${service_venue_list}" var="venue" varStatus="status">
							    			<tr>
												<td>${status.count}</td>
												<td>${venue.service_name}</td>
												<td><div class="col-md-3">
														<input id="_venue_display_order${venue.service_id}" class="form-control" type="number" value="${venue.service_display_order}"/>
													</div>
												</td>
												<td><input id="_venue_display_status${venue.service_id}" type="checkbox" ${venue.service_display_status == true ? 'checked="checked"' : ''}/></td>
												<td class="text-center"><a class="btn custom-button" onclick="upDateServiceStatus(event, ${venue.service_id})">Update</a></td>
											</tr>
							    		</c:forEach>
						    		</tbody>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
				</div>
			</div>
			<!-- Cateres -->
			<div class="row">
				<div class="">
					<h5 class="service-heading">
						Arrange Cateres
					</h5>
				</div>
				<div class="col-xs-12">
					<div class="table-responsive">
						<table class="table table-bordered table-hover">
							<thead>
								<tr>
									<th>#</th>
									<th>Name</th>
									<th>Order</th>
									<th>Status</th>
									<th>Actions</th>
								</tr>
							</thead>
							<c:choose>
								<c:when test="${empty service_cateres_list}">
									<tfoot>
										<tr>
											<td colspan="5" class="text-center"> <h5>No data available.</h5></td>
										</tr>
									</tfoot>
								</c:when>
								<c:otherwise>
									<tbody>
										<c:forEach items="${service_cateres_list}" var="cateres" varStatus="status">
							    			<tr>
												<td>${status.count}</td>
												<td>${cateres.service_name}</td>
												<td><div class="col-md-3">
														<input id="_cateres_display_order${cateres.service_id}" class="form-control" type="number" value="${cateres.service_display_order}"/>
													</div>
												</td>
												<td><input id="_cateres_display_status${cateres.service_id}" type="checkbox" ${cateres.service_display_status == true ? 'checked="checked"' : ''}/></td>
												<td class="text-center"><a class="btn custom-button" onclick="upDateCatererServiceStatus(event, ${cateres.service_id})">Update</a></td>
											</tr>
							    		</c:forEach>
						    		</tbody>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
				</div>
			</div>
			<!-- Photography -->
			<div class="row">
				<div class="">
					<h5 class="service-heading">
						Arrange Photography Service
					</h5>
				</div>
				<div class="col-xs-12">
					<div class="table-responsive">
						<table class="table table-bordered table-hover">
							<thead>
								<tr>
									<th>#</th>
									<th>Name</th>
									<th>Order</th>
									<th>Status</th>
									<th>Actions</th>
								</tr>
							</thead>
							<c:choose>
								<c:when test="${empty service_photo_list}">
									<tfoot>
										<tr>
											<td colspan="5" class="text-center"> <h5>No data available.</h5></td>
										</tr>
									</tfoot>
								</c:when>
								<c:otherwise>
									<tbody>
										<c:forEach items="${service_photo_list}" var="photo" varStatus="status">
							    			<tr>
												<td>${status.count}</td>
												<td>${photo.service_name}</td>
												<td><div class="col-md-3">
														<input id="_photo_display_order${photo.service_id}" class="form-control" type="number" value="${photo.service_display_order}"/>
													</div>
												</td>
												<td><input id="_photo_display_status${photo.service_id}" type="checkbox" ${photo.service_display_status == true ? 'checked="checked"' : ''}/></td>
												<td class="text-center"><a class="btn custom-button" onclick="upDatePhotoServiceStatus(event, ${photo.service_id})">Update</a></td>
											</tr>
							    		</c:forEach>
						    		</tbody>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
				</div>
			</div>
		</div>
	<%@ include file="/WEB-INF/pages/templetes/footer.jsp"%>
	<div class="modal fade" id="image_upload_modal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
					<h4 class="modal-title">Upload Images</h4>
				</div>
				<form id="form2">
					<div class="modal-body">
						<div class="row row-list">
							<div class="col-xs-6">
								<img id='img-upload'/>
							</div>
								<div class="col-xs-6 container-img">
									<div class="input-group">
										<label class="input-group-btn">
											<span class="btn btn-primary">
												Browse&hellip; <input type="file" name="file" id="file" style="display: none;">
											</span>
										</label>
										<input type="text" id="file_name" class="form-control" readonly>
									</div>
								</div>
						</div>
						<div class="help-block"></div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
							<button type="button" class="btn btn-primary" id="btnUpload">Upload</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/slick/slick.js" type="text/javascript" charset="utf-8"></script>
	<script src="resources/js/custom.js" type="text/javascript"></script>
	<script type="text/javascript" src="resources/js/star-rating.js"></script>
	<script type="text/javascript" src="resources/js/custom-jssor.js"></script>
	<script type="text/javascript" src="resources/js/jssor.slider.js"></script>
	<script type="text/javascript" src="resources/js/jssor.js"></script>
	<script type="text/javascript">
		$(function() {
		  // We can attach the `fileselect` event to all file inputs on the page
		  $(document).on('change', ':file', function() {
		    var input = $(this),
		        numFiles = input.get(0).files ? input.get(0).files.length : 1,
		        label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
		    input.trigger('fileselect', [numFiles, label]);
		  });

		  // We can watch for our custom `fileselect` event like this
		  $(document).ready( function() {
		      $(':file').on('fileselect', function(event, numFiles, label) {
		          var input = $(this).parents('.input-group').find(':text'),
		              log = numFiles > 1 ? numFiles + ' files selected' : label;

		          if( input.length ) {
		              input.val(log);
		          } else {
		              if( log ) alert(log);
		          }

		      });
			  function readURL(input) {
				    if (input.files && input.files[0]) {
				        var reader = new FileReader();
				        
				        reader.onload = function (e) {
				            $('#img-upload').attr('src', e.target.result);
				        };
				        
				        reader.readAsDataURL(input.files[0]);
				    }
				}

				$("#file").change(function(){
				    readURL(this);
				});
		  });
		  
		});
		
		$('#image_upload_modal').on('hidden.bs.modal', function () {
		  $('#img-upload').attr('src',null);
		  $("#file").replaceWith($('[name="file"]').val('').clone(true));
		  $("#file_name").val(null);
		});
		
		var isJpg = function(name) {
		    return name.match(/jpg$/i);
		};
		    
		var isPng = function(name) {
		    return name.match(/png$/i);
		};
		
		//using jquery.form.js
		$('#btnUpload').on('click', function() {
		   var file = $('[name="file"]');
		   var filename = $.trim(file.val());
		   var oMyForm = new FormData();
           oMyForm.append("file", $('input[type=file]')[0].files[0]);
		   if (!(isJpg(filename) || isPng(filename))) {
	            alert('Please browse a JPG/PNG file to upload ...');
	            return;
	        }
		   if (file.size > 5242880){
               alert("File size must under 5mb!");
               return;
           }
		   $.ajax({
	            url: 'admin/uploadImage',
	            type: "POST",
	            contentType : 'application/json; charset=utf-8',
	            data: oMyForm,
	            enctype: 'multipart/form-data',
	            processData: false,
	            contentType: false
	          }).done(function(data) {
	              console.log(data);
	              $('#image_upload_modal').modal('hide');
	              window.location.href = 'admin/marketing';
	          }).fail(function(jqXHR, textStatus) {
	              //alert(jqXHR.responseText);
	              alert('File upload failed ...');
	         });
		});
		
		function updateMainSlider(event, id) {
			console.log(event);
			var oMyForm = new FormData();
		     oMyForm.append("id", id);
			$.ajax({
				url : 'admin/update_banner_status',
				type : 'POST',
				contentType : 'application/json; charset=utf-8',
				data : oMyForm,
				processData: false,
	            contentType: false
			}).done(function(data) {
				  alert("Status updated successfully.");
	              window.location.href = 'admin/marketing';
	          }).fail(function(jqXHR, textStatus) {
	              //alert(jqXHR.responseText);
	        	  alert(textStatus);
	         });
		}
		
		function deleteBannerImage(event, id, filePath) {
			var conBox = confirm("Are you sure ?");
			if (conBox) {
				var oMyForm = new FormData();
		           oMyForm.append("id", id);
		           oMyForm.append("filePath", filePath);
				$.ajax({
					url : 'admin/removeBannerImage',
					type : 'POST',
					contentType : 'application/json; charset=utf-8',
					data : oMyForm,
					processData: false,
		            contentType: false,
					success : function(msg) {
						alert("Image deleted successfully.");
						window.location = 'admin/marketing';
					},
					error : function(jqXHR, textStatus) {
						alert(textStatus);
					}
				});
			} else {
				event.preventDefault();
			};
		};
		
		function upDateServiceStatus(event, id) {
			var order = $("#_venue_display_order"+id).val();
			var status = $("#_venue_display_status"+id).is(':checked');
			var oMyForm = new FormData();
	           oMyForm.append("service_id", id);
	           oMyForm.append("display_order", order);
	           oMyForm.append("display_status", status);
			$.ajax({
				url : 'admin/update_service_status',
				type : 'POST',
				contentType : 'application/json; charset=utf-8',
				data : oMyForm,
				processData: false,
	            contentType: false,
				success : function(msg) {
					alert("Data updated successfully.");
					window.location = 'admin/marketing';
				},
				error : function(jqXHR, textStatus) {
					alert(textStatus);
				}
			});
		};
		
		function upDateCatererServiceStatus(event, id) {
			var order = $("#_cateres_display_order"+id).val();
			var status = $("#_cateres_display_status"+id).is(':checked');
			var oMyForm = new FormData();
	           oMyForm.append("service_id", id);
	           oMyForm.append("display_order", order);
	           oMyForm.append("display_status", status);
	           $.ajax({
					url : 'admin/update_service_status',
					type : 'POST',
					contentType : 'application/json; charset=utf-8',
					data : oMyForm,
					processData: false,
		            contentType: false,
					success : function(msg) {
						alert("Data updated successfully.");
						window.location = 'admin/marketing';
					},
					error : function(jqXHR, textStatus) {
						alert(textStatus);
					}
				});
		};
		
		function upDatePhotoServiceStatus(event, id) {
			var order = $("#_photo_display_order"+id).val();
			var status = $("#_photo_display_status"+id).is(':checked');
			var oMyForm = new FormData();
	           oMyForm.append("service_id", id);
	           oMyForm.append("display_order", order);
	           oMyForm.append("display_status", status);
	           $.ajax({
					url : 'admin/update_service_status',
					type : 'POST',
					contentType : 'application/json; charset=utf-8',
					data : oMyForm,
					processData: false,
		            contentType: false,
					success : function(msg) {
						alert("Data updated successfully.");
						window.location = 'admin/marketing';
					},
					error : function(jqXHR, textStatus) {
						alert(textStatus);
					}
				});
		};
		
	</script>
</body>