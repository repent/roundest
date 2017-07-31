require 'roundest'

RSpec.describe Roundest, '#roundest' do
  context "when given decimals" do
    it "gives one of the roundest numbers in a range" do
      r = Roundest::roundest(0.399, 0.401)
      expect(r.to_s).to eq '0.4'
    end
  end
  context "when given large numbers" do
    it "gives one of the roundest numbers in a range" do
      r = Roundest::roundest(4236, 4238)
      expect(r.to_s).to eq '4237'
    end
  end
  context "when given a range containing a number ending in 5" do
    it "gives a 'round' number ending in 5" do
      r = Roundest::roundest(0.00371, 0.00379)
      expect(r.to_s).to eq '0.00375'
    end
  end
end