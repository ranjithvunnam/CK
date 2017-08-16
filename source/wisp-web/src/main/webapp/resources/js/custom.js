    $(document).on('ready', function() {
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
