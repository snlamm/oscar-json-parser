class WinnerFilm

  attr_accessor :film_info, :data_map
  def initialize(film_info)
    @film_info = film_info
    @data_map = {}
    parse_data
  end

  def parse_data
    # add the oscar year to data_map
    # get raw json from the film link
    #  add film title to data_map
    # add release year to data_map
    # add budget to data_map
  end


end
