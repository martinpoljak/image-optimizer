# encoding: utf-8

require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'
require 'jeweler'

Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  
  gem.name = "image-optimizer"
  gem.homepage = "https://github.com/martinkozak/image-optimizer"
  gem.license = "MIT"
  gem.summary = "Yet another options parser. Parses the command-line arguments and parameters. Simple, lightweight with nice declarative approach."
  gem.email = "martinkozak@martinkozak.net"
  gem.authors = ["Martin Kozák"]
  gem.executables = ["image-optimizer"]
end
Jeweler::RubygemsDotOrgTasks.new
