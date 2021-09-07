class CreateFeedings < ActiveRecord::Migration[6.1]
  def change
    create_table :feedings do |t|
      t.datetime :time
      t.belongs_to :dog, foreign_key: true
    end
  end
end
