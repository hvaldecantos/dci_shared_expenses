require './create_expense_context'

User.new(name: "Adele").save
CreateExpenseContext::execute 1, "Rent", 1300.25

p User.all
p Expense.all
