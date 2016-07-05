class BudgetFormatter

  attr_accessor :budget_string, :match_data

  def initialize(budget_string)
    @budget_string = budget_string
    @match_data
    format_budget
  end

  def format_budget
    @match_groups = get_match_groups
    recursive_formatter(1, nil)
    # set notices/errors if need be
  end

  # Produces 8 match groups. For example, 'US$1,644,736 (est.)' produces: (1)(,)(644)(,)(736)()()()
  # Another example: '$5-7.3 million [ 2 ] [ 3 ]' produces: (5)(-)(7)()()(.)(3)(million)
  def get_match_groups
    regex_cond = /\$(\d+)([(\.\,\-])?(\d*)([\,\-])?(\d*)([\,\.])?(\d*)\s?(million)?/
    @budget_string.match(regex_cond)
  end

  def recursive_formatter(counter, current_sign)
    return if counter > 8
    current_match = @match_groups[counter]
    # if the current_match is a num, take a certain action
    # else, take a different action
    counter += 1
    recursive_formatter(counter, current_sign)
  end

end
