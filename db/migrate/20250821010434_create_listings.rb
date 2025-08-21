class CreateListings < ActiveRecord::Migration[8.0]
  def change
    create_table :listings do |t|
      t.string :title
      t.text :body
      t.date :expires_on
      t.integer :board_id

      t.timestamps
    end
  end
end
