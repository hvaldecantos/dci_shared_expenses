require './context_accessor'
require './accountant_role'
require './user'
require './payment'

class PrintBalanceContext
  attr_reader :accountant, :made_payments, :received_payments
  include ContextAccessor

  def self.execute(user_id)
    PrintBalanceContext.new(user_id).execute
  end

  def initialize(user_id)
    @accountant = User.find(user_id).extend AccountantRole
    @made_payments = @accountant.payments
    @received_payments = Payment.where('user_id != ?', @accountant.id)
  end

  def execute
    execute_in_context do
      accountant.print_balance
    end
  end
end
