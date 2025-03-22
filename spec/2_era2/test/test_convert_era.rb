require_relative "../lib/convert_era"

describe ConvertEra do
    subject(:convert_era) { described_class.new }
  
    describe "#西暦が1つあるとき、年号を返す" do
        it {
            $stdin = StringIO.new("1989/1/7\n")
            $stdout = StringIO.new

            convert_era.convert

            output = $stdout.string
            expect(output).to eq "昭和64年\n"

            $stdin = STDIN
            $stdout = StringIO.new
        }
    end

    describe "#西暦が2つあるとき、年号を2つ返す" do
        it {
            $stdin = StringIO.new("1989/1/7\n1989/1/8")
            $stdout = StringIO.new

            convert_era.convert

            output = $stdout.string
            expect(output).to eq "昭和64年\n平成元年\n"

            $stdin = STDIN
            $stdout = StringIO.new
        }
    end

    describe "#例外が1つあるとき、errorを返す" do
        it {
            $stdin = StringIO.new("1900/1/1")
            $stdout = StringIO.new

            convert_era.convert

            output = $stdout.string
            expect(output).to eq "error\n"

            $stdin = STDIN
            $stdout = StringIO.new
        }
    end

    describe "#例外が2つあるとき、errorとerrorを返す" do
        it {
            $stdin = StringIO.new("1900/1/1\n\n\n")
            $stdout = StringIO.new

            convert_era.convert

            output = $stdout.string
            expect(output).to eq "error\nerror\n"

            $stdin = STDIN
            $stdout = StringIO.new
        }
    end
    
    describe "#改行/西暦/例外/改行がある場合、errorと年号とerrorとerrorを返す" do
        it {
            $stdin = StringIO.new("\n2025/3/22\n1000/1/1\n\n\n")
            $stdout = StringIO.new

            convert_era.convert

            output = $stdout.string
            expect(output).to eq "error\n令和7年\nerror\nerror\n"

            $stdin = STDIN
            $stdout = StringIO.new
        }
    end

    describe "#例外/改行/西暦/例外がある場合、errorとerrorと年号とerrorを返す" do
        it {
            $stdin = StringIO.new("0/0/0\n\n1989/1/7\n\n\n")
            $stdout = StringIO.new

            convert_era.convert

            output = $stdout.string
            expect(output).to eq "error\nerror\n昭和64年\nerror\n"

            $stdin = STDIN
            $stdout = StringIO.new
        }
    end

    describe "#西暦/例外/改行/西暦がある場合、西暦とerrorとerrorと西暦を返す" do
        it {
            $stdin = StringIO.new("2025/3/22\n1234/5/6\n\n2020/1/1\n")
            $stdout = StringIO.new

            convert_era.convert

            output = $stdout.string
            expect(output).to eq "令和7年\nerror\nerror\n令和2年\n"

            $stdin = STDIN
            $stdout = StringIO.new
        }
    end
end