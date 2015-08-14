class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.string :abbreviation
      t.string :key
      t.integer :number_of_teams
      
      t.timestamps
    end
  end
end
