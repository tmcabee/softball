class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :unique_id
      t.integer :schedule_id
      t.integer :field_id
      t.datetime :start_time
      t.integer :home_team_id
      t.integer :away_team_id
      t.boolean :canceled, :default => false

      t.timestamps
    end
  end
end
