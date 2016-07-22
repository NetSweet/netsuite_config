# NetSuite SuiteScript and Configuration Versioning and Management

NOTE: very beta, horrible documentation.

Functionality:

* Easily pull SuiteScripts active in a NetSuite instance for easy versioning and updates
* Interactive SuiteTalk console
* Determine which features are active on a NetSuite account, and provide a history of configuration updates

## Installation

Add this line to your application's Gemfile:

```ruby
gem install netsuite_config
```

Make sure you have these ENV in place

```bash
NETSUITE_EMAIL=
NETSUITE_PASSWORD=
NETSUITE_ACCOUNT=
NETSUITE_ROLE=
NETSUITE_API=
NETSUITE_PRODUCTION=
```

## Usage

```bash
netsuite_config console
netsuite_config pull

# not yet implemented...
netsuite_config push
netsuite_config diff
```

## Testing

```sh
export PATH="$HOME/Projects/netsuite_config/bin:$PATH"
export GEM_HOME=$HOME/Projects/netsuite_config/vendor/bundle/gems:$GEM_HOME
export GEM_PATH="$HOME/Projects/netsuite_config/vendor/bundle:$GEM_PATH"
export RUBYLIB="$HOME/Projects/netsuite_config/lib:$RUBYLIB"
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/netsuite_config/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
