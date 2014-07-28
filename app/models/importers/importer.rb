class Importers::Importer
  require 'csv'
  require 'fileutils'

  def self.import_local_registered_identity_csvs!
    Dir.entries("imports").select { |filename| /^(.)+.csv$/ =~ filename }.each do |csv_filename|
      file = File.open("imports/#{csv_filename}")
      succeeded = import_file!(file, GoldStandardIdentity, true)
      file.close
      FileUtils.mv("imports/#{csv_filename}", "imported/#{csv_filename}") if succeeded
    end
  end

  def self.import_file!(csv_file, imported_model, should_log = false)
    import_succeeded = true

    if should_log
      file_name = File.basename(csv_file)
      log = File.open("import_logs/#{imported_model}_#{Date.today}_#{file_name}", 'w')
      log << "success,file_id,name,db_id,error_message,,\n"
    else
      log = nil
    end

    ActiveRecord::Base.transaction do
      CSV.foreach(csv_file, headers: true) do |row|
        import_succeeded &&= import_row(row, imported_model, log)
      end
      raise ActiveRecord::Rollback unless import_succeeded
    end

    log.close if log
    import_succeeded
  end

  def self.import_row(row, imported_model, log)

    row = row.to_hash
    sanitized_row = permitted_attributes(row, imported_model)
    new_identity = imported_model.new(sanitized_row)
    is_successful = !!new_identity.save

    if log
      log_fields = [
        is_successful,
        row['id'],
        row['first_name'] + " " + row['last_name'],
        new_identity.id,
        new_identity.errors.messages.to_s.gsub(",",";")
      ]
      log << (log_fields.join(",") + ",,\n")
    end

    is_successful
  end

  def self.permitted_attributes(row, imported_model)
    row.select do |(attribute, value)|
       imported_model.column_names.include?(attribute) && attribute != 'id'
    end
  end
end