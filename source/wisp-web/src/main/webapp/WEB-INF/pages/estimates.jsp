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
<link href="resources/css/custom.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<%@ include file="templetes/header.jsp"%>
		<div class="container">
			<div class="container" style="min-height: 400px;">
				<div class="col-md-6 col-md-offset-3 text-center">
					<br>
					<h4>Celebrate Karo Site</h4>
					<h2>
						<i class="fa fa-exclamation-triangle" style="color: red"></i> 
						Page Under Construction.
					</h2>
					<p>
						Well, this is embarrassing. <br>
					</p>
	
					<p>
						<a href="home">Click here</a> to visit our home page
					</p>
	
					<p>
						<a href="home">celebratekaro</a>
					</p>
				</div>
			</div>
		</div>
	<%@ include file="templetes/footer.jsp"%>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/js/custom.js" type="text/javascript"></script>
	<script type="text/javascript">
		function inputFocus(i){
			if(i.value==i.defaultValue){ i.value=""; i.style.color="#000"; }
		}
		function inputBlur(i){
			if(i.value==""){ i.value=i.defaultValue; i.style.color="#848484"; }
		}
	</script>
	<script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#servicesx,#estimatesx,#favoritesx,#estimatesx,#offersx").removeClass('active');
			$("#estimatesx").addClass('active');
		});
		
	</script>
</body>
</html>