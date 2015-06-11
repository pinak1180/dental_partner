class Forum < ActiveRecord::Base
  include RecipientFilter
  acts_as_commentable

  ## Associations ##

  ## Validations ##
  validates :title, :subject, :release_date, :expiry_date, presence: true
  validate :atleast_single_reciptient, :correct_expiry_date
end
