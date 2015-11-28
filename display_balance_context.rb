require './context_accessor'
require './accountant_role'
require './user'

class DisplayBalanceContext
  attr_reader :accountant_registrar, :payments_made, :payments_received
  include ContextAccessor

  def self.execute(user_id)
    DisplayBalanceContext.new(user_id).execute
  end

  def initialize(user_id)
    @accountant_registrar = (User.find(user_id).extend AccountantRole).extend RegistrarRole
    @payments_made = accountant_registrar.payments
    @payments_received = Payment.where('user_id != ?', accountant_registrar.id)
  end

  def execute
    execute_in_context do
      accountant_registrar.show_balance_report
    end
  end
end
