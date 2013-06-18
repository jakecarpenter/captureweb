class CreateCaptures < ActiveRecord::Migration
  def change
    create_table :captures do |t|
      t.string :name
      t.datetime :startTime
      t.datetime :endTime
      t.integer :creator
      t.string :description
      t.integer :visibility

      t.timestamps
    end
  end
end
