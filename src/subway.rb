require_relative "station"

class Subway
    attr_reader :connections, :stations

    def initialize
        @connections = Hash.new { |h, key| h[key] = [] } # Represents all connections of each station
        @stations = Hash.new
    end

    def load_network(file)
        file_data = file.readlines.map(&:chomp)

        file_data.each do |station_data|
            name_a, name_b, color_a, color_b = station_data.split
            station_a = find_or_create_station(name_a, color_a)
            station_b = find_or_create_station(name_b, color_b)
            create_connection(station_a, station_b)
        end
    end

    def calculate_trips(name_s_a, name_s_b, color = nil)
        bfs(name_s_a, name_s_b, color)
    end

    def print_trips(trips)
        trips.each_with_index do |trip, i|
            path = ''
            puts "Option #{i + 1}"
            trip.each do |station|
                path += station
                path += ' -> '
            end
            path = path[0...-3]
            puts "#{path}"
        end
    end

    private

    def find_or_create_station(name, color)
        if @stations.key?(name)
            @stations[name].color = color if !color.nil?
            return @stations[name]
        else
            new_station = Station.new(name, color)
            @stations[name] = new_station
            return new_station
        end
    end

    def create_connection(station_a, station_b)
        # Each node connects bi-directionally
        @connections[station_a.name].push(station_b)
        @connections[station_b.name].push(station_a)
    end

    def bfs(origin, destination, color)
        visited = Hash.new { |h, key| h[key] = false }

        queue = []
        correct_paths = []

        queue.push( [origin, [origin]] )
        visited[origin] = true
        while queue.length != 0
            current_station, path = queue.shift
            @connections[current_station].each do |station|
                if !visited[station.name]
                    if will_the_train_stop?(station, color)
                        queue.push([station.name, path + [station.name]])
                    else
                        queue.push([station.name, path])
                    end
                    visited[station.name] = true
                end
                if station.name == destination
                    correct_paths.push(path + [destination])
                    visited[station.name] = false
                end
            end            
        end
        get_shortest_paths(correct_paths)
    end
    
    def get_shortest_paths(paths)
        paths = paths.sort_by(&:length)
        shorter_len = paths.first.length
        shortest_paths = []
        paths.each do |path|
            break if path.length != shorter_len
            shortest_paths.push(path)
        end
        shortest_paths
    end

    def will_the_train_stop?(station, color)
        return color.nil? || station.color.nil? || station.color == color
    end
end