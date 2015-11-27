require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :name
  end

  create_table :expenses, force: true do |t|
    t.string :description
  end

  create_table :shares, force: true do |t|
    t.belongs_to :expense, index: true
    t.belongs_to :user, index: true
    t.decimal :amount, :precision => 8, :scale => 2
  end

  create_table :payments, force: true do |t|
    t.belongs_to :expense, index: true
    t.belongs_to :user, index: true
  end
end
