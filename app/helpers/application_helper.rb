module ApplicationHelper
  def body_dom_classes
    dom_classes = []
    dom_classes << "in_game" if current_game.present?
    dom_classes << "waiting_for_turn" if current_player.try(:waiting_for_turn?)
    dom_classes
  end
end
