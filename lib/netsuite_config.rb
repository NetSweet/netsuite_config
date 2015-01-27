require 'netsuite'
require 'netsuite_config/netsuite_init'
require 'base64'

module NetSuiteConfig
  extend self

  TYPE_MAPPING = {
    '_JAVASCRIPT' => 'suite-script',
    '_PDF' => 'pdf',
    '_HTMLDOC' => 'html',
    '_MISCTEXT' => 'text',
    '_JPGIMAGE' => 'images/jpeg',
    '_PJPGIMAGE' => 'images/jpeg',
    '_GIFIMAGE' => 'images/gif',
    '_PNGIMAGE' => 'images/png',
    '_MISCBINARY' => 'binary',
    '_EXCEL' => 'excel' 
  }

  def pull
    search = NetSuite::Records::File.search({
      preferences: {
        bodyFieldsOnly: false,
        page_size: 500
      }
    })

    search.results_in_batches do |batch|
      batch.each do |file|
        unless TYPE_MAPPING.has_key?(file.file_type)
          raise "type not handled #{file.file_type}"
        end

        output_directory = File.join(Dir.pwd, TYPE_MAPPING[file.file_type])

        unless File.exists?(output_directory)
          FileUtils.mkdir_p output_directory
        end

        begin
          full_file = NetSuite::Records::File.get file.internal_id

          if full_file
            File.open(File.join(output_directory, full_file.name), 'w') { |f| f.write(Base64.decode64(full_file.content)) }
          else
            puts "Error downloading file: #{file.internal_id}"
          end
        rescue Exception => e
          puts "Error downloading file: #{file.internal_id}"
        end
      end
    end
  end

end
