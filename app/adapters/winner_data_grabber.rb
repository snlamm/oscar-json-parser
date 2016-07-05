class WinnerDataGrabber
  attr_accessor :url, :returned_data
  def initialize(url)
    @url = url
    @returned_data
    get_data
  end

  def get_data
    json_data = extract_json
  end

  def extract_json
    response = RestClient.get(@url)
    @returned_data = JSON.parse(response)
  end
end
