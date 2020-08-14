Hanami::Model.migration do
  change do
    add_index :posts, :rate
  end
end
