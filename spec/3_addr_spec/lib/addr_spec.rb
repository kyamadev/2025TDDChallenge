require_relative "../../3_addr_spec/addr_spec"

describe AddrSpec do
  subject(:addr_spec) { described_class.new }

  describe "#check" do
    shared_examples "ok" do
      it do
        addrs.each do |addr|
          expect(addr_spec.check(addr)).to eq "ok"
        end
      end
    end

    shared_examples "ng" do
      it do
        addrs.each do |addr|
          expect(addr_spec.check(addr)).to eq "ng"
        end
      end
    end

    context "正しいメールアドレスが入力されている時" do
      it_behaves_like "ok" do
        let(:addrs) do
          [
            "iijima@example.com",
            "IIJIMA!#$%&'*+-/=?^_`{|}~@EXAMPLE!#$%&'*+-/=?^_`{|}~.COM",
            "i.i.j.m.a@e.x.a.m.p.l.e.c.o.m",
            '"iijima"@example.com',
            '"!#$%&*+-/=?^_`{|}~(),.:;<>@[]"@example.com',
            '""@example.com',
            '"i\"i\"j\"i\"m\"a"@example.com',
            '"i\'i\'j\'i\'m\"a"@example.com',
            '"\'"@example.com',
            '"iijima\\\\"@example.com'
          ]
        end
      end
    end

    context "@ を含まない時" do
      it_behaves_like "ng" do
        let(:addrs) { ["iijimaexample.com"] }
      end
    end

    context "複数の @ を含む時" do
      it_behaves_like "ng" do
        let(:addrs) { ["iijima@@example.com"] }
      end
    end

    context "ドメイン部" do
      context "許可されない文字（大小英数文字と一部の記号 !#$%&'*+-/=?^_`{|}~ と . 以外）を含む時" do
        it_behaves_like "ng" do
          let(:addrs) { ["iijima@🥺example.com", "iijima@テスト.com", "iijima@(example).com.", "iijima@example[:,;].com"] }
        end
      end

      describe ". で始まる時" do
        it_behaves_like "ng" do
          let(:addrs) { ["iijima@.example.com"] }
        end
      end

      describe ". で終わる時" do
        it_behaves_like "ng" do
          let(:addrs) { ["iijima@example.com."] }
        end
      end

      describe "連続した . を含む時" do
        it_behaves_like "ng" do
          let(:addrs) { ["iijima@example..com"] }
        end
      end

      describe "空文字の時" do
        it_behaves_like "ng" do
          let(:addrs) { ["iijima@"] }
        end
      end
    end

    context "ローカル部（ドットアトム部）" do
      context "許可されない文字（大小英数文字と一部の記号 !#$%&'*+-/=?^_`{|}~ と . 以外）を含む時" do
        it_behaves_like "ng" do
          let(:addrs) { ["🥺@example.com", "飯島@example.com", "(iijima)@example.com.", "[:,;]@example.com"] }
        end
      end

      describe ". で始まる時" do
        it_behaves_like "ng" do
          let(:addrs) { [".iijima@example.com"] }
        end
      end

      describe ". で終わる時" do
        it_behaves_like "ng" do
          let(:addrs) { ["iijima.@example.com"] }
        end
      end

      describe "連続した . を含む時" do
        it_behaves_like "ng" do
          let(:addrs) { ["iijima..@examplecom"] }
        end
      end

      describe "空文字の時" do
        it_behaves_like "ng" do
          let(:addrs) { ["@examplecom"] }
        end
      end
    end

    context "ローカル部（クオーテッド文字列部）" do
      context '" で始まらない時' do
        it_behaves_like "ng" do
          let(:addrs) { ['iijima""@example.com'] }
        end
      end

      context '" で終わらない時' do
        it_behaves_like "ng" do
          let(:addrs) { ['""iijima@example.com'] }
        end
      end

      context '許可されない文字（大小英数文字と一部の記号 !#$%&\'*+-/=?^_`{|}~(),.:;<>@[]"\ 以外）を含む時' do
        it_behaves_like "ng" do
          let(:addrs) { ["🥺@example.com", "飯島@example.com"] }
        end
      end

      context "文字列長が2未満の時" do
        it_behaves_like "ng" do
          let(:addrs) { ['"@example.com'] }
        end
      end

      context '" がエスケープされていない時' do
        it_behaves_like "ng" do
          let(:addrs) { ['"i"i"j"i"m"a"@example.com'] }
        end
      end

      context '\ がエスケープされていない時' do
        it_behaves_like "ng" do
          let(:addrs) { ['"i\i\j\i\m\a"@example.com'] }
        end
      end
    end
  end
end