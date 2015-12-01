require './context_accessor'
require './payee_role'
require './user'

class PrintCreditorsContext
  attr_reader :payee, :received_payments
  include ContextAccessor

  def self.execute(user_id)
    PrintCreditorsContext.new(user_id).execute
  end

  def initialize(user_id)
    @payee = User.find(user_id).extend PayeeRole
    @received_payments = Expense.where('user_id != ?', @payee.id)
  end

  def execute
    execute_in_context do
      creditors = payee.compute_creditors
      creditors.each {|k,v| puts "id: %-3d user: %-8s amount: %5.2f" % [k, v[:name], v[:amount]] }
    end
  end
end
