class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :content, null: false
      t.inet :author_ip, null: false
      t.float :rate, null: false, default: 0
      t.timestamps
    end
    add_index :posts, :author_ip
    add_index :posts, :rate
  end
end
