class User < ActiveRecord::Base
  include RecipientFilter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable #, :validatable

  default_scope { all }

  ## Virtual Attributes ##
  attr_accessor :send_to_all

  ## Associations ##
  has_many :authentication_tokens, dependent: :destroy, inverse_of: :user
  has_many :sent_messages, dependent: :destroy, class: Message, foreign_key: :sender_id
  has_many :received_messages, dependent: :destroy, class: Message, foreign_key: :receiver_id
  has_many :comments, dependent: :destroy
  has_many :notifications, class: PublicActivity::Activity, foreign_key: :recipient_id, dependent: :destroy
  has_many :owner_notifications, class: PublicActivity::Activity, foreign_key: :owner_id, dependent: :destroy
  has_many :news_views, -> { where(viewable_type: "News") }, class: View, foreign_key: :user_id, dependent: :destroy
  has_many :forum_views, -> { where(viewable_type: "Forum") }, class: View, foreign_key: :user_id, dependent: :destroy
  has_many :survey_views, -> { where(viewable_type: "Survey") }, class: View, foreign_key: :user_id, dependent: :destroy

  ## Validations ##
  validates :email, :presence => false
  validates :first_name, :last_name, :phone, :password, presence: true, unless: proc { |user| user.admin }
  validate  :atleast_single_reciptient, unless: proc { |user| user.admin }
  validates :username, uniqueness: true
  validate  :email_or_username

  before_validation :set_password, if: proc { |user| !user.admin && user.new_record? }
  after_create :send_welcome_mail, if: proc { |user| !user.admin }
  has_attached_file :avatar,
                    default_url: 'faceless.jpg',
                    styles: { medium: '300x300>', thumb: '100x100>' }

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  ## Scope ##
  scope :non_admins, -> { where(admin: false) }
  scope :admin, -> { find_by(admin: true) }
  scope :device_ids_not_null, -> { where("device_id <> ''") }
  scope :push_eligible_user, ->(type) { where(device_type: type).pluck(:device_id)}

  ## Custom Attributes ##
  attr_accessor :avatar1

  ## Class Methods ##
  def self.invalid_credentials
    'Email or Password is not valid'
  end

  def self.authenticate_user_with_auth(email, password)
    return nil unless email.present? || password.present?
    u = User.find_by_email(email) || User.find_by(username: email)
    (u.present? && u.valid_password?(password)) ? u : nil
  end

  def decode_profile_picture_to_image_data(avatar1)
    cid                  = URI.unescape(avatar1)
    filename             = "avatar1#{Time.now.to_i}"
    file                 = File.open("#{Rails.root}/public/tmp/#{filename}.png", 'wb')
    temp2                = Base64.decode64(cid)
    file.write(temp2)
    file.close
    f                    = File.open("#{Rails.root}/public/tmp/#{filename}.png")
    self.avatar = f
    f.close
    #File.delete("#{Rails.root}/public/tmp/#{filename}.png")
 end

  ## Instance methods ##
  def display_errors
    errors.full_messages.join(',')
  end

  def original_image
    ENV['HOST'] + avatar.url
  end

  def medium_image
    ENV['HOST'] + avatar.url(:medium)
  end

  def thumb_image
    ENV['HOST'] + avatar.url(:thumb)
  end

  def full_name
    format('%s %s', first_name, last_name)
  end

  def messages
    Message.where('sender_id = ? OR receiver_id = ?', id, id)
  end

  def import_users(filepath)
    #importer = ImporterJob.perform_late("import_user", filepath)
    importer = Importer.new("import_user",filepath)
    method, invalid_records = importer.import
    UserMailer.import_status(method, invalid_records).deliver_now!
  end

  def delete_users(filepath)
    #importer = ImporterJob.perform_later("delete_users", filepath)
    importer = Importer.new('delete_users',filepath)
    method, invalid_records = importer.import
    UserMailer.import_status(method, invalid_records).deliver_now!
  end

  def mark_news_viewed(news)
    news.each do |n|
      news_views.find_by(viewable_id: n.id) ||
      news_views.build(viewable_id: n.id).save
    end
  end

  def mark_forums_viewed(forums)
    forums.each do |forum|
      forum_views.find_by(viewable_id: forum.id) ||
      forum_views.build(viewable_id: forum.id).save
    end
  end

  def mark_surveys_viewed(surveys)
    surveys.each do |survey|
      survey_views.find_by(viewable_id: survey.id) ||
      survey_views.build(viewable_id: survey.id).save
    end
  end

  def unread_news(news_ids)
    news_ids.count - news_views.where(viewable_id: news_ids).count
  end

  def unread_surveys(survey_ids)
    survey_ids.count - survey_views.where(viewable_id: survey_ids).count
  end

  def unread_forums(forum_ids)
    forum_ids.count - forum_views.where(viewable_id: forum_ids).count
  end

  private
  def set_password
    self.password = Devise.friendly_token[0,8]
  end

  def send_welcome_mail
    UserMailer.send_credentials_email(self).deliver_now
  end

  def email_or_username
    errors.add(:email, "email or username must be present") if !email.present? && !username.present?
  end

end
