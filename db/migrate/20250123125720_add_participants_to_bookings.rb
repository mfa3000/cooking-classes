class AddParticipantsToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :participants, :integer
  end
end
