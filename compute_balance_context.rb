require './context_accessor'
require './accountant_role'
require './user'

class ComputeBalanceContext
  attr_reader :accountant, :made_payments, :received_payments
  include ContextAccessor

  def self.execute(user_id)
    ComputeBalanceContext.new(user_id).execute
  end

  def initialize(user_id)
    @accountant = User.find(user_id).extend AccountantRole
    @made_payments = @accountant.payments
    @received_payments = Payment.where('user_id != ?', @accountant.id)
  end

  def execute
    execute_in_context do
      debtors = accountant.compute_debtors
      creditors = accountant.compute_creditors
      balance = debtors.merge(creditors).inject({}){|h, (k,v)| h.merge( k => 0 )}
      balance = balance.merge(debtors).merge(creditors) {|user, deb, cred| deb - cred }
      balance.each {|k,v| puts "user: #{k} amount: #{v}"}
    end
  end
end
