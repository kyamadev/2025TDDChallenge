require_relative "addr_spec"

class ValidateAddrSpec
  def output(input, output)
    addr_spec = AddrSpec.new
    input.read.chomp.split("\n", -1).each do |line|
      output.puts addr_spec.check(line)
    rescue
      output.puts "error"
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  @con = ValidateAddrSpec.new
  @con.output($stdin, $stdout)
end