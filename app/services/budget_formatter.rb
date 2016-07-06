class BudgetFormatter

  attr_accessor :budget_string, :match_groups, :budget_num, :budget

  def initialize(budget_string)
    @budget_string = budget_string
    @match_groups
    @budget_num = []
    @budget
    format_budget unless !@budget_string
  end

  def format_budget
    @match_groups = get_match_groups
    recursive_formatter(1, nil)
    @budget_num.count == 2 ? @budget = average_number : @budget = @budget_num[0]
  end

  # Produces 8 match groups. For example, 'US$1,644,736 (est.)' produces: (1)(,)(644)(,)(736)()()()
  # Another example: '$5-7.3 million [ 2 ] [ 3 ]' produces: (5)(-)(7)()()(.)(3)(million)
  def get_match_groups
    regex_cond = /(\d+)([(\.\,\-\–])?(\d*)([\,\-])?(\d*)([\,\.])?(\d*)\s?(million)?/
    @budget_string.gsub!(/\ /, " ")
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
      handle_dash(current_match)
    when "–"
      handle_dash(current_match)
    when "million"
      @budget_num[num] *= 1000000 unless greater_than_mil?(@budget_num[num])
    end
  end

  def handle_dash(current_match)
    @budget_num[0] *= 1000000 unless greater_than_mil?(@budget_num[0])
    @budget_num[1] = (current_match.to_i) * 1000000
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

  def average_number
    (@budget_num[0] + @budget_num[1]) / 2
  end

end
