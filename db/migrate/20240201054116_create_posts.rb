class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :learning_item
      t.integer :learning_hour
      t.text :learning_content
      t.references :user, foreign_key: true # user_id カラムを追加
      change_column :posts, :learning_item, :integer, using: 'CAST(learning_item AS integer)'
      t.timestamps
    end
  end
end
