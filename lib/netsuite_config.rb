require 'netsuite'
require 'base64'
require 'yaml'

require 'dotenv'
Dotenv.load '.env'

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
    general_config = YAML.load_file('netsuite_config.yml')

    types_to_pull = general_config["types"] || TYPE_MAPPING.keys

    NetSuite.configure_from_env

    search = NetSuite::Records::File.search({
      basic: [
        {
          field: 'fileType',
          operator: 'anyOf',
          value: types_to_pull
        }
      ],
      preferences: {
        bodyFieldsOnly: false,
        page_size: 500
      }
    })

    search.results_in_batches do |batch|
      batch.each do |file|
        next unless types_to_pull.include?(file.file_type)

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
