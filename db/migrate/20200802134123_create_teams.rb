class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :nationality
      t.string :driver_id
      t.string :car_id
      t.string :user_id

      t.timestamps
    end
  end
end
