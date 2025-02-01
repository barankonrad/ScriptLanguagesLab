require 'nokogiri'
require 'open-uri'
require 'uri'
require 'mongo'

url = "https://amazon.pl"
keyword = "rower"

mongo_client = Mongo::Client.new(['localhost:8888'], database: 'db')
collection = mongo_client.database.collection(keyword)

def get_querying_endpoint(base_url, to_find)
  encoded_object_to_find = URI.encode_www_form_component(to_find)
  "#{base_url}/s?k=#{encoded_object_to_find}"
end

def read_mocking_real_user(querying_endpoint)
  URI.open(querying_endpoint,
           "User-Agent" => "Mozilla/12.0 Chrome/90.0")
     .read
end

def extract_description(url, link)
  unless !link || link.empty?
    link = url + link
    product_subpage = Nokogiri::HTML(read_mocking_real_user(link))
    product_subpage.css('#productDescription').text.strip
  end
end

querying_endpoint = get_querying_endpoint(url, keyword)
html_content = read_mocking_real_user(querying_endpoint)
doc = Nokogiri::HTML(html_content)

products = doc.css('div.s-result-item')
products.each do |product|
  name = product.css('h2 span').text.strip
  price = product.css('.a-price .a-offscreen').text.strip
  price = price.gsub(/zł.*/, 'zł') if price
  link = product.css('a.s-no-outline').attribute('href')&.value
  description = extract_description(url, link)

  document = {}

  document[:name] = name if name && !name.empty?
  document[:price] = price if price && !price.empty?
  document[:link] = url + link if link && !link.empty?
  document[:description] = description if description && !description.empty?

  puts "Record '#{name}' collected..."
  collection.insert_one(document) if document[:name] && document[:link]
  sleep(1)
end