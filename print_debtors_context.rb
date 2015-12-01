require './context_accessor'
require './payer_role'
require './user'

class PrintDebtorsContext
  attr_reader :payer, :paid_expenses
  include ContextAccessor

  def self.execute(user_id)
    PrintDebtorsContext.new(user_id).execute
  end

  def initialize(user_id)
    @payer = User.find(user_id).extend PayerRole
    @paid_expenses = @payer.paid_expenses
  end

  def execute
    execute_in_context do
      debtors = payer.compute_debtors
      debtors.each {|k,v| puts "id: %-3d user: %-8s amount: %5.2f" % [k, v[:name], v[:amount]] }
    end
  end
end
