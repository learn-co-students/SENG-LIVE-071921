class CreateDoctors < ActiveRecord::Migration[6.1]
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :specialization
      t.string :hospital
      t.boolean :gives_lollipop
    end
  end
end
