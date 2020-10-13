# Top 5 movies URLs
# http://www.imdb.com/title/tt0111161/
# http://www.imdb.com/title/tt0068646/
# http://www.imdb.com/title/tt0071562/
# http://www.imdb.com/title/tt0468569/
# http://www.imdb.com/title/tt0050083/

require_relative "../scraper"

describe "#imdb_top_movie_urls" do
  it "returns an array of the top 5 movie urls" do
    expect = [
      "http://www.imdb.com/title/tt0111161/",
      "http://www.imdb.com/title/tt0068646/",
      "http://www.imdb.com/title/tt0071562/",
      "http://www.imdb.com/title/tt0468569/",
      "http://www.imdb.com/title/tt0050083/",
    ]
    expect(imdb_top_movie_urls).to eq(expect)
  end
end

