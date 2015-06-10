class Forum < ActiveRecord::Base
  include RecipientFilter
  acts_as_commentable

  ## Associations ##
  has_one :recipient, as: :receivable

  ## Callbacks ##
  after_create :create_recipient_filter

  ## Validations ##
  validates :title, :subject, :release_date, :expiry_date, presence: true
  validate :atleast_single_reciptient

  private
  def atleast_single_reciptient
    errors.add(:position_ids, "must be present") unless (position_ids || department_ids || practise_code_ids || direct_report_ids).present?
  end
end
