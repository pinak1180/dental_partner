module Admins::DocumentsHelper
  def content_type(document)
    case document.file_file_name.split('.').last
    when 'pdf'
      '<i class="fa fa-file-pdf-o fa-2"></i>'.html_safe
    when 'jpg'
      '<i class="fa fa-file-image-o fa-2"></i>'.html_safe
    when 'txt'
      '<i class="fa fa-file-text fa-2"></i>'.html_safe
    else
      '<i class="fa fa-file fa-2"></i>'.html_safe
    end
  end
end
