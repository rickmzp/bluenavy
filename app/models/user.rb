class User
  class << self
    def named(name)
      find_or_create_by(name: name)
    end
  end

  include Mongoid::Document

  field :name
  attr_accessible :name
  validates :name,
    presence: true

  def to_s
    name
  end
end
