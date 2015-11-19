require 'active_record'
require './db_schema'

class Settlement < ActiveRecord::Base
  belongs_to :user, inverse_of: :provided_settlements, required: true
  belongs_to :creditor, :class_name => 'User', inverse_of: :received_settlements, required: true
end
