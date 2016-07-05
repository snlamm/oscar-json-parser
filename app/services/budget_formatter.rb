class BudgetFormatter
  attr_accessor :budget_string

  def initialize(budget_string)
    @budget_string = budget_string
    format_budget
  end

  def format_budget
    # use regex to parse budget string and extract match groups
    # use recursion to go through match groups and take actions based on them
    # set notices/errors if need be
  end
end
