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
  gem.homepage = "http://github.com/martinkozak/image-optimizer"
  gem.license = "MIT"
  gem.summary = "Optimizes given JPEG and PNG images or images in given folder. Uses several encoders for achieving the best possible lossless compression ratio and tries to employ the most advanced methods such as JPEG algorithmic encoding if available or PNG transparent pixels stripping and automatic color reduction."
  gem.email = "martinkozak@martinkozak.net"
  gem.authors = ["Martin Kozák"]
end
Jeweler::RubygemsDotOrgTasks.new
