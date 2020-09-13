class ChangeAuthorIpColumnType < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :author_ip, :string
  end
end
