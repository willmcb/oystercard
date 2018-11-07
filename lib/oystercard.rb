class Oystercard
  attr_reader :balance

  MAX_LIMIT = 90

  def initialize
    @balance = 0
    @journey = false
  end

  def top_up(amount)
    max_reached = @balance + amount > MAX_LIMIT
    error_message = "Error: card limit is #{MAX_LIMIT}"
    max_reached ? (raise error_message) : @balance += amount
  end

  def deduct(amount)
    if @balance - amount < 0
      raise("balance cannot be negative")
    else
      @balance -= amount
    end
  end

  def in_journey?
    @journey
  end

  def touch_in
    if @journey
      raise "Card already touched in!"
    else
      @journey = true
    end
  end

  def touch_out
    if !@journey
      raise "Card not touched in!"
    else
      @journey = false
    end
  end
end
