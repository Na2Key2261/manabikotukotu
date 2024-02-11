class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :learning_item
      t.integer :learning_hour
      t.text :learning_content
      t.references :user, foreign_key: true # user_id カラムを追加
      
      t.timestamps
    end
  end
end
