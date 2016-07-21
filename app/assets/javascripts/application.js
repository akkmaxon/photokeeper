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
	var newSource = document.getElementById('new_source');
	img.src = newURL;
	newSource.value = newURL;
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
