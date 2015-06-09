$(document).ready(function() {
	swap_authentication('signin','signup');
	set_slug();
  set_email_domain();
	initialize();
  $("#set_userids").click(function() {
      var checkBoxes = $(".select-all");
      checkBoxes.prop("checked", !checkBoxes.prop("checked"));
      $("#set_userids").text() == "Select All" ? $("#set_userids").text("UnCheck All") : $("#set_userids").text("Select All");
  });
});

// sets the slug on the key change of group name
function set_slug(){
  $('#group_name').on("keyup",function() {
    name = $('#group_name').val();
		email = name.replace(/([^a-z0-9]+)/gi, '_').toLowerCase();
		$('#group_group_email').val(email + "@spaces.com");
  });
}

//swaps signin or login on landing
function swap_authentication(to_show, to_hide){
	$('.'+to_hide).hide();
	$('.'+to_show).show();
}

function set_email_domain(){
  $('#grp_email').on("change",function() {
    name = $('#grp_email').val();
    name = name.split('@')[0]
    $('#grp_email').val(name + "@spaces.com");
  });
}

var placeSearch, autocomplete;
var componentForm = {
  administrative_area_level_1: 'long_name',
  country: 'long_name',
  postal_code: 'short_name'
};

function initialize() {
  if($('#autocomplete').length != 0){
    autocomplete = new google.maps.places.Autocomplete(
    	(document.getElementById('autocomplete')),
      { types: ['geocode'] });
      google.maps.event.addListener(autocomplete, 'place_changed', function() {
      fillInAddress();
    });
  }
}

function fillInAddress() {
  var place = autocomplete.getPlace();
  console.log(place.geometry.location.lat())
  for (var component in componentForm) {
    $('#'+component).val = '';
    $('#'+component).disabled = false;
  }
  $('#lat').val = ''
  $('#lng').val = ''
  $('#lat').disabled = false
  $('#lng').disabled = false

  for (var i = 0; i < place.address_components.length; i++) {
    var addressType = place.address_components[i].types[0];
    if (componentForm[addressType]) {
      var val = place.address_components[i][componentForm[addressType]];
      $('#' + addressType).val(val);
    }
  }
  $('#lat').val(place.geometry.location.lat()); 
  $('#lng').val(place.geometry.location.lng());
}

