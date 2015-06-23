module ApplicationHelper
  def flash_class(level)
    case level
      when "notice" then "alert alert-info"
      when "success" then "alert alert-success"
      when "error" then "alert alert-danger"
      when "alert" then "alert alert-danger"
    end
  end

  def page_title(title)
    title.present? ? "#{title} | Dental Partners" : "Dental Partners"
  end

  def check_active(controller, value)
    params[:controller].present? && params[:controller] == controller ? value : ""
  end

  def avatar_input_for(name, image, label)
    html = "<p class='form-label'> #{label}
    <div class='settings_account_avatar'>
      #{image_tag image, id: 'uploadPreview', size: '150x150'}
      <div class='settings_account_avatar_button'><i class='fa fa-camera fa-5x'></i></div>
      <input type='file' name='#{name}' id='uploadImage' title='Click to upload picture' alt='Click to upload picture' autocomplete='off' onchange='PreviewImage();' accept='image/*'>
    </div>
    </p>"
    html.html_safe
  end
end
