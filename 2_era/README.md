# 課題2： 元号
**コード生成系AIは使わずに実装してください！**

以下のクラスに対して年月日を与えると元号の文字列に変換するロジックを書いてください。
以下の条件を設定します。

```rb
class Era
  # 元号変換ロジック
  #
  # @param year [Integer] 西暦
  # @param month [Integer] 月(1〜12)
  # @param day [Integer] 日(1〜31)
  # @return [String] 元号変換後の文字列 ex) "平成10年"
  def calc(year, month, day)
    
    # TODO: 元号変換ロジックを書く
  end
end
```

- 元号と西暦の変換についてはこちらを参考にしてください
  - https://ja.wikipedia.org/wiki/%E5%85%83%E5%8F%B7%E3%81%8B%E3%82%89%E8%A5%BF%E6%9A%A6%E3%81%B8%E3%81%AE%E5%A4%89%E6%8F%9B%E8%A1%A8
- 1926/12/25(昭和元年) 以降の年月日を変換する
  - 1926/12/24以前についてはArgumentError例外をraiseしてください
  - 令和が終わる年はまだわからないので、未来の年については加算してください。  
  (例: 西暦2100年は「令和82年」と出力する)
- 元号の1年目は元年と出力してください(平成元年、昭和元年、令和元年)
- 2年目以降については半角数字で出力してください(平成2年、昭和2年)
- 不正な日付は来ないものとする ex) 2/31などの存在しない日付

RubyではTimeクラスがあるので、このクラスで大小比較すると良さそうです。
```rb
Time.new(2000, 1, 1) < Time.new(1999, 12, 31) # => false
Time.new(2000, 1, 1) > Time.new(1999, 12, 31) # => true
Time.new(2000, 1, 1) == Time.new(2000, 1, 1) # => true
```
