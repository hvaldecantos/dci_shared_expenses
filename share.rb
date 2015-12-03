require 'active_record'
require './db_schema'

class Share < ActiveRecord::Base
  belongs_to :user, inverse_of: :shares, required: true
  belongs_to :expense, inverse_of: :shares, required: true
end
