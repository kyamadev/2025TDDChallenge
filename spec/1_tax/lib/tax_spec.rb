require_relative "../../../1_tax/lib/tax"

describe Tax do
    subject(:tax) { described_class.new }
  
    describe "#calc" do
            it { expect(tax.calc([10, 12])).to eq 24 }
            it { expect(tax.calc([40, 16])).to eq 62 }
            it { expect(tax.calc([100, 45])).to eq 160 }
            it { expect(tax.calc([50, 50, 55])).to eq 171 }
            it { expect(tax.calc([])).to eq 0 }
    end
end