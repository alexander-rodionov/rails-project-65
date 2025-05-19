# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false
      t.boolean :admin, null: false, default: false

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
