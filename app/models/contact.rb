class Contact < ActiveRecord::Base
  include RecipientFilter

  ## Validations ##
  validates :first_name, :last_name#, :website, presence: true
  #validates :website, uniqueness: true
  validate :atleast_single_reciptient

  ## Virtual Attribute ##
  attr_accessor :send_to_all

  def self.import_contact(filepath)
    #importer = ImporterJob.perform_late("import_user", filepath)
    importer = Importer.new("import_contact",filepath)
    method, invalid_records = importer.import
    UserMailer.import_status(method, invalid_records).deliver_now!
  end

  def display_errors
    errors.full_messages.join(',')
  end
end
