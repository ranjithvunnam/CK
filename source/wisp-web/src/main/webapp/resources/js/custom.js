    $(document).on('ready', function() {

    	[].slice.call( document.querySelectorAll('select.dropdown-menu') ).forEach( function(el) {    
		    new SelectFx(el);
		} );
    	
    	$('select').each(function(i, e){
    		var id = $(e).attr('id');
    		var selectedValue = $("#"+id+" option:selected").text();
    		$(e).parent().siblings('button').find(".menuselected").html(selectedValue);
    	});
    	$(".dropdown-menu li a").click(function(){
	  		  var selText = $(this).text();
	  		  $(this).parents('.dropdown').find('.dropdown-toggle').html(selText+' <span class="caret"></span>');
	  	 });
    	
    	//Sticky footer
    	stickyFooter();
    	
    	// share icons
        $(".top-share-icon .share").on("click", function(){
			$(".social-networks").fadeOut();
            $(this).find(".social-networks").slideToggle( "fast", function() {
              });
        });
        
        $(document).on('click touchstart', function(e) {
			// console.log(e.target.className)
            if (e.target.className != 'share') {
                $(".social-networks").fadeOut();
            }
        });
        
        // get ratings
        $(".rating input").on("click", function() {
            alert("you have given - custom.js " + $(this).val()); // delete this after u get 
        });

       
     // play pause videos in gallery
        $('.gallery_video').parent().click(function () {
            if($(this).children(".gallery_video").get(0).paused){
                $(this).children(".gallery_video").get(0).play();
                $(this).children(".playpause").fadeOut();
            }else{
               $(this).children(".gallery_video").get(0).pause();
                $(this).children(".playpause").fadeIn();
            }
        });


        // setting overlay height
        var allOverlay = $(".overlay");
        var maxHeight = 0;
        $(allOverlay).each(function(i, e){
        	if(maxHeight < $(e).height()){
        		maxHeight = $(e).height();
        	}

        });
        $(".overlay").css({"height" : (maxHeight+10)+"px"});

    });
    $(window).resize(function() {

        var imageHeight1 = 0;
        $(".upload-images .thumb-images img").each(function(i, e) {
            if (imageHeight1 < $(e).height()) {
                imageHeight1 = $(e).height();
            }
        });
        $(".upload-images .thumb-images").css({ 'height': imageHeight1 + "px" });

        // setting overlay height
        var allOverlay = $(".overlay");
        var maxHeight = 0;

        $(".overlay").css({"height" : "auto"});
        $(allOverlay).each(function(i, e){
        	if(maxHeight < $(e).height()){
        		maxHeight = $(e).height();
        	}

        });
        $(".overlay").css({"height" : (maxHeight+10)+"px"});
    });
    
  //Comments
	$(".ratings .fav").on("click", function(){
		var serviceId = $(this).data('serviceid');
		$.ajax({
			url : 'rest/getAllComments?&service_id='+serviceId,
			type : 'GET',
			contentType : 'application/json; charset=utf-8',
			success : function(result, msg, xhr) {
				doModal(result);
			},
			error : function(jqXHR, textStatus) {
				if (jqXHR.status === 401) { // HTTP Status 401: Unauthorized
					window.location = 'login';
				} else {
					alert(textStatus);
				}
			}
		});
	});

	function doModal(result)
	{	var html = '';
	    $(result).each(function(i, val) {
	    	//panel
		    html += '<div class="panel panel-white post panel-shadow">';
		    
		    //post heading
		    html += '<div class="post-heading">';
		    //Image
		    html += '<div class="pull-left image">';
		    html += '<img src="resources/images/icons/commentusericon.png" class="img-circle avatar" alt="user profile image">';
		    html += '</div>';
		    //Image end
		    //pull left meta
		    html += '<div class="pull-left meta">';
		    
		    //title
		    html += '<div class="title h5">';
		    html += '<a href="#"><b>'+val.first_name+'</b></a> made a post.';
		  	html += '<span class="fav"><div class="ratings"><div class="rating-readonly">';
		  	html += '<form><div class="rating-container rating-xs rating-animate rating-disabled"><div class="clear-rating " title="Clear"><i class="glyphicon glyphicon-minus-sign"></i></div><div class="rating-stars"><span class="empty-stars"><span class="star"><i class="glyphicon glyphicon-star-empty"></i></span><span class="star"><i class="glyphicon glyphicon-star-empty"></i></span><span class="star"><i class="glyphicon glyphicon-star-empty"></i></span><span class="star"><i class="glyphicon glyphicon-star-empty"></i></span><span class="star"><i class="glyphicon glyphicon-star-empty"></i></span></span><span class="filled-stars" style="width: '+20*val.rating+'%;"><span class="star"><i class="glyphicon glyphicon-star"></i></span><span class="star"><i class="glyphicon glyphicon-star"></i></span><span class="star"><i class="glyphicon glyphicon-star"></i></span><span class="star"><i class="glyphicon glyphicon-star"></i></span><span class="star"><i class="glyphicon glyphicon-star"></i></span></span><input id="" value="'+val.rating+'" type="text" class="rating rating-input" data-min=0 data-max=5 data-step=0.2 data-size="xs" title="" disabled="disabled" captio="none"></div><div class="caption"><span class="label label-info">Three Stars</span></div></div></form>';
		  	html += '</div></div><span/>';
		    html += '</div>';
		    //end title
		    var d = new Date(val.comment_created);
		    //h6
		    html += '<h6 class="text-muted time">';
		    html += d.toLocaleString();
		    html += '</h6>';
		    //end h6
		    html += '</div>';
		    //end pull left meta
		    html += '</div>';
		    //end post heading
		    
		    //post description
		    html += '<div class="post-description">';
		    html += '<p>'+val.comment_desc+'</p>';
		    html += '</div>';
		    //end post description
		    
		    html += '</div>';
		    //end panel
		});
	    $("#mod_comm").html(html);
	    $("#comments_modal").modal();
	}
	

	$(window).resize(function() {
		stickyFooter();
		var imageHeight1 = 0;
		$(".upload-images .thumb-images img").each(function(i, e) {
			if (imageHeight1 < $(e).height()) {
				imageHeight1 = $(e).height();
			}
		});
		$(".upload-images .thumb-images").css({
			'height' : imageHeight1 + "px"
		});
	});
	
	function stickyFooter() {
		$(".footer").css({
			"position" : "relative"
		});
		var vHeight = document.body.clientHeight;
		var deviceHeight = window.innerHeight;
		console.log(vHeight, deviceHeight);
		if (vHeight < deviceHeight) {
			$(".footer").css({
				"position" : "absolute"
			});
		}
	}
	
	function goBack() {
	    window.history.back();
	}
	
	
	var ServiceType = {
			Venue : "SER_VENUE",
			Caterers : "SER_CATERERS",
			Photography : "SER_PHOTOGRAPHY",
			EventPlanners : "SER_EVENT_PLANNERS",
			EventDesigners : "SER_EVENT_DESIGNERS",
			Florists : "SER_FLORIST",
			Pandits : "SER_PANDITS",
			Baaraat : "SER_BAARAAT",
			Entertainers : "SER_ENTERTAINERS",
			CardDesigners : "SER_CARDS",
			MakeupArtists : "SER_BEAUTICIANS",
			MehendiArtists : "SER_MEHANDI",
			Musicians : "SER_MUSICIANS",
			Choreographer : "SER_CHOREOGRAPHERS",
			TravelAgency :"SER_TRAVEL"
	};

	$(document).on('click', '.dropdown-menu li', function(){		
		var service_type = $(this).data('value');
		var allOptions = $(this).siblings('select').find('option');
		// console.log(allOptions)
		$(allOptions).removeAttr("selected");
		$(allOptions).each(function(i, e){		
			// console.log($(e).val(),"==", service_type);
			if($(e).val()==service_type){
				$(this).attr("selected", "selected");
			}
		});
		
		if($(this).parent().hasClass("_servicefilter")){			
		    var url = "";	    
	        if(service_type) {
	        	url += SearchRefractive(service_type);
	    		url += '/service_listing';
	    		if (url) {
	    			window.location = url;
	    		}
	        }
		}

	});
		
	function SearchRefractive(myValue) {
		if(myValue == 'SER_DJ') {
			return 'D.J';
		}
	    for (prop in ServiceType) {
	      if (ServiceType[prop] == myValue) {
	        return prop;
	      }
	    }
	}
