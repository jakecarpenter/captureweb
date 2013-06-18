class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :contributor
      t.string :content
      t.references :card

      t.timestamps
    end
    add_index :comments, :card_id
  end
end
