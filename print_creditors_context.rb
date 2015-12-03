require './context_accessor'
require './user'
require './payment'
require './payee_role'
require './reporter_role'

class PrintCreditorsContext
  attr_reader :payee, :received_payments
  include ContextAccessor

  def self.execute(user_id)
    PrintCreditorsContext.new(user_id).execute
  end

  def initialize(user_id)
    @payee = User.find(user_id).extend(PayeeRole).extend(ReporterRole)
    @received_payments = Payment.where('user_id != ?', @payee.id)
  end

  def execute
    execute_in_context do
      creditors = payee.compute_creditors
      payee.print creditors, "- #{payee.name} creditors:"
    end
  end
end
