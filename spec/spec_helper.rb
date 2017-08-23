require "moip2"

require "vcr"
require "webmock"
require "simplecov"
SimpleCov.start

RSpec.configure do |config|
end
ENV["sandbox_url"] = "https://sandbox.moip.com.br"

VCR.configure do |c|
  c.cassette_library_dir = "vcr_cassettes"
  c.hook_into :webmock # or :fakeweb
  c.ignore_hosts "codeclimate.com"
  c.before_record do |i|
    i.response.body.force_encoding("UTF-8")
  end
end

# Helper methods
def sandbox_auth
  Moip2::Auth::Basic.new(
    "01010101010101010101010101010101",
    "ABABABABABABABABABABABABABABABABABABABAB",
  )
end

def sandbox_oauth
  Moip2::Auth::OAuth.new("9fdc242631454d4c95d82e27b4127394_v2")
end

def sandbox_client
  Moip2::Client.new(:sandbox, sandbox_auth)
end

def sandbox_oauth_client
  Moip2::Client.new :sandbox, sandbox_oauth
end

def sanbox_client_with_header
  Moip2::Client.new(:sandbox, sandbox_auth, headers: { "Moip-Account" => "MPA-UY765TYBL912" })
end
