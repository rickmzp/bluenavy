require "spec_helper"

describe ShipDeployment do
  let(:ship) { build(:ship, size: size) }
  let(:size) { 2 }
  let(:start_point) { :A1 }
  let(:direction) { :horizontal }
  let(:deployment) { ShipDeployment.new(ship, start_point, direction) }

  describe "#vectors" do
    subject { deployment.vectors }

    context "ship" do
      let(:size) { 1 }
      it { should eq([[0, 0]]) }
    end

    context "direction" do
      context "when horizontal" do
        let(:direction) { :horizontal }
        it { should eq([[0, 0], [1, 0]]) }
      end

      context "when vertical" do
        let(:direction) { :vertical }
        it { should eq([[0, 0], [0, 1]]) }
      end
    end

    context "start point" do
      let(:start_point) { :C5 }
      it { should eq([[4, 2], [5, 2]]) }
    end
  end
end
