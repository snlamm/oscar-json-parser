class BudgetFormatter

  attr_accessor :budget_string, :match_data

  def initialize(budget_string)
    @budget_string = budget_string
    @match_data
    @budget_num = []
    @budget
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
    if match_is_num?(current_match)
      handle_num(current_match, current_sign)
    elsif current_match.to_s != ""
      current_sign = handle_sign(current_match)
    end
    counter += 1
    recursive_formatter(counter, current_sign)
  end

  def match_is_num?(match)
    true if Float(match) rescue false
  end

  def select_budget_placement
    @budget_num[1] == nil ? 0 : 1
  end

  def handle_num(current_match, current_sign)
    num = select_budget_placement
    case current_sign
    when nil
      @budget_num[num] = current_match.to_i
    when ","
      @budget_num[num] = (@budget_num[num].to_s.concat(current_match)).to_i
    when "."
      @budget_num[num] *= 1000000 unless greater_than_mil?(@budget_num[num])
      @budget_num[num] += (current_match.to_i * 100000)
    when "-"
      @budget_num[0] *= 1000000 unless greater_than_mil?(@budget_num[0])
      @budget_num[1] = (current_match.to_i) * 1000000
    when "million"
      @budget_num[num] *= 1000000 unless greater_than_mil?(@budget_num[num])
    end
  end

  def handle_sign(current_match)
    if current_match == "million"
      @budget_num[0] *= 1000000 unless greater_than_mil?(@budget_num[0])
      @budget_num[1] *= 1000000 unless (!@budget_num[1] || greater_than_mil?(@budget_num[1]))
    else
      current_match
    end
  end

  def greater_than_mil?(num)
    num >= 1000000
  end

end
