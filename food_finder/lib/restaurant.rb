require File.join( APP_ROOT,'lib', 'number_helper.rb' )
require File.join( APP_ROOT,'lib', 'string_extend.rb' )

class Restaurant

    include NumberHelper

    @@filepath = nil

    def self.filepath=(path=nil)
        @@filepath = File.join( APP_ROOT, path )
    end

    attr_accessor :name, :cuisine, :price
    
    def self.file_exists?
        if @@filepath && File.exists?(@@filepath)
            return true
        else
            return false 
        end
    end

    def self.file_usable?
        return false unless @@filepath
        return false unless File.exists?(@@filepath)
        return false unless File.readable?(@@filepath)
        return false unless File.writable?(@@filepath)
        return true 
    end

    def self.create_file
        File.open( @@filepath, 'w' ) unless file_exists?
        return file_usable?
    end

    def self.saved_restaurants
        return display
    end


    def self.display
        arr = []
        if file_usable?
            file = File.new( @@filepath, 'r' )
            file.each_line do | line |
                obj = Restaurant.new
                x = obj.import_line( line.chomp ) 
                arr << x
            end
            file.close
        end
        return arr 
    end

    def import_line( line )
        line_arr = line.split( "," )
        @name, @cuisine, @price = line_arr
        return self
    end

    def self.ask_for_adding
        arr = {}
        print "Resturant Name : "
        arr[ :name ] = gets.chomp.strip
        print "Resturant Cuisine : "
        arr[ :cuisine ] = gets.chomp.strip
        print "Resturant Price : "
        arr[ :price ] = gets.chomp.strip
        return self.new( arr )
    end

    def initialize( arr = {} )
        @name = arr[ :name ] || ""
        @cuisine = arr[ :cuisine ] || ""
        @price = arr[ :price ] || ""
    end

    def save
        return false unless Restaurant.file_usable?
            File.open( @@filepath, 'a' ) do | file |
            file.puts "#{[@name, @cuisine, @price].join(",")}"
        end
        return true
    end

    def formatter_price
        number_to_currency( @price )
    end


end