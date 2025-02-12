class Transfer

  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
    @duplicate_check = 0
  end

  def execute_transaction
    @duplicate_check += 1
    if  @sender.valid? && @receiver.valid? && @duplicate_check <= 1 && @sender.balance - @amount > 0
      @sender.balance -= @amount
      @receiver.balance += @amount
      self.status = "complete"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end
  
  def valid?
    if @sender.valid? && @receiver.valid?
      true
    else
      false
    end
  end

  def reverse_transfer
    if self.status == "complete"
      @sender.balance += @amount
      @receiver.balance -= @amount
      self.status = "reversed"
    else
      nil
    end
  end
end