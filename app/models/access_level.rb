class AccessLevel < ActiveRecord::Base
  ## Validations ##
  validates :level, presence: true, uniqueness: { case_sensitive: false }
end
