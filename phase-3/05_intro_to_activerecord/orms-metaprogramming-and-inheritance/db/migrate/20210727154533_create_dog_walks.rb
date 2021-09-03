class CreateDogWalks < ActiveRecord::Migration[5.2]
  def change
    create_table :dog_walks do |t|
      t.boolean :number_two
      t.references :dog, foreign_key: true, null: false
      t.references :walk, foreign_key: true, null: false
    end
  end
end
