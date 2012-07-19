require "rubygems"
require "bundler/setup"

require "brens"

RSpec.configure do |c|
  c.color_enabled = true
  c.formatter     = :documentation
  c.fail_fast     = true
end
