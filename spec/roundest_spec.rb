require 'roundest'

RSpec.describe Roundest, '#roundest' do
  #context "dunno what this is" do
    it "gives one of the roundest numbers in a range" do
      r = Roundest::roundest(0.399, 0.401)
      expect(r.to_s).to eq '0.4'
      r = Roundest::roundest(4236, 4238)
      expect(r.to_s).to eq '4237'
      r = Roundest::roundest(0.00371, 0.00379)
      expect(r.to_s).to eq '0.00375'
    end
  #end
end