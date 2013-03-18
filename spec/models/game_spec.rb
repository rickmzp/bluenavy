require "spec_helper"

describe Game do
  let(:game) { create(:game, :in_progress) }
  let(:player_1) { game.player_1 }
  let(:player_2) { game.player_2 }
  subject { game }

  its(:player_with_turn) { should eq(player_1) }

  describe ".attack_by" do
    let(:attacker) { player_1 }
    let(:target) { Point.from(:A1) }
    subject { game.attack_by(attacker, target: target) }

    it { is_expected.to change(game, :player_with_turn).to(player_2) }

    context "when it is the attacker's turn" do
      it { should be_successful }
    end

    context "when it is not the attacker's turn" do
      let(:attacker) { player_2 }
      it { is_expected.to raise_error(Game::OutOfTurn) }
    end
  end

  describe "attacks finders" do
    let!(:p1_attack) { game.attack_by(player_1, target: :A1) }
    let!(:p2_attack) { game.attack_by(player_2, target: :A2) }

    describe ".attacks" do
      subject { game.attacks }
      its(:length) { should eq(2) }
      it { should include(p1_attack) }
      it { should include(p2_attack) }
    end

    describe ".attacks_by" do
      subject { game.attacks_by(player).to_a }

      context "player 1" do
        let(:player) { game.player_1 }
        it { should eq([p1_attack]) }
      end

      context "player 2" do
        let(:player) { game.player_2 }
        it { should eq([p2_attack]) }
      end
    end
  end
end
