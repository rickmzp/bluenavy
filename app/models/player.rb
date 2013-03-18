class Player < Struct.new(:name, :game)
  include Mongoid::Document

  def self.named(name)
    player = new
    player.name = name
    player
  end

  embedded_in :game

  field :name, type: String
  validates :name,
    presence: true

  def to_s
    name
  end

  embeds_one :navy

  after_initialize :build_navy_if_nil

  field :ready_to_attack, type: Boolean, default: false
  validates :ready_to_attack,
    inclusion: [true, false]

  def ready!
    update_attributes! ready_to_attack: true
  end

  private

  def build_navy_if_nil
    build_navy if navy.nil?
  end
end
