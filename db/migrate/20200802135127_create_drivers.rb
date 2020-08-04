class CreateDrivers < ActiveRecord::Migration[6.0]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :permanent_number
      t.string :nationality
      t.integer :total_wins
      t.integer :pole_positions
      t.integer :team_id

      t.timestamps
    end
  end
end
