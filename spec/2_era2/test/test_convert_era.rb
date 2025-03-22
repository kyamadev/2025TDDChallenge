require_relative "../lib/convert_era"

describe ConvertEra do
    subject(:convert_era) { described_class.new }
  
    describe "#test convert_era" do
        it {
            $stdin = StringIO.new("1989/1/7")
            $stdout = StringIO.new

            convert_era.convert

            output = $stdout.string
            expect(output).to eq "昭和64年\n"

            $stdin = STDIN
            $stdout = StringIO.new
        }
    end

end