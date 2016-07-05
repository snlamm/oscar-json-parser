class DataGrabber

  def initialize(url)
    @url = url
    @winners_list = []
    get_winners
  end

  def get_winners
    json_data = extract_json
    binding.pry
    # select only the winning films
  end

  def extract_json
    response = RestClient.get(@url)
    JSON.parse(response)
  end
end
