require 'json'

def print_values(seats, col_size, row_size)
    string_j = ""
    col_size.times do |i|
        row_size.times do |j|
            if seats[j].nil? || seats[j][i].nil?
            string_j += "- "
            next
        end
        seats[j][i].each do |k|
            string_j += "#{k} "
        end
        string_j += "   "
        end
        string_j += "\n"
    end
    puts string_j
end

def fill_with_ma_and_w(array)
    seats = []
    array.each do |seat|
        seats.push(Array.new(seat[0]).fill('').map{Array.new(seat[1]).fill("M")})
    end
    seats.each_with_index do |seat, i|
        seat.each_with_index do |row, j|
            seats[i][j][0] = "A"
            seats[i][j][seat[j].length - 1] = "A"
        end
    end
    seats[0].each do |seat|
        seat[0] = "W"
    end
    seats[seats.length - 1].each do |seat|
        seat[seat.length - 1] = "W"
    end
    return seats
end

def replace_with_number(val, counter, seats, col_size, row_size)
    for i in 0..col_size do
        for j in 0..row_size do
            if seats[j]==nil or seats[j][i]==nil
                next
            end
            for k in 0..seats[j][i].length() do
                if seats[j]!=nil and seats[j][i]!=nil and seats[j][i][k]===val
                    seats[j][i][k]=counter;
				    counter+=1;
			    end
		    end
	    end
	end
	return { seats: seats, counter: counter }
end
  

puts 'Enter the seats as 2d array:'
seats_json = gets.chomp
#array = [[3,4], [4,5], [2,3], [3,4]]
array = JSON.parse(seats_json)
row_size = array.map { |e| e[0] }.max
col_size = array.map { |e| e[1] }.max
seats = fill_with_ma_and_w(array)
obj = replace_with_number("A", 1, seats, col_size, row_size)
obj = replace_with_number("W", obj[:counter], obj[:seats], col_size, row_size)
obj = replace_with_number("M", obj[:counter], obj[:seats], col_size, row_size)
seats = obj[:seats]
print_values(seats, col_size, row_size)
