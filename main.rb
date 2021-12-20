require_relative './src/subway'

subway = Subway.new

if ARGV.length < 3
    puts "Too few arguments"
    puts "Please include: <input.txt> <start_station> <destination_station> <train_color>(optional)"
    exit
end

file_path = ARGV[0]
start_station = ARGV[1]
destination_station = ARGV[2]
train_color = ARGV[3]

file = File.open(file_path)

subway.load_network(file)
trips = subway.calculate_trips(start_station, destination_station, train_color)
subway.print_trips(trips)

file.close