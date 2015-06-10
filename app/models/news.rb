class News < ActiveRecord::Base
  include RecipientFilter
  acts_as_commentable
  # #Associations##
  has_one :recipient, as: :receivable
  ##callbacks
  after_create :create_recipient_filter

  ## Validations ##
  validates :title, :content, presence: true

  ## Instance Methods ##
  def print_release_date
    release_date.strftime("%d-%m-%Y")
  end

  def print_expiry_date
    expiry_date.strftime("%d-%m-%Y")
  end
end
