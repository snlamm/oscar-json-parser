class DataGrabber

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
    # iterate through each film
    # find which one is the winners
    # extract the oscar year and the film url
  end
end
