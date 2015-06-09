function change_file_input(){
	var preview = $('#preview');
	$('input[type="file"]').change(function(event){
		var input = $(event.currentTarget);
		var file = input[0].files[0];
		var reader = new FileReader();
		reader.onload = function(e){
			image_base64 = e.target.result;
			preview.attr("src", image_base64);
		};
		reader.readAsDataURL(file);
	});
}

function PreviewImage() {
  var oFReader = new FileReader();
    oFReader.readAsDataURL(document.getElementById("uploadImage").files[0]);
    oFReader.onload = function (oFREvent) {
    document.getElementById("uploadPreview").src = oFREvent.target.result;
  };
};