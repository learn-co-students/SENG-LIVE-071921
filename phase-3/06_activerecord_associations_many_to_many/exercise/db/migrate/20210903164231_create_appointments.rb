class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.datetime :time
      t.string :purpose
      t.string :notes
      t.boolean :canceled
    end
  end
end
