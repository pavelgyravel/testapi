Hanami::Model.migration do
  change do
    add_index :posts, :author_ip
  end
end
