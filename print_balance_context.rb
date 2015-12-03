require './context_accessor'
require './payer_role'
require './payee_role'
require './user'
require './payment'

class PrintBalanceContext
  attr_reader :participant, :paid_expenses, :received_payments
  include ContextAccessor

  def self.execute(user_id)
    PrintBalanceContext.new(user_id).execute
  end

  def initialize(user_id)
    @participant = ((User.find(user_id).extend PayerRole).extend PayeeRole).extend RegistrarRole
    @paid_expenses = @participant.payments
    @received_payments = Payment.where('user_id != ?', @participant.id)
  end

  def execute
    execute_in_context do
      @participant.print_balance
    end
  end
end
