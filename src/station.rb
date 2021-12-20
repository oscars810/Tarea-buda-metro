class Station
    attr_reader :name, :color
    ALLOWED_COLORS = ['red', 'green']

    def initialize(name, color = nil)
        @name = name
        @color = assign_color(color)
    end

    def color=(color)
        @color = assign_color(color)
    end

    def ==(other)
        self.name == other.name &&
        self.color == other.color
    end

    private

    def assign_color(color)
        return nil if color.nil?
        ALLOWED_COLORS.include?(color) ? color : @color
    end
end