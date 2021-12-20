require "test/unit"
require_relative "./src/subway"
require_relative "./src/station"

G1_STATIONS = {
    'a' => Station.new('a', 'red'),
    'b' => Station.new('b')
}

G1_CONNECTIONS = {
    'a' => [
        Station.new('b')
    ],
    'b' => [
        Station.new('a', 'red')
    ]
}

G2_STATIONS = {
    'a' => Station.new('a'),
    'b' => Station.new('b', 'green'),
    'c' => Station.new('c', 'green'),
    'd' => Station.new('d'),
    'e' => Station.new('e'),
}

G2_CONNECTIONS = {
    'a' => [
        Station.new('b', 'green')
    ],
    'b' => [
        Station.new('a'),
        Station.new('d'),
        Station.new('c', 'green')
    ],
    'c' => [
        Station.new('b', 'green'),
        Station.new('d'),
        Station.new('e')

    ],
    'd' => [
        Station.new('b', 'green'),
        Station.new('c', 'green'),
        Station.new('e'),
    ],
    'e' => [
        Station.new('d'),
        Station.new('c', 'green')
    ]
}

class TestSubway < Test::Unit::TestCase
 
    description "Test that simple input with two stations will be created correctly"
    def test_simple_graph_stations_creation
        file_test = File.open('tests/test_0.txt')
        subway = Subway.new
        subway.load_network(file_test)

        assert_equal(G1_STATIONS, subway.stations)

        file_test.close
    end

    description "Test that a simple connection between two station will be created correctly"
    def test_simple_graph_connections_creation
        file_test = File.open('tests/test_0.txt')
        subway = Subway.new
        subway.load_network(file_test)

        assert_equal(G1_CONNECTIONS, subway.connections)

        file_test.close
    end

    description "Test that stations in a loop network will be created correctly"
    def test_loop_graph_stations_creation
        file_test = File.open('tests/test_1.txt')
        subway = Subway.new
        subway.load_network(file_test)

        assert_equal(G2_STATIONS, subway.stations)

        file_test.close
    end

    description "Test that connections in a loop network will be created correctly"
    def test_loop_graph_connections_creation
        file_test = File.open('tests/test_1.txt')
        subway = Subway.new
        subway.load_network(file_test)

        assert_equal(G2_CONNECTIONS, subway.connections)

        file_test.close
    end

end