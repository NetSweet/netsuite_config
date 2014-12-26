require 'netsuite'
require 'netsuite_config/netsuite_init'
require 'base64'

module NetSuiteConfig
  extend self

  def pull
    dump_directory = File.join(Dir.pwd, 'suite-scripts')

    unless File.exists?(dump_directory)
      Dir.mkdir dump_directory
    end

    search = NetSuite::Records::File.search({
      preferences: {
        bodyFieldsOnly: false,
        page_size: 500
      }
    })

    search.results_in_batches do |batch|
      batch.each do |file|
        next unless file.file_type == "_JAVASCRIPT"

        # _HTMLDOC
        # _PDF

        begin
          full_file = NetSuite::Records::File.get file.internal_id

          if full_file
            File.open(File.join(dump_directory, full_file.name), 'w') { |f| f.write(Base64.decode64(full_file.content)) }
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
