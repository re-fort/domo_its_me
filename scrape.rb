require 'rubygems'
require 'bundler'
require 'open-uri'

Bundler.require

class Scrape
  @@url = 'https://ja.wikipedia.org/wiki/Special:Randompage'

  def scrape_wikipedia
    charset = nil

    html = open(@@url) do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)
    @word = doc.title.split(" - ")[0] || ''
    p @word

    search_google

    @word
  end

  def search_google
    url = 'https://www.google.co.jp/search?q=' + @word + '&source=lnms&tbm=isch'
    url_escape = URI.escape(url)
    charset = nil

    html = open(url_escape) do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)
  
    doc.search("img").each do |img|
      @image_url = img['src']
      p @image_url
      break
    end

    save_image
  end

  def save_image
	  open($file_path, 'wb') do |output|
      open(@image_url) do |data|
        output.write(data.read)
      end
    end
  end

end