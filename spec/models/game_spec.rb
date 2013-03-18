require "spec_helper"

describe Game do
  describe ".attack_by" do
    let(:game) { create(:game, :in_progress) }
    let(:target) { Point.at(:A1) }

    subject { game.attack_by(attacker, target: target) }

    context "when it is the attacker's turn" do
      let(:attacker) { game.player_1 }
      it { should be_successful }
    end

    context "when it is not the attacker's turn" do
      let(:attacker) { game.player_2 }
      it { is_expected.to raise_error(Game::OutOfTurn) }
    end
  end
end
