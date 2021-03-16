require File.join( APP_ROOT, 'lib', 'restaurant.rb' )

class Guide

    def initialize(path=nil)
        Restaurant.filepath = path

        if Restaurant.file_usable?
            puts "Found restaurant File"
        elsif Restaurant.create_file
            puts "Created restaurant File"
        else 
            puts "Exiting..."
            exit
        end
    end


    def launch!
        introduction

        result = nil 
        until result == :quit  
            action = get_action
            result = do_action( action )
        end

        conclusion
    end

    class Config
        @@actions = [ "list", "find", "add", "quit" ]
        def self.actions
            @@actions
        end
    end

    def get_action
        action = nil 
        until Guide::Config.actions.include?(action) #will work except Guide::
            puts "Actions :" + Config.actions.join(",") if action
            print "command > "
            user_response = gets.chomp
            action = user_response.downcase.strip
        end
        return action
    end


    def do_action( action )
        case action
        when "add"
            add
        when "list"
            list
            
            puts "Want to sort 1 for yes 2 for no? "
            x = gets.chomp
            if( x.to_i == 1 )
                puts "In which order ( name,cuisine or price )"
                sort_order = gets.chomp
                arr = Restaurant.saved_restaurants
                arr.sort! do | a, b |
                    case sort_order
                    when "name"
                        a.name.downcase <=> b.name.downcase
                    when "cuisine"
                        a.cuisine.downcase <=> b.cuisine.downcase
                    when "price"  
                        a.price.to_i <=> b.price.to_i
                    end  
                end
                output_restaurant( arr )
            else
                puts "Ok, No need to sort"
            end
            
        when "find"
            puts "Input the word you want to search"
            keyword = gets.chomp
            find( keyword )
        when "quit"
            return :quit
        else
            puts "I don't understand that coomand"
        end
    end


    def add
        puts "Add a resturant"
        obj = Restaurant.ask_for_adding
        if obj.save
            puts "Restaurant Added"
        else 
            puts "Error, Restaurant is not added"
        end
    end

    def list 
        puts "Listing a resturant".upcase.center(50)
        arr = Restaurant.display
        output_restaurant( arr )
    end

    def output_restaurant( arr )
        print "Name".ljust(15) +  " Cuisine".ljust(25) + " Price".ljust(35) + "\n"
        puts "-" * 50
        arr.each do | x |
            print x.name.title.ljust(15) + " " + x.cuisine.title.ljust(25) + " " + x.formatter_price.ljust(35) + "\n"
        end
        puts "-" * 50
    end


    def find( keyword )
        obj = Restaurant.saved_restaurants
        found = obj.select do |x|
            x.name.title.downcase.include?( keyword.downcase ) ||
            x.cuisine.title.downcase.include?( keyword.downcase ) ||
            x.price.to_i <= keyword.to_i
        end

        if( found.empty? )
            puts "don't found"
            
        else
            output_restaurant( found )
        end
    end

    def introduction
        puts "This is introduction part"
    end

    def conclusion
        puts "This is conclusion part"
    end

end