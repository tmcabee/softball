class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.string :unique_id
      t.integer :practice_schedule_id
      t.integer :field_id
      t.datetime :start_time
      t.integer :team_id
      t.string :note
      t.boolean :canceled, :default => false

      t.timestamps
    end
  end
end
