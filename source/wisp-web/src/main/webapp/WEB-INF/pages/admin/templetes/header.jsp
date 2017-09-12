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
				<a class="navbar-brand" href="admin/dashboard"><img src="resources/images/logo.svg" alt="logo"></a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					 <c:choose>
					    <c:when test="${loggedIn}">
					        <li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown" role="button" aria-haspopup="true"
								aria-expanded="true"><i class="fa fa-user" aria-hidden="true"></i>
									${first_name} <span class="caret"></span></a>
								<ul class="dropdown-menu">
									<li><a href="changepass">Change Password</a></li>
									<li><a href="admin/marketing">Marketing</a></li>
									<li><a href="admin/analytics">Analytics</a></li>
									<li><a href="admin/j_spring_security_logout">Logout</a></li>
								</ul>
							</li>
					    </c:when>
					    <c:otherwise>
					    </c:otherwise>
					</c:choose>
					</li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>