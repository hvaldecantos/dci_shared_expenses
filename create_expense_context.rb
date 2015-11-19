require './context_accessor'
require './registrar_role'
require './user'

class CreateExpenseContext
  attr_reader :registrar, :description, :amount
  include ContextAccessor

  def self.execute(user_id, description, amount)
    CreateExpenseContext.new(user_id, description, amount).execute
  end

  def initialize(user_id, description, amount)
    @registrar = User.find(user_id).extend RegistrarRole
    @description = description
    @amount = amount
  end

  def execute
    execute_in_context do
      registrar.create_expense
    end
  end
end
