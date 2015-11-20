require './context_accessor'
require './accountant_role'
require './user'

class AccountDebtorsContext
  attr_reader :accountant, :made_payments
  include ContextAccessor

  def self.execute(user_id)
    AccountDebtorsContext.new(user_id).execute
  end

  def initialize(user_id)
    @accountant = User.find(user_id).extend AccountantRole
    @made_payments = @accountant.payments
  end

  def execute
    execute_in_context do
      debtors = accountant.compute_debtors
      debtors.each {|k,v| puts "user: #{k} amount: #{v}"}
    end
  end
end
