class PractiseCode < ActiveRecord::Base
  ## Validations ##
  validates :code, presence: true, uniqueness: { case_sensitive: false }
end
