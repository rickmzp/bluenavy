class Point
  include GridSupport

  # TODO: reorganize .from and #initialize
  class << self
    def demongoize(*args)
      object = args.first
      return if object.blank?
      Point.new(object)
    end

    def at(x, y)
      Point.new([x, y])
    end

    alias_method :from, :demongoize
  end

  def initialize(symbol_or_vector, y = nil)
    if symbol_or_vector.respond_to?(:to_sym)
      @symbol = symbol_or_vector.to_sym
      @vector = symbol_to_vector(@symbol)
    elsif symbol_or_vector.respond_to?(:to_a)
      @vector = symbol_or_vector.to_a
      @symbol = vector_to_symbol(@vector)
    else
      message = "Need a symbol (responds to #to_sym) or a vector (responds to #to_a)"
      raise ArgumentError.new(message)
    end
  end

  def ==(other)
    if other.respond_to?(:to_a)
      vector == other.to_a
    else
      super
    end
  end

  attr_reader :symbol

  alias_method :to_sym, :symbol

  attr_reader :vector

  alias_method :to_a, :vector

  def x
    vector.first
  end

  def y
    vector.last
  end

  def change_x(offset)
    Point.new([x + offset, y])
  end

  def change_y(offset)
    Point.new([x, y + offset])
  end

  def to_point
    self
  end

  def mongoize
    return if x.blank? && y.blank?
    [x, y]
  end
end
