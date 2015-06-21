class ImporterJob < ActiveJob::Base
  queue_as :importerjob

  def perform(import_type,filepath)
  	importer = Importer.new(import_type,filepath)
    @valid_records, @invalid_records = importer.import
  end
end
