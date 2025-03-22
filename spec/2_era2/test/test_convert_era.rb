require_relative "../../../2_era/lib/era"

describe Era do
    subject(:era) { described_class.new }
  
    describe "#era" do
        it { expect(era.calc(2025, 3, 22)).to eq "令和7年" }
        it { expect(era.calc(2019, 5, 1)).to eq "令和元年" }
        it { expect(era.calc(1989, 1, 8)).to eq "平成元年" }
        it { expect(era.calc(1989, 1, 7)).to eq "昭和64年" }
        it { expect(era.calc(1926, 12, 25)).to eq "昭和元年" }
        it { expect{era.calc(1926, 12, 24)}.to raise_error(ArgumentError) }
    end
end