require './context_accessor'
require './accountant_role'
require './user'

class DisplayDebtorsContext
  attr_reader :accountant, :payments_made
  include ContextAccessor

  def self.execute(user_id)
    DisplayDebtorsContext.new(user_id).execute
  end

  def initialize(user_id)
    @accountant = User.find(user_id).extend AccountantRole
    @payments_made = @accountant.payments
  end

  def execute
    execute_in_context do
      debtors = accountant.compute_debtors
      debtors.each {|k,v| puts "id: %-3d user: %-8s amount: %5.2f" % [k, v[:name], v[:amount]] }
    end
  end
end
