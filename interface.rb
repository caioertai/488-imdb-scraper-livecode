require "yaml"
require_relative "scraper"

top_movie_urls = imdb_top_movie_urls

movie_infos = top_movie_urls.map do |url|
  puts "Scraping #{url}..."
  fetch_movie_info(url)
end

puts "Writing yaml..."
File.open("movies.yml", "w") do |file|
  file << YAML.dump(movie_infos)
end
