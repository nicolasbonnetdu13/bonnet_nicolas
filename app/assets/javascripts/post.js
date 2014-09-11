// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

function showHideComment(element) {
    element.toggle('fast'); 
}

var oldValue;

function postTypeChange(input) {
			
	hideEveryType(true);
	  
	var shouldDelay = (oldValue == "image" ||
					   oldValue == "video" ||
					   oldValue == "gallery" );
	
	setTimeout(function () {
		// and call `resolve` on the deferred object, once you're done
		if (input.value == "image") {
			$('#post_image').show('fast');
		}
		if (input.value == "video") {
			$('#post_video').show('fast');
		}
		if (input.value == "gallery") {
			$('#post_gallery').show('fast');
	    }
	}, shouldDelay ? 300 : 0);
	oldValue = input.value;
}

function hideEveryType(animated) 
{
	if (animated) {
		$('#post_image').hide('fast');
		$('#post_gallery').hide('fast');
		$('#post_video').hide('fast');
	} else {
		$('#post_image').hide();
		$('#post_gallery').hide();
		$('#post_video').hide();
	}
}

function displayImageContainer(input) {
	
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#image_display')
                .attr('src', e.target.result);
        };

        reader.readAsDataURL(input.files[0]);
    }
	$('#image_container').show('fast');
}
