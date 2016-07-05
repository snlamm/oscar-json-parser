class WinnerFilm

  attr_accessor :film_info, :data_map, :raw_json, :notice
  def initialize(film_info)
    @film_info = film_info
    @data_map = {}
    @raw_json
    @notice
    parse_data
  end

  def parse_data
    get_oscar_year
    extract_link_json
    get_title
    get_release_year
    get_budget
  end

  def get_oscar_year
    unformatted_year = @film_info[:year]
    oscar_year = unformatted_year.match(/\d{4}/)[0]
    @data_map[:oscar_year] = oscar_year
  end

  def extract_link_json
    url = @film_info[:film_url]
    @raw_json = WinnerDataGrabber.new(url).returned_data
  end

  def get_title
    @data_map[:title] = @raw_json["Title"]
  end

  def get_release_year
    raw_date = @raw_json[" Release dates "]
    parsed_date = raw_date.match(/\d{4}/)[0]
    @data_map[:release_year] = parsed_date
  end

  def get_budget
    formatter = BudgetFormatter.new(@raw_json["Budget"])
    @data_map[:budget] = formatter.budget
    set_notice(formatter)
  end

  def set_notice

  end


end
