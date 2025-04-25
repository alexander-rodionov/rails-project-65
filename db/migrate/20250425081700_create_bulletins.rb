# frozen_string_literal: true

class CreateBulletins < ActiveRecord::Migration[8.0]
  def change
    create_table :bulletins do |t|
      t.string :title
      t.string :description
      t.references :category, null: false, foreign_key: true
      t.string :state
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
