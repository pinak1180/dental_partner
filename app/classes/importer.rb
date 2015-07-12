class Importer
  attr_reader :filepath, :action_type

  def initialize(action_type, filepath)
    @filepath    = filepath
    @action_type = action_type
  end

  def import
    self.send(@action_type)
  end

  def import_user
    @valid_records = []
    @invalid_records = []
    if filepath.present?
      results = SmarterCSV.process(filepath)
      results.each do |result|
        position_ids  = Position.where(name: result[:positions].split(',')).ids rescue []
        direct_report = User.where(email: result[:direct_report].split(',')).ids rescue []
        access_levels = AccessLevel.where(level: result[:access_levels].split(',')).ids rescue []
        departments   = Department.where(name: result[:departments].split(',')).ids rescue []
        practise_codes= PractiseCode.where(code: result[:practise_codes].split(',')).ids rescue []
        user = User.find_by_login(result[:email] || result[:username])
        if !user.present?
          user = result[:email].present? ? User.new(email: result[:email]) : User.new(username: result[:username])
        end
        user.email             = result[:email]
        user.username          = result[:username]
        user.first_name        = result[:first_name]
        user.last_name         = result[:last_name]
        user.phone             = result[:phone]
        user.postal_code       = result[:postal_code]
        user.password          = result[:password]
        user.position_ids      = position_ids
        user.department_ids    = departments
        user.access_level_ids  = access_levels
        user.practise_code_ids = practise_codes
        if user.save
          @valid_records << user
        else
          @invalid_records << [(user.email || user.username || user.full_name), user.display_errors]
        end
      end
    end
    return 'user_import', @invalid_records
  end

  def delete_users
    @valid_records = []
    @invalid_records = []
    if filepath.present?
      results      = SmarterCSV.process(filepath)
      emails       = results.collect{|x| x[:emails_or_username] }
      found_emails = User.where(email: emails)
      found_usernames = User.where(username: emails)
      not_found = emails - found_emails.pluck(:email) - found_usernames.pluck(:username)
      found_emails.destroy_all
      found_usernames.destroy_all
      @invalid_records = [emails.join(', '), "where not found in the system"]
    end
    return 'user_delete', @invalid_records
  end

  def import_contact
    @valid_records = []
    @invalid_records = []
    if filepath.present?
      results      = SmarterCSV.process(filepath)
      results.each do |result|
        position_ids  = Position.where(name: result[:position].split(',')).ids rescue []
        department_ids   = Department.where(name: result[:departments].split(',')).ids rescue []
        results = SmarterCSV.process(filepath)
        contact = Contact.find_or_initialize_by(email: result[:email])
        contact.first_name = result[:first_name]
        contact.last_name = result[:last_name]
        contact.phone = result[:phone]
        contact.position_ids = position_ids
        contact.department_ids = department_ids
        if !contact.save
          @invalid_records << [(contact.email || contact.first_name || contact.last_name), contact.display_errors]
        end
      end
    end
    return 'contact_import', @invalid_records
  end
end
