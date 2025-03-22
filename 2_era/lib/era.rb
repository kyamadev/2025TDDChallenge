class Era
    # 元号変換ロジック
    #
    # @param year [Integer] #西暦
    # @param month [Integer] #月(1〜12)
    # @param day [Integer] #日(1〜31)
    # @return [String] 元号変換後の文字列 ex) "平成10年"
    def calc(year, month, day)
        if Time.new(2019, 5, 1) <= Time.new(year, month, day)
            return year == 2019 ? "令和元年" : "令和#{year - 2018}年"
        elsif Time.new(1989, 1, 8) <= Time.new(year, month, day)
            return year == 1989 ? "平成元年" : "平成#{year - 1988}年"
        elsif Time.new(1926, 12, 25) <= Time.new(year, month, day)
            return year == 1926 ? "昭和元年" : "昭和#{year - 1925}年"
        else raise ArgumentError
        end
    end
end
