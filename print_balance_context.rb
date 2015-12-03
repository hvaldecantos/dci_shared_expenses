require './context_accessor'
require './payer_role'
require './payee_role'
require './user'
require './payment'

class PrintBalanceContext
  attr_reader :payer, :paid_expenses, :payee, :received_payments
  include ContextAccessor

  def self.execute(user_id)
    PrintBalanceContext.new(user_id).execute
  end

  def initialize(user_id)
    @payer = User.find(user_id).extend PayerRole
    @payee = @payer.extend PayeeRole
    @paid_expenses = @payer.payments
    @received_payments = Payment.where('user_id != ?', @payee.id)
  end

  def execute
    execute_in_context do
      @payer.print_balance
    end
  end
end
