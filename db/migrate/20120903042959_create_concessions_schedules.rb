class CreateConcessionsSchedules < ActiveRecord::Migration
  def change
    create_table :concessions_schedules do |t|
      t.string :version

      t.timestamps
    end
  end
end
