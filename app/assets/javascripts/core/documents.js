function add_fields(){
  var fields = '<div class="extra"><hr/><label for="title">Title</label><input type="text" name="document[][title]" id="document_title_" value="" class="form-control" autofocus="autofocus"><br><label for="file">File</label><input type="file" name="document[][file]" id="document_file_" class="form-control" autofocus="autofocus" accept="application/pdf"><br><a class="remove btn btn-danger btn-xs pull-right">Remove</a></div>'
  $('.add_extra').append(fields);

  $(".remove").click(function(event) {
    $(this).closest('div').remove();
  });
}
