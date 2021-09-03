class CreateDogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :age
      t.string :breed
      t.string :image_url
    end
  end
end
