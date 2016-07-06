class OscarData
  attr_accessor :root, :oscar_map, :winners, :budget_total, :averaging_count, :budget_average
  def initialize(root)
    @root = root
    @oscar_map = []
    @winners
    @budget_total = 0
    @averaging_count = 0
    @budget_average
    build_map
  end

  def build_map
    get_winners
    extract_winner_info
    get_budget_average
  end

  def get_winners
    data = DataGrabber.new(@root)
    @winners = data.winners_list
  end

  def extract_winner_info
    @winners.each do |winner|
      get_averaging_info(winner)
      @oscar_map << winner.data_map
    end
  end

  def get_averaging_info(winner)
    winner_budget = winner.data_map[:budget]
    if winner_budget
      @averaging_count += 1
      @budget_total += winner_budget
    end
  end

  def get_budget_average
    @budget_average = @budget_total / @averaging_count
  end
end
