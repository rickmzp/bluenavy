class Navy
  include Mongoid::Document
  embedded_in :player

  def deploy(strategy)
    self.strategy = true
  end

  attr_reader :strategy

  def deployed?
    strategy.present?
  end

  private

  attr_writer :strategy
end
