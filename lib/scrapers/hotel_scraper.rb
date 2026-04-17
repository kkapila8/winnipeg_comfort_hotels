# Feature 1.7 - Web scraping script using Nokogiri and HTTParty
# Scrapes hotel room data from Books to Scrape (a legal scraping practice site)
# and maps it to our hotel room categories

require 'httparty'
require 'nokogiri'

class HotelScraper
  BASE_URL = 'http://books.toscrape.com'

  CATEGORY_MAP = {
    0 => 'Standard',
    1 => 'Deluxe',
    2 => 'Suite',
    3 => 'Business'
  }.freeze

  HOTEL_MAP = {
    0 => 'Winnipeg Comfort Downtown',
    1 => 'Winnipeg Comfort Polo Park',
    2 => 'Winnipeg Comfort The Forks'
  }.freeze

  def self.scrape
    puts 'Starting web scrape from books.toscrape.com...'
    rooms = []
    page = 1

    while rooms.length < 20
      url = page == 1 ? "#{BASE_URL}/catalogue/page-1.html" : "#{BASE_URL}/catalogue/page-#{page}.html"
      response = HTTParty.get(url)
      doc = Nokogiri::HTML(response.body)

      doc.css('article.product_pod').each do |item|
        next if rooms.length >= 20

        title = item.css('h3 a').attr('title').value
        price_text = item.css('.price_color').text.strip
        price = price_text.gsub(/[^0-9.]/, '').to_f
        price = (price * 1.5).round(2) # convert to CAD hotel pricing
        price = [price, 49.99].max # minimum price $49.99

        rating_class = item.css('.star-rating').attr('class').value
        rating = rating_class.split.last

        on_sale = rating == 'One' || rating == 'Two'
        sale_price = on_sale ? (price * 0.85).round(2) : nil

        category_index = rooms.length % 4
        hotel_index = rooms.length % 3

        rooms << {
          name: "#{HOTEL_MAP[hotel_index].split.last} #{title.truncate(30)}",
          hotel_name: HOTEL_MAP[hotel_index],
          category: CATEGORY_MAP[category_index],
          price: price,
          sale_price: sale_price,
          on_sale: on_sale,
          capacity: rand(1..6),
          description: "Scraped room data: #{title}. A comfortable room at our #{HOTEL_MAP[hotel_index]} location with premium amenities and excellent service.",
          amenities: 'Free WiFi, TV, Coffee Maker, Daily Housekeeping'
        }
      end

      page += 1
    end

    puts "Scraped #{rooms.length} rooms successfully!"
    rooms
  end
end