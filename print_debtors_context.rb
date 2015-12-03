require './context_accessor'
require './accountant_role'
require './user'
require './payment'

class PrintDebtorsContext
  attr_reader :accountant, :made_payments
  include ContextAccessor

  def self.execute(user_id)
    PrintDebtorsContext.new(user_id).execute
  end

  def initialize(user_id)
    @accountant = User.find(user_id).extend AccountantRole
    @made_payments = @accountant.payments
  end

  def execute
    execute_in_context do
      debtors = accountant.compute_debtors
      puts "- #{accountant.name} debtors:"
      debtors.each {|k,v| puts "id: %-3d user: %-8s amount: %5.2f" % [k, v[:name], v[:amount]] }
    end
  end
end
