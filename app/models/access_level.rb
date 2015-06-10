class AccessLevel < ActiveRecord::Base
  ## Validations ##
  validates :level, presence: true, uniqueness: true
end
