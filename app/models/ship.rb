class Ship
  include Mongoid::Document
  embedded_in :deployment, inverse_of: :ship

  class << self
    def named(name, size)
      new do |ship|
        ship.name = name
        ship.size = size
      end
    end
  end

  field :name, type: String
  validates :name,
    presence: true

  field :size, type: Integer
  validates :size,
    numericality: { min: 1 }
end
