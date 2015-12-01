require './context_accessor'
require './payer_role'
require './payee_role'
require './user'

class PrintBalanceContext
  attr_reader :payer, :paid_expenses, :payee, :received_payments
  include ContextAccessor

  def self.execute(user_id)
    PrintBalanceContext.new(user_id).execute
  end

  def initialize(user_id)
    @payer = User.find(user_id).extend PayerRole
    @paid_expenses = @payer.paid_expenses
    @payee = payer.extend PayeeRole
    @received_payments = Expense.where('user_id != ?', @payee.id)
  end

  def execute
    execute_in_context do
      debtors = payer.compute_debtors
      creditors = payee.compute_creditors
      balance = debtors.merge(creditors).inject({}){|h, (k,v)| h.merge( k => {name: v[:name], amount: 0.0} ) }
      balance = balance.merge(debtors).merge(creditors) {|user, deb, cred| {name: deb[:name], amount: deb[:amount] - cred[:amount]} }
      puts "- Balance statement for #{payer.name}"
      balance.each {|k,v| puts "id: %-3d user: %-8s amount: %5.2f" % [k, v[:name], v[:amount]] }
    end
  end
end
