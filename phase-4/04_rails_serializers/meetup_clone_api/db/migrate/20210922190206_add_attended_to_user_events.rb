class AddAttendedToUserEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :user_events, :attended, :boolean
  end
end
