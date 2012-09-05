class CreateConcessionsEvents < ActiveRecord::Migration
  def change
    create_table :concessions_events do |t|
      t.string :unique_id
      t.integer :concessions_schedule_id
      t.datetime :start_time
      t.integer :team_id
      t.boolean :canceled, :default => false

      t.timestamps
    end
  end
end
