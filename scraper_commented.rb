require 'open-uri'
require 'nokogiri'

# TODO: scraper code here
def imdb_top_movie_urls
  url = "https://www.imdb.com/chart/top"
  html_string = open(url).read
  doc = Nokogiri::HTML(html_string)
  movie_link_elements = doc.search('.lister-list .titleColumn a').first(5)
  movie_link_elements.map do |element|
    "http://www.imdb.com#{element.attr("href")}"
  end
end

def fetch_movie_info(movie_url)
  html_string = open(movie_url).read
  doc = Nokogiri::HTML(html_string)

  # We noticed that title and year we're together in the h1,
  # so we built a regex to extract them
  title_year_pattern = /(?<title>.*).\((?<year>\d{4})/
  title_with_year = doc.at("h1").text
  title_year_data = title_with_year.match(title_year_pattern)

  # From the regex match data we could get title and year apart
  title = title_year_data[:title]
  year = title_year_data[:year]

  # We noticed that all the other elements were divs inside a .plot_summary item
  # So we selecter all for of them first
  plot_sumary_divs = doc.search(".plot_summary div")

  # The first one was the storyline, and that was easy to extract text from
  storyline =  plot_sumary_divs.first.text.strip

  # The seccond one was the director, but we had to target the 'a' tag from it
  # first in order to get the directo name
  director = plot_sumary_divs[1].at("a").text

  # The stars were in the last element, and we noticed that only the first 3
  # links there were relevant, so we limited to #first(3)
  star_elements = plot_sumary_divs.last.search("a").first(3)
  # Because we didn't want the elements themselves, but their text, we mapped
  # to get the text of each of them
  stars = star_elements.map { |element| element.text }

  # After selecting and separating into variables all we wanted, we can finally
  # return a hash with the movie information
  return {
    title: title,
    year: year,
    storyline: storyline,
    director: director,
    stars: stars
  }
end
