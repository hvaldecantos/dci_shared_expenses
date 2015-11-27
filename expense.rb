require 'active_record'
require './db_schema'

class Expense < ActiveRecord::Base
  has_many :shares, inverse_of: :expense
end
