namespace :dental_partner do
  desc "Adding clinic codes"
  task :add_clinic_code => :environment do
    oo = Roo::Excelx.new("150714_ClinicLocations.xlsx")
    puts("=================   P L E A S E     W A I T . . .    ================")
    oo.default_sheet = oo.sheets.first
    PractiseCode.destroy_all
    2.upto(83) do |line|
      if oo.cell(line,'A').present?
        p = PractiseCode.new(code: oo.cell(line,'A') )
        unless p.save
          puts p.errors.full_messages
        end
      end
    end
  end
end
