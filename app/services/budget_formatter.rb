class BudgetFormatter

  attr_accessor :budget_string, :match_data

  def initialize(budget_string)
    @budget_string = budget_string
    @match_data
    format_budget
  end

  def format_budget
    @match_groups = get_match_groups
    # use recursion to go through match groups and take actions based on them
    # set notices/errors if need be
  end

  # Produces 8 match groups. For example, 'US$1,644,736 (est.)' produces: (1)(,)(644)(,)(736)()()()
  # Another example: '$5-7.3 million [ 2 ] [ 3 ]' produces: (5)(-)(7)()()(.)(3)(million)
  def get_match_groups
    regex_cond = /\$(\d+)([(\.\,\-])?(\d*)([\,\-])?(\d*)([\,\.])?(\d*)\s?(million)?/
    @budget_string.match(regex_cond)
  end
end
