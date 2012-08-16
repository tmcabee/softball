class CreatePracticeSchedules < ActiveRecord::Migration
  def change
    create_table :practice_schedules do |t|
      t.string :version

      t.timestamps
    end
  end
end
