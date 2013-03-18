class Point

  # TODO: reorganize .from and #initialize
  class << self
    def from(target)
      return if target.blank?
      return target.to_point if target.respond_to?(:to_point)
      new(target)
    end

    alias_method :at, :from
  end

  def initialize(symbol_or_vector)
    if symbol_or_vector.respond_to?(:to_sym)
      @symbol = symbol_or_vector.to_sym
      @vector = symbol_to_vector(@symbol)
    elsif symbol_or_vector.respond_to?(:to_a)
      @vector = symbol_or_vector.to_a
      Rails.logger.info "start: #{@vector.inspect}"
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

  def self.demongoize(array)
    Point.from(array)
  end

  protected

  def symbol_to_vector(symbol)
    letter, number = extract_letter_number_from(symbol)
    [column_to_index(number), row_to_index(letter)]
  end

  def vector_to_symbol(vector)
    #
  end

  def ensure_valid_vector!(symbol, letter, number)
    if letter.blank? || number.blank?
      raise ArgumentError.new("invalid vector: #{symbol}")
    end
  end

  def extract_letter_number_from(symbol)
    letter, number = symbol.to_s.scan(/^([A-J])(\d+)$/)[0]
    ensure_valid_vector!(symbol, letter, number)
    number = number.to_i
    [letter, number]
  end

  def row_to_index(letter)
    rows.index(letter)
  end

  def index_to_row(index)
    rows[index]
  end

  def rows
    %w(A B C D E F G H I J)
  end

  def column_to_index(number)
    number - 1
  end

end
