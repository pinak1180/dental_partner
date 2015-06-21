class ImporterJob < ActiveJob::Base
  queue_as :importjob

  def perform(import_type,filepath)
  	importer = Importer.new(import_type,filepath)
    @valid_records, @invalid_records = importer.import
  end
end
