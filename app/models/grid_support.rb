module GridSupport
  def symbol_to_vector(symbol)
    letter, number = extract_letter_number_from(symbol)
    [column_to_index(number), row_to_index(letter)]
  end

  def vector_to_symbol(vector)
    :"#{rows[x]}#{columns[y]}"
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

  def columns
    (1..10).to_a
  end

  def column_to_index(number)
    number - 1
  end
end
