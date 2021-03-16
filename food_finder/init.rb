APP_ROOT = File.dirname(__FILE__)
puts APP_ROOT 
require "#{APP_ROOT}/lib/guide"

require File.join( APP_ROOT, 'lib', 'guide.rb' )

guide = Guide.new( 'restaurant.txt' )
guide.launch! 


=begin

ruby init.rb

=end

