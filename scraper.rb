require 'open-uri'
require 'nokogiri'

# TODO: scraper code here
def imdb_top_movie_urls
  # Set imdb top movies url page
  url = "https://www.imdb.com/chart/top"
  # Open and read the page
  html_string = open(url).read
  # Parse it with Nokogiri
  doc = Nokogiri::HTML(html_string)
  # Search the page for the relevant link tags
  movie_link_elements = doc.search('.lister-list .titleColumn a').first(5)
  # Get the href from each of them
  movie_link_elements.map do |element|
    "http://www.imdb.com#{element.attr("href")}"
  end
end

def fetch_movie_info(movie_url)
  # Open and read the movie url
  html_string = open(movie_url).read
  # Parse the html with Nokogiri
  doc = Nokogiri::HTML(html_string)
  # Find: cast, director, storyline, title, year
  title_year_pattern = /(?<title>.*).\((?<year>\d{4})/
  title_with_year = doc.at("h1").text
  title_year_data = title_with_year.match(title_year_pattern)
  title = title_year_data[:title]
  year = title_year_data[:year]

  plot_sumary_divs = doc.search(".plot_summary div")
  storyline =  plot_sumary_divs.first.text.strip
  director = plot_sumary_divs[1].at("a").text
  star_elements = plot_sumary_divs.last.search("a").first(3)
  stars = star_elements.map { |element| element.text }

  # return the info as hash
  return {
    title: title,
    year: year,
    storyline: storyline,
    director: director,
    stars: stars
  }
end
