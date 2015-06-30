class SurveySerializer < ActiveModel::Serializer
  ## Attributes ##
  attributes  :id, :title, :description, :release_date, :expiry_date,
              :is_completed_by_user, :questions, :departments, :tags
              :created_on

  ## Associations ##
  has_many :questions

  ## Instance Methods ##
  def created_on
    object.print_created_at
  end

  def attributes
    super.except(:questions) if serialization_options[:show_details]
  end

  def is_completed_by_user
    object.responses.find_by(user_id: serialization_options[:user_id]).present?
  end
  def release_date
    object.print_release_date
  end

  def expiry_date
    object.print_expiry_date
  end

  def departments
    object.departments
  end
end
