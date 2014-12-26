NetSuite.configure do
  reset!
  
  email         ENV['NETSUITE_EMAIL']
  password      ENV['NETSUITE_PASSWORD']
  account       ENV['NETSUITE_ACCOUNT']
  role          ENV['NETSUITE_ROLE']

  api_version   ENV['NETSUITE_API']
  read_timeout  100000
  sandbox       ENV['NETSUITE_PRODUCTION'].nil? || ENV['NETSUITE_PRODUCTION'] != 'true'
  # log           File.join(Rails.root, 'log/netsuite.log')
end
