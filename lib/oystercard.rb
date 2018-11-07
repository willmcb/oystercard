class Oystercard
  attr_accessor :balance

  MAX_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journey = false
  end

  def top_up(amount)
    max_reached = @balance + amount > MAX_LIMIT
    error_message = "Error: card limit is #{MAX_LIMIT}"
    max_reached ? (raise error_message) : @balance += amount
  end

  def in_journey?
    @journey
  end

  def touch_in
    if @journey
      raise "Card already touched in!"
    elsif balance_above_min_fare?
      raise "You have less than minimum fare: please top up!"
    else
      @journey = true
    end
  end

  def touch_out
    if !@journey
      raise "Card not touched in!"
    else
      deduct(MINIMUM_FARE)
      @journey = false
    end
  end

  private
  def balance_above_min_fare?
   @balance <= MINIMUM_FARE
  end

  def deduct(amount)
    if @balance - amount < 0
      raise("balance cannot be negative")
    else
      @balance -= amount
    end
  end
end
