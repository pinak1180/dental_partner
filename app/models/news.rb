class News < ActiveRecord::Base
  acts_as_commentable
  # #Associations##
  has_one :recipient, as: :receivable
end
