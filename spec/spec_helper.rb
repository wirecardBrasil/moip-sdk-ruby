require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "moip2"

require "vcr"
require "webmock"

RSpec.configure do |config|

end
ENV['sandbox_url'] = 'https://sandbox.moip.com.br'

VCR.configure do |c|
  c.cassette_library_dir = 'vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
  c.ignore_hosts 'codeclimate.com'
end

# Helper methods
def sandbox_auth
  Moip2::Auth::Basic.new('01010101010101010101010101010101', 'ABABABABABABABABABABABABABABABABABABABAB')
end

def sandbox_oauth
  Moip2::Auth::OAuth.new "nexxgxwtbmib2hywr0rzyt3jbiokslh"
end

def sandbox_client
  Moip2::Client.new(:sandbox, sandbox_auth)
end

def sandbox_oauth_client
  Moip2::Client.new :sandbox, sandbox_oauth
end

def sanbox_client_with_header
  Moip2::Client.new(:sandbox, sandbox_auth, { headers: { "Moip-Account" => "MPA-UY765TYBL912" } } )
end
