class Document < ActiveRecord::Base
  has_attached_file :file,
                    url: "/documents/:basename.:extension"
  validates_attachment_content_type :file, content_type: ['application/pdf']
  validates :title, :file, presence: true
  validates :title, uniqueness: true

  ## Instance Methods ##
  def display_url
    ENV['HOST'] + file.url
  end
end
