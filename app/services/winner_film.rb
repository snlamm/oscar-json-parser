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
    @raw_json, @film_info = nil, nil
  end

  def get_oscar_year
    unformatted_year = @film_info[:year]
    oscar_year = unformatted_year.match(/\d{4}/)[0]
    oscar_range = "#{oscar_year} - #{oscar_year.to_i + 1}"
    @data_map[:oscar_year] = oscar_range
  end

  def extract_link_json
    url = @film_info[:film_url]
    @raw_json = WinnerDataGrabber.new(url).returned_data
  end

  def get_title
    title = @raw_json["Title"]
    parsed_title = title.split("  ").first
    @data_map[:title] = parsed_title
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

  def set_notice(formatter)
    result = formatter.budget_num
    if result.count == 2
      @notice = "The budget was a range between #{result[0]} and #{result[1]}. The number presented, which is the average, is also used to calculate total average film budget"
    end
    if @data_map[:budget] == nil
      @notice = "No budget data was found. This film will not be counted toward the total average film budget"
    end
  end


end
