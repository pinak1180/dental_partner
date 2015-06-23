class ImporterJob < ActiveJob::Base
  queue_as :importjob

  def perform(import_type,filepath)
  	importer = Importer.new(import_type,filepath)
    method, invalid_records = importer.import
    UserMailer.import_status(method, invalid_records).deliver_later! 
  end
end
