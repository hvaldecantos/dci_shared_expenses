require './context_accessor'
require './registrar_role'
require './expense'
require './user'

class DisplayReportContext
  attr_reader :registrar, :all_payments
  include ContextAccessor

  def self.execute(user_id)
    DisplayReportContext.new(user_id).execute
  end

  def initialize(user_id)
    @registrar = User.find(user_id).extend RegistrarRole
    @all_payments = Payment.all.order('id')
  end

  def execute
    execute_in_context do
      registrar.show_report
    end
  end
end
