class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :name
      t.boolean :is_insured
      t.string :insurance_provider
      t.date :birthday
      t.boolean :is_alive
      t.boolean :is_organ_donor
    end
  end
end
