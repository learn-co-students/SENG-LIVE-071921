class CreateThings < ActiveRecord::Migration[6.1]
  def change
    create_table :things do |t|
      t.string :name
      t.string :category
      t.belongs_to :spot, foreign_key: true
    end
  end
end
