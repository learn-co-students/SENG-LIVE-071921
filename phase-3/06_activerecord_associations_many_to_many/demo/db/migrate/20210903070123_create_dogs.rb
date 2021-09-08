class CreateDogs < ActiveRecord::Migration[6.1]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :age
      t.string :breed
      t.string :favorite_treats
      t.datetime :last_fed_at
      t.datetime :last_walked_at
    end
  end
end
