class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :game_id
      t.integer :field_number
      t.date :date
      t.time :start_time
      t.time :end_time
      t.integer :home_team_id
      t.integer :away_team_id

      t.timestamps
    end
  end
end
