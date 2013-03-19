module ApplicationHelper
  def body_dom_classes
    dom_classes = []
    dom_classes << "in_game" if current_game.present?
    dom_classes << "waiting_for_turn" if current_player.try(:waiting_for_turn?)
    dom_classes
  end

  def body_data
    {
      game_id: current_game.try(:id),
      current_player: current_player.try(:to_sym)
    }
  end

  def button_to(*args)
    options = args.extract_options!
    options[:class] ||= "btn"
    super(*args, options)
  end
end
