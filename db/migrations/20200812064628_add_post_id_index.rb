Hanami::Model.migration do
  change do
    add_index :rates, :post_id
  end
end
