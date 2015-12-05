require './context_accessor'
require './reporter_role'
require './user'
require './expense'

class PrintReportContext
  attr_reader :reporter, :all_expenses
  include ContextAccessor

  def self.execute(user_id)
    PrintReportContext.new(user_id).execute
  end

  def initialize(user_id)
    @reporter = User.find(user_id).extend ReporterRole
    @all_expenses = Expense.all.order('id')
  end

  def execute
    execute_in_context do
      reporter.show_report
    end
  end
end
