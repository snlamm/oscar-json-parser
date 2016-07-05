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
    #  add film title to data_map
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
    # make adapter to get url data
  end


end