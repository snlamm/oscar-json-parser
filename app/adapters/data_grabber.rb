class DataGrabber
  attr_accessor :url, :winners_list
  def initialize(url)
    @url = url
    @winners_list = []
    get_winners
  end

  def get_winners
    json_data = extract_json
    extract_winners(json_data)
  end

  def extract_json
    response = RestClient.get(@url)
    JSON.parse(response)
  end

  def extract_winners(data)
    data["results"].each do |year|
      winner_info = get_film_info(year)
      winner_film = WinnerFilm.new(winner_info)
      winners_list << winner_film
    end
  end

  def get_film_info(year)
    film_info = {}
    film_info[:year] = year["year"]
    film_info[:film_url] = find_winning_film(year)
    film_info
  end

  def find_winning_film(year)
    film_data = year["films"].detect {|film| film["Winner"]}
    film_data["Detail URL"]
  end

end
