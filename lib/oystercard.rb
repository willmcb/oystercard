class Oystercard
  attr_reader :balance

  MAX_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    max_reached = @balance + amount > MAX_LIMIT
    error_message = "Error: card limit is #{MAX_LIMIT}"
    max_reached ? (raise error_message) : @balance += amount
  end
end
