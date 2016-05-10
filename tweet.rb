require 'rubygems'
require 'bundler'
require 'open-uri'

Bundler.require
Dotenv.load

class Tweet
  @@url = 'http://ja.wikipedia.org/wiki/'
  @@file_path = './img/save.jpg'
  @@word = 'どうも、$1です。'

  def initialize(word)
    @word = word
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key       = ENV['CONSUMER_KEY']
      config.consumer_secret    = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN_KEY']
      config.access_token_secret = ENV['ACCESS_SECRET']
    end
  end

  def tweet
    update_profile
    update_profile_image
    update
  end

  def update
    begin
      @client.update(@@word.gsub('$1', @word))
    rescue => e
      STDERR.puts "error => " + e.to_s
    end
  end

  def update_profile
    begin
      @client.update_profile(url: URI.escape(@@url + @word))
    rescue => e
      STDERR.puts "error => " + e.to_s
    end
  end

  def update_profile_image
    begin
      @client.update_profile_image(open($file_path))
    rescue => e
      STDERR.puts "error => " + e.to_s
    end
  end
end