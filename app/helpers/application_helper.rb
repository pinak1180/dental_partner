module ApplicationHelper
  def edit_link(link_href, _btnklass = 'table-actions')
    link_to link_href  do
      (content_tag :i, '', class: 'fa fa-pencil').html_safe
    end
  end

  def view_link(link_href)
    link_to link_href, class: 'table-actions' do
      (content_tag :i, '', class: 'fa fa-eye').html_safe
    end
  end

  def delete_link(link_href)
    link_to link_href, method: :delete, data: { confirm: 'Are you sure?' }, class: 'table-actions' do
      (content_tag :i, '', class: 'fa fa-trash-o').html_safe
    end
  end

  def add_link(name, link_href)
    link_to link_href, class: 'btn' do
      (content_tag :i, '', class: 'fa fa-plus') + "#{name} "
    end
  end

  def edit_link1(link_href)
    link_to link_href  do
      (content_tag :i, '', class: 'fa fa-edit') + ('Edit').html_safe
    end
  end
end
