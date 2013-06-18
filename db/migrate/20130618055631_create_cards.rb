class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.integer :serviceId
      t.datetime :serviceTime
      t.integer :contributor
      t.integer :visibility
      t.string :title
      t.string :content

      t.timestamps
    end
  end
end
