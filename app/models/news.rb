class News < ActiveRecord::Base
  acts_as_commentable
  # #Associations##
  has_one :recipient, as: :receivable

  ## Validations ##
  validates :title, :release_date, :expiry_date, presence: true

  ## Instance Methods ##
  def print_release_date
    release_date.strftime("%d-%m-%Y")
  end

  def print_expiry_date
    expiry_date.strftime("%d-%m-%Y")
  end
end
