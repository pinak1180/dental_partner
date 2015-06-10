class PractiseCode < ActiveRecord::Base
  ## Validations ##
  validates :code, presence: true, uniqueness: true
end
