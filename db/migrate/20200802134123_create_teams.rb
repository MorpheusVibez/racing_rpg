class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :nationality
      t.integer :driver_id
      t.integer :car_id
      t.integer :user_id

      t.timestamps
    end
  end
end
