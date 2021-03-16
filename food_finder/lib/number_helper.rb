module NumberHelper
    
    def number_to_currency( number, arr = {} )
        unit = arr[ :unit ] || "$"
        precision = arr[ :precision ] || 2
        delimiter = arr[ :delimiter ] || ","
        separator = arr[ :separator ] || "."

        separator = "" if precision == 0
        integer, decimal = number.to_s.split( "." )

        i = integer.length
        while i > 3
            i -= 3
            integer = integer.insert( i, delimiter ) 
        end

        if precision == 0
            precision_decimal = ""
        else 
            decimal ||= "0"
            decimal = decimal[ 0, precision - 1 ]
            precision_decimal = decimal.ljust( precision, "0" )
        end

        return unit + integer + separator + precision_decimal 
    end
end
