require './context_accessor'
require './accountant_role'
require './user'

class AccountCreditorsContext
  attr_reader :accountant, :payments
  include ContextAccessor

  def self.execute(user_id)
    AccountCreditorsContext.new(user_id).execute
  end

  def initialize(user_id)
    @accountant = User.find(user_id).extend AccountantRole
    @payments = Payment.where('user_id != ?', @accountant.id)
  end

  def execute
    execute_in_context do
      creditors = accountant.compute_creditors
      creditors.each {|k,v| puts "user: #{k} amount: #{v}"}
    end
  end
end
