class User < Struct.new(:name)
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  class << self
    alias_method :named, :new

    def demongoize(name)
      named(name)
    end

    def mongoize(object)
      object.to_s
    end

    def evolve(object)
      mongoize(object)
    end
  end

  validates :name,
    presence: true

  def id
    name.parameterize unless name.nil?
  end

  def to_s
    name
  end

  def mongoize
    to_s
  end

  def persisted?
    true
  end
end
