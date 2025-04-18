class AddrSpec
    def check(address)
      addr_spec.match(address) ? "ok" : "ng"
    end
  
    private
  
    # メールアドレス全体のパターンを表す正規表現
    # ^ は行の先頭を表す
    # $ は行の末尾を表す
    def addr_spec
      /^(#{local_part})@(#{domain})$/
    end
  
    # メールアドレスのローカル部分を表す正規表現
    # | は「または」を表す
    def local_part
      /(#{dot_atom})|(#{quoted_string})/
    end
  
    # メールアドレスのドメイン部分を表す正規表現
    def domain
      dot_atom
    end
  
    # ドットで区切られたテキスト部分を表す正規表現
    # +　は1回以上の繰り返しを表す
    # *　は0回以上の繰り返しを表す
    # 訳: 「atext が1回以上連続し、その後に「.」と atext が1回以上連続する」部分が0回以上繰り返される
    def dot_atom
      /(#{atext})+(\.(#{atext})+)*/
    end
  
    # ドットアトム部で許可されている文字を表す正規表現
    # a-zA-Z　は英大小文字を表す
    # 0-9 は数字を表す
    # | は「または」を表す
    # %r{}　はスラッシュを多用する正規表現で読みやすくするための別の区切り文字
    def atext
      %r{([a-zA-Z])|([0-9])|!|\#|\$|%|&|'|\*|\+|-|/|=|\?|\^|_|`|\{|\}|\||~}
    end
  
    # " で囲まれた文字列を表す正規表現
    # *　は0回以上の繰り返しを表す
    # " が2個で文字列長が2以上となる
    def quoted_string
      /"(#{qcontent})*"/
    end
  
    # [ADVANCED]
    # " で囲まれたコンテンツを表す正規表現
    # | は「または」を表す
    def qcontent
      /(#{qtext})|(#{quoted_pair})/
    end
  
    # クオーテッド文字列部で許可されている文字を表す正規表現
    # a-zA-Z　は英大小文字を表す
    # 0-9 は数字を表す
    # | は「または」を表す
    # %r{}　はスラッシュを多用する正規表現で読みやすくするための別の区切り文字
    def qtext
      %r{([a-zA-Z])|([0-9])|!|\#|\$|%|&|'|\*|\+|-|/|=|\?|\^|_|`|\{|\}|\||~|\.|\(|\)|<|>|@|,|:|;|\[|\]}
    end
  
    # [ADVANCED]
    # バックスラッシュの後はバックスラッシュか " のどちらかが続くことを表す正規表現
    # \\ はバックスラッシュ自身を表す
    # \\" はバックスラッシュと " を表す
    def quoted_pair
      /\\([\\"])/
    end
  end