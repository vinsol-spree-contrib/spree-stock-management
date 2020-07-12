# encoding: UTF-8
lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'spree_one_page_stock_management/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_one_page_stock_management'
  s.version     = SpreeOnePageStockManagement.version
  s.summary     = 'This extension allows admin to update stock inventories from a single page inventory management panel through a csv or through inventory list UI.'
  s.description = 'This extension allows admin to update stock inventories from a single page inventory management panel through a csv or through inventory list UI.'
  s.required_ruby_version = '>= 2.2.7'

  s.author    = ['tanmay', 'himanshu']
  s.email     = 'info@vinsol.com'
  s.homepage  = 'https://github.com/vinsol-spree-contrib/spree_one_page_stock_management'
  s.license = 'BSD-3-Clause'

  # s.files       = `git ls-files`.split("\n").reject { |f| f.match(/^spec/) && !f.match(/^spec\/fixtures/) }
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '>= 3.1.0', '< 4.0'
  s.add_dependency 'spree_extension'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'capybara-screenshot'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_bot'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'pg', '~> 0.18'
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'appraisal'

end
