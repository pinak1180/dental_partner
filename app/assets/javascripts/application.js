// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require core/jquery-1.11.1.min
//= require core/bootstrap
//= require core/jquery.slimscroll.min
//= require core/jquery.easing.min
//= require core/jquery.appear
//= require core/jquery.placeholder
//= require core/fastclick.js
//= require pages/moment.js
//= require pages/jquery-ui.custom.min.js
//  require pages/fullcalendar.js
//  require pages/calendar.js
//= require core/main.js
//= require core/offscreen.js
//= require core/formance.js
//= require pages/groups.js
//= require core/jquery.tagsinput
//= require core/file_upload_changer
//= require chosen-jquery
//=  require ckeditor/init
//=  require ckeditor/config
//= require core/jquery.simple-dtpicker
//= require_self

$(document).ready(function() {
	$(".fadein" ).fadeOut(8000);

	// chosen select
  $('.chosen-select').chosen({
    allow_single_deselect: true,
    no_results_text: 'No results matched',
    width: '522px'
  });

	// datetimepicker
  $('.datepicker').appendDtpicker({
    'dateFormat' : 'DD/MM/YYYY',
		"dateOnly": true,
    "autodateOnStart": false
  });

	// tags input
	$('.thetags').tagsInput({
    width: 'auto',
		interactive: true,
    defaultText: "Tags"
  });
});
