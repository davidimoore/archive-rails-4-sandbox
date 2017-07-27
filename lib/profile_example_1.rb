require 'date'
require 'rubygems'
require 'ruby-prof'
GC.disable
RubyProf.start
Date.parse("2014-07-01")
result = RubyProf.stop
printer = RubyProf::FlatPrinter.new(result)
printer.print(File.open("lib/profiles/ruby_prof_example_api1_profile.txt", "w+"))
