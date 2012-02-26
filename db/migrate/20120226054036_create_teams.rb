class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :abbreviation
      t.string :name

      t.timestamps
    end
  end
end
