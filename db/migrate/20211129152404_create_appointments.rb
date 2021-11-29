class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :table, null: false, foreign_key: true
      t.timestamp :start_time
      t.integer :people_amount

      t.timestamps
    end
  end
end
