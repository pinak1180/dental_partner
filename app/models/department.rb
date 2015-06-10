class Department < ActiveRecord::Base
  ## Validations ##
  validates :name, presence: true, uniqueness: true
end
