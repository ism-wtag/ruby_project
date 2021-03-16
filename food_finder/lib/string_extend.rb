class String
    def title
        self.split( " " ).collect{ |x| x.capitalize }.join( " " )
    end 
end