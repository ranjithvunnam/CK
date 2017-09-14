//Facebook
	window.fbAsyncInit = function() {
		FB.init({
			appId : '119347835388438',
			cookie : true,
			xfbml : true,
			version : 'v2.0',
			status : true
		});
	};

	(function(d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id)) {
			return;
		}
		js = d.createElement(s);
		js.id = id;
		js.src = "//connect.facebook.net/en_US/sdk.js";
		fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));

	function facebookLogin() {
		var FB = window.FB;
		FB.getLoginStatus(function(response) {
			statusChangeCallback(response);
		});
	}

	function statusChangeCallback(response) {
		console.log('statusChangeCallback');
		console.log(response);
		// The response object is returned with a status field that lets the
		// app know the current login status of the person.
		// Full docs on the response object can be found in the documentation
		// for FB.getLoginStatus().
		if (response.status === 'connected') {
			// Logged intconnectedo your app and Facebook.
			console.log('connected');
			FB.api('/me', {
				fields : 'first_name,last_name,email'
			}, function(response) {
				console.log(JSON.stringify(response));
				$
						.ajax({
							url : 'faceBookLogin',
							type : 'POST',
							contentType : 'application/json; charset=utf-8',
							data : JSON.stringify({
								first_name : response.first_name,
								last_name : response.last_name,
								email : response.email,
								fb_login_id : response.id,
								provider : 'FACEBOOK'
							}),
							success : function(data) {
								if (data.redirectUrl == null && data.bean != null) {
									$('input[name="first_name"]').val(
											data.bean.first_name);
									$('input[name="last_name"]').val(
											data.bean.last_name);
									$('input[name="email"]').val(data.bean.email);
									$('input[name="phone_primary"]').val(
											data.bean.phone_primary);
									$('input[name="google_id"]').val(
											data.bean.google_id);
									$('input[name="fb_login_id"]').val(
											data.bean.fb_login_id);
									$("#registration_modal").modal('show');
								}
								if (data.redirectUrl != null && data.bean == null) {
									window.location = data.redirectUrl;
								}
							},
							error : function(jqXHR, textStatus) {
								console.log('Error : ' + textStatus);
							}
						});
			});
		} else {
			console.log('Not connected');
			FB.login();
		}
	}

	//Google
	
	(function() {
	    var po = document.createElement('script');
	    po.type = 'text/javascript'; po.async = true;
	    po.src = 'https://plus.google.com/js/client:plusone.js';
	    var s = document.getElementsByTagName('script')[0];
	    s.parentNode.insertBefore(po, s);
	  })();

	var accessToken = null;
	var config = {
	    'client_id': '676581082318-gmqf9jp5njrmjp6064qe9j15f3g6j052.apps.googleusercontent.com',
	    'scope': 'https://www.googleapis.com/auth/userinfo.profile',
	}; 

	function auth() {
	 
	    gapi.auth.authorize(config, function() {
	        accessToken = gapi.auth.getToken().access_token;
	        console.log('We have got our token....');
	        console.log(accessToken);
	        console.log('We are now going to validate our token....');
	        validateToken();
	               
	    });
	}
	 
	function validateToken() {
	    $.ajax({
	        url: 'https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=' + accessToken,
	        data: null,
	        success: function(response){  
	            console.log('Our token is valid....');
	            console.log('We now want to get info about the user using our token....');
	            getUserInfo();
	        },  
	        error: function(error) {
	            console.log('Our token is not valid....');
	        },
	        dataType: "jsonp" 
	    });
	}
	 
	function getUserInfo() {
	    $.ajax({
	        url: 'https://www.googleapis.com/oauth2/v1/userinfo?access_token=' + accessToken,
	        data: null,
	        success: function(response) {
				console.log(response);
	            $.ajax({
					url : 'faceBookLogin',
					type : 'POST',
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify({
						first_name : response.given_name,
						last_name : response.family_name,
						email : response.email,
						google_id : response.id,
						provider : 'GOOGLE'
					}),
					success : function(data, textStatus, xhr) {
						if (data.redirectUrl == null && data.bean != null){
							$('input[name="first_name"]').val(data.bean.first_name);
							$('input[name="last_name"]').val(data.bean.last_name);
							$('input[name="email"]').val(data.bean.email);
							$('input[name="phone_primary"]').val(data.bean.phone_primary);
							$('input[name="google_id"]').val(data.bean.google_id);
							$('input[name="fb_login_id"]').val(data.bean.fb_login_id);
							$("#registration_modal").modal('show');
						}
						if (data.redirectUrl != null && data.bean == null) {
							window.location = data.redirectUrl;
						}
					},
					error : function(jqXHR, textStatus) {
						console.log('Error : '+textStatus);
					}
				});
	        },
	        dataType: "jsonp"
	    });
	}
	

	$('.twitterShare').on('click', function(e) {
		e.preventDefault();
		var full = location.protocol+'//'+location.hostname+(location.port ? ':'+location.port: '');
		var twitterWindow = window.open('https://twitter.com/share?url='
				+ full+$(this).data('js'), 'twitter-popup', 'height=350,width=600');
		if (twitterWindow.focus) {
			twitterWindow.focus();
		}
		//return false;
	});
	
	$('.facebookShare').on('click', function(e) {
		e.preventDefault();
		 /*var FB = window.FB;*/
		 var full = location.protocol+'//'+location.hostname+(location.port ? ':'+location.port: '');
		/* FB.ui({
				method : 'share',
				display : 'popup',
				href : 'https://developers.facebook.com/docs/',
			}, function(response) {
			});*/
		 var facebookWindow = window.open('https://www.facebook.com/dialog/share?app_id=119347835388438&display=popup&href='
					+ full+$(this).data('js'), 'twitter-popup', 'height=350,width=600');
			if (facebookWindow.focus) {
				facebookWindow.focus();
			}
			//return false;
	});
	
	$('.googleShare').on('click', function(e) {
		e.preventDefault();
		var full = location.protocol+'//'+location.hostname+(location.port ? ':'+location.port: '');
		var googleWindow = window.open('https://plus.google.com/share?url='+ full+$(this).data('js'), 'google-popup', 'height=600,width=350');
		if (googleWindow.focus) {
			googleWindow.focus();
		}
		//return false;
	});
	
	$('.copytoclipboard').on('click', function(e) {
		e.preventDefault();
		var full = location.protocol+'//'+location.hostname+(location.port ? ':'+location.port: '');
		var result = copyToClipboard(full+$(this).data('js'));
		if(result){
			alert('Content copied to clipboard.');
		}
	    console.log("copied?", result);
	});
	
	function copyToClipboard(text) {
	    if (window.clipboardData && window.clipboardData.setData) {
	        // IE specific code path to prevent textarea being shown while dialog is visible.
	        return clipboardData.setData("Text", text); 

	    } else if (document.queryCommandSupported && document.queryCommandSupported("copy")) {
	        var textarea = document.createElement("textarea");
	        textarea.textContent = text;
	        textarea.style.position = "fixed";  // Prevent scrolling to bottom of page in MS Edge.
	        document.body.appendChild(textarea);
	        textarea.select();
	        try {
	            return document.execCommand("copy");  // Security exception may be thrown by some browsers.
	        } catch (ex) {
	            console.warn("Copy to clipboard failed.", ex);
	            return false;
	        } finally {
	            document.body.removeChild(textarea);
	        }
	    }
	}
	
	$('.emailshare').on('click', function(e) {
		e.preventDefault();
		var full = location.protocol+'//'+location.hostname+(location.port ? ':'+location.port: '');
		sendMail(full+$(this).data('js'));
	});
	
	function sendMail(body) {
	    var link = "mailto:me@example.com"
	             + "?cc=myCCaddress@example.com"
	             + "&subject=" + escape("This is my subject")
	             + "&body=" + escape(body);
	    window.location.href = link;
	}
	
	$('.watsappshare').on('click', function(e) {
		e.preventDefault();
		var full = location.protocol+'//'+location.hostname+(location.port ? ':'+location.port: '');
		if (isMobile.any()) {
			var message = encodeURIComponent(full+$(this).data('js'));
			var whatsapp_url = "whatsapp://send?text=" + message;
			window.location.href = whatsapp_url;
		} else {
			alert("Please share this article in mobile device");
		}
	});
	

	var isMobile = {
		Android : function() {
			return navigator.userAgent.match(/Android/i);
		},
		BlackBerry : function() {
			return navigator.userAgent.match(/BlackBerry/i);
		},
		iOS : function() {
			return navigator.userAgent.match(/iPhone|iPad|iPod/i);
		},
		Opera : function() {
			return navigator.userAgent.match(/Opera Mini/i);
		},
		Windows : function() {
			return navigator.userAgent.match(/IEMobile/i);
		},
		any : function() {
			return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS()
					|| isMobile.Opera() || isMobile.Windows());
		}
	};