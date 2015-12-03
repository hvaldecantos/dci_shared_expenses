require './context_accessor'
require './payer_role'
require './reporter_role'
require './user'

class PrintDebtorsContext
  attr_reader :payer, :paid_expenses
  include ContextAccessor

  def self.execute(user_id)
    PrintDebtorsContext.new(user_id).execute
  end

  def initialize(user_id)
    @payer = User.find(user_id).extend(PayerRole).extend(ReporterRole)
    @paid_expenses = @payer.payments
  end

  def execute
    execute_in_context do
      debtors = payer.compute_debtors
      payer.print debtors, "- #{payer.name} debtors:"
    end
  end
end
