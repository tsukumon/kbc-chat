module MarkdownHelper
    require 'rouge/plugins/redcarpet'
    
    class HTML < Redcarpet::Render::HTML
      include Rouge::Plugins::Redcarpet
    end
  
    def markdown(text)
      render_options = {
        filter_html:         true, # ユーザーが入力したhtmlを出力しない
        hard_wrap:           true, # 改行をhtmlの<br>に置き換え
        space_after_headers: true  # ヘッダー記号(#)と文字の間にスペース必要
      }
      renderer = HTML.new(render_options)
  
      extensions = {
        autolink:           true, # 自動でリンク化
        fenced_code_blocks: true, # コードを表す「```」を認識
        no_intra_emphasis:  true, # 文字の強調を無視
        strikethrough:      true, # 取り消し線を表す「~~」を認識
        superscript:        true, # 上つき文字を表す「^」を認識
        tables:             true, # テーブルを認識
        escape_html:        true, # xss対策 全てのHTMLタグをエスケープ(filter_htmlより優先) 
        quote:              true  # xss対策 引用符を表す「""」を認識
      }
      Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
    end
end