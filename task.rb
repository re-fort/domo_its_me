require './scrape.rb'
require './tweet.rb'

$file_path = './img/save.jpg'
word = Scrape.new.scrape_wikipedia
Tweet.new(word).tweet