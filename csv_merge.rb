 require 'csv'
 require 'fileutils'

 def merge_csv_imports
    count = 0

    Dir.entries("imported").select { |filename| /^(.)+.csv$/ =~ filename }.each do |csv_filename|
      file = File.open("imported/#{csv_filename}")
      if count == 0
        header = get_header(file)
        export_file = File.open("compiled/merged_data_#{Date.today}.csv",'a') { |file| file.write(header) }
      end
      fimports = merge_file(file)
      file.close  

      fimports.each do |entry|

        export_file = File.open("compiled/merged_data_#{Date.today}.csv",'a') { |file| file.write(entry) } #.as_csv
        count = count + 1
      end

    end

 end
 
  def get_header(file)
    count = 0
    header = ""

    File.open(file.path,'r').each do |f|
      f.each_line do |line|
        if count == 0
          header = line
        end
        count = count + 1
      end
    end

    header
  end



 def merge_file(file)
    data = ""
    entries = Array.new
    count = 0

    File.open(file.path) do |f|
      CSV.foreach(f, headers: true) do |line|
        data = line
        entries[count] = data
        count = count + 1
      end
    end

    entries
 end
 
 puts merge_csv_imports