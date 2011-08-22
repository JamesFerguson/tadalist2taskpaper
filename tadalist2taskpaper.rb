#!/usr/bin/env ruby

require 'rubygems'
require 'ruby-debug'
require 'awesome_print'
Dir["#{File.realdirpath(File.dirname(__FILE__))}/lib/**/*.rb"].each { |f| require f }

login = YAML::parse(
                    File.open(
                              File.realdirpath(File.dirname(__FILE__)) + '/config.yml'
                              )
                    ).transform
@acct = TaDaList::Account.new(login["username"], login["password"])

tp = TaskPaper::File.new(@acct.lists)

puts tp.to_s
