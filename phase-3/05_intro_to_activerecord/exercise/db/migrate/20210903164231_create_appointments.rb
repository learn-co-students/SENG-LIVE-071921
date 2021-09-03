class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.string :time
      t.string :purpose
      t.string :notes
      t.boolean :canceled
      t.belongs_to :doctor, foreign_key: true
      t.belongs_to :patient, foreign_key: true
    end
  end
end
