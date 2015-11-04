# spec_helper.rb
RSpec.configure do |config|
  # ...
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

require_relative '../burger'

require 'rspec/collection_matchers'