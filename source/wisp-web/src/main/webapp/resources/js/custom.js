    $(document).on('ready', function() {
    	// share icons
        $(".top-share-icon .share").on("click", function(){
            $(".social-networks").slideToggle( "fast", function() {
                // Animation complete.
              });
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

    });
    $(window).resize(function() {

        var imageHeight1 = 0;
        $(".upload-images .thumb-images img").each(function(i, e) {
            if (imageHeight1 < $(e).height()) {
                imageHeight1 = $(e).height();
            }
        });
        $(".upload-images .thumb-images").css({ 'height': imageHeight1 + "px" });
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
		    html += '<img src="http://images.clipartpanda.com/user-clipart-dagobert83_female_user_icon.png" class="img-circle avatar" alt="user profile image">';
		    html += '</div>';
		    //Image end
		    //pull left meta
		    html += '<div class="pull-left meta">';
		    
		    //title
		    html += '<div class="title h5">';
		    html += '<a href="#"><b>'+val.first_name+'</b></a> made a post.';
		  	html += '<div class="rating-readonly">';
		  	html += '<form><input id="" value="'+val.rating+'" type="text" class="rating" data-min=0 data-max=5 data-step=0.2 data-size="xs" title="" disabled></form>';
		  	html += '</div>';
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