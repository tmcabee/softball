class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :version

      t.timestamps
    end
  end
end
