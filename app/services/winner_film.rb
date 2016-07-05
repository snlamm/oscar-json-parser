class WinnerFilm

  attr_accessor :film_info, :data_map, :raw_json
  def initialize(film_info)
    @film_info = film_info
    @data_map = {}
    @raw_json
    parse_data
  end

  def parse_data
    get_oscar_year
    extract_link_json
    get_title
    # add release year to data_map
    # add budget to data_map
  end

  def get_oscar_year
    unformatted_year = @film_info[:year]
    oscar_year = unformatted_year.match(/\d{4}/)[0]
    @data_map[:oscar_year] = oscar_year
  end

  def extract_link_json
    url = @film_info[:film_url]
    @raw_json = WinnerDataGrabber.new(url)
  end

  def get_title
    @data_map[:title] = @raw_json["Title"]
  end


end
