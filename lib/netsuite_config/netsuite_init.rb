NetSuite.configure do
  reset!

  read_timeout  100_000

  email         ENV['NETSUITE_EMAIL']
  password      ENV['NETSUITE_PASSWORD']
  account       ENV['NETSUITE_ACCOUNT']
  role          ENV['NETSUITE_ROLE']

  api_version   ENV['NETSUITE_API']
  sandbox       ENV['NETSUITE_PRODUCTION'].nil? || ENV['NETSUITE_PRODUCTION'] != 'true'
  # log           File.join(Rails.root, 'log/netsuite.log')

  if ENV['NETSUITE_WSDL_DOMAIN']
    wsdl_domain ENV['NETSUITE_WSDL_DOMAIN']
  end
end
