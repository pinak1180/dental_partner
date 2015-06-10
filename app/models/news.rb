class News < ActiveRecord::Base
  include RecipientFilter
  acts_as_commentable
  # #Associations##
  has_one :recipient, as: :receivable
  # #callbacks
  after_create :create_recipient_filter

  ## Validations ##
  validates :title, :content, :poster_avatar, presence: true
  has_attached_file :poster_avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :poster_avatar, content_type: /\Aimage\/.*\Z/

  ## Instance Methods ##
  def print_release_date
    release_date.strftime('%d-%m-%Y')
  end

  def print_expiry_date
    expiry_date.strftime('%d-%m-%Y')
  end

  def medium_image
    ENV['HOST'] + poster_avatar.url(:medium)
  end

  def thumb_image
    ENV['HOST'] + poster_avatar.url(:thumb)
  end
end
