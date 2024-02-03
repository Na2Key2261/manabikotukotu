class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :learning_item
      t.integer :learning_hour
      t.text :learning_content

      t.timestamps
    end
  end
end
