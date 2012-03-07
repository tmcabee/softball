class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.integer :number
      t.string :description

      t.timestamps
    end
  end
end
