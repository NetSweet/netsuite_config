require 'dotenv'
require 'netsuite'

Dotenv.load
NetSuite.configure_from_env
