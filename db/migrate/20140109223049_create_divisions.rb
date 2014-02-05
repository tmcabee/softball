class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.string :abbreviation
      t.string :key
      t.integer :play_up_id
      t.integer :play_up_from_id
      t.integer :number_of_teams
      
      t.timestamps
    end
  end
end
