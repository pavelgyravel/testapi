class AddReferences < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :user, foreign_key: true, null: false
    add_reference :rates, :post, foreign_key: true, null: false
  end
end
