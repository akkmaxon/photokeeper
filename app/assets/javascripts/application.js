// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

$(window).load(function() {
  $('.masonry').masonry({
    itemSelector: '.thumbnail',
    columnWidth: 240,
    gutter: 24,
    isFitWidth: true
  });
  var hideAlert = function () {
    $('.alert').fadeOut(1000);
  }
  setTimeout(hideAlert, 2000);
});
var featherEditor = new Aviary.Feather({
    apiKey: '1234567',
    onSave: function(imageID, newURL) {
	var img = document.getElementById(imageID);
	img.src = newURL;
	if(imageID == "editableimage") {
	  var newSource = document.getElementById('photo_remote_source_url');
	  newSource.value = newURL;
	} else {
	  var newAvatar = document.getElementById('user_remote_avatar_url');
	  newAvatar.value = newURL;
	}
    },
    onError: function(errorObj) {
      alert(errorObj.message);
    }
});

function launchEditor(id, src) {
    featherEditor.launch({
	image: id,
	url: src
    });
    return false;
}

var cleanPassword = function() {
  var password = $('#user_password').val();
  var password_confirmation = $('#user_password_confirmation').val();
  if(password != password_confirmation) {
    $('#user_password').val('');
  }
};
