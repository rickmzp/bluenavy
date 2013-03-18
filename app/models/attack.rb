class Attack
  include Mongoid::Document

  def self.launch_on(target)
    new(target: target)
  end

  embedded_in :navy, inverse_of: :attacks

  field :target, type: Point
  attr_accessible :target
end
