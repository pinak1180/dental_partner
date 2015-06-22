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
        user                   = User.find_or_create_by(email: result[:email])
        user.first_name        = result[:first_name]
        user.last_name         = result[:last_name]
        user.phone             = result[:phone]
        user.postal_code       = result[:postal_code]
        user.position_ids      = position_ids
        user.department_ids    = departments
        user.access_level_ids  = access_levels
        user.practise_code_ids = practise_codes
        if user.save
          @valid_records << user
        else
          @invalid_records << [user.email, user.display_errors]
        end
      end
    end
    return @valid_records, @invalid_records
  end
end
