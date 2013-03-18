class Ship < Struct.new(:name, :size)
  class << self
    alias_method :named, :new
  end
end
