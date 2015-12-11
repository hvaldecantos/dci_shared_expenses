require 'minitest/autorun'
require './split_expense_context'
require './share'

describe "Split expense context" do
  it "should split an expense equally" do
    adele = User.create name: "Adele"
    dan = User.create name: "Dan"
    alan = User.create name: "Alan"

    expense = Expense.create description: "an expense"
    participants = [adele, dan, alan]
    SplitExpenseContext::execute expense.id, [adele.id, dan.id, alan.id], 10.0

    all_shares = Share.all
    all_shares.each_with_index do |s, i|
      s.amount.must_equal 3.33
      s.user.must_equal participants[i]
    end

  end
end
