class UserDatatable < AjaxDatatablesRails::Base
  def sortable_columns
    @sortable_columns ||= ['User.first_name', 'User.last_name']
  end

  def searchable_columns
    @searchable_columns ||= ['User.first_name', 'User.last_name']
  end

  private
  def data
    records.map do |record|
      {
        '0' => record.first_name,
        '1' => record.last_name,
        '2' => record.email,
        'DT_RowId' => record.id
      }
    end
  end

  def get_raw_records
    User.non_admins
  end
end
