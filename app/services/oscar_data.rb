class OscarData
  attr_accessor :root, :oscar_map, :winners
  def initialize(root)
    @root = root
    @oscar_map = []
    @winners = []
    build_map
  end

  def build_map
    get_winners
    # add winner's info to the oscar_map
    # get budget average info
  end

  def get_winners
    data = DataGrabber.new(@root)
    @winners << data.winners_list
  end
end
