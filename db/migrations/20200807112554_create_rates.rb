Hanami::Model.migration do
  change do
    create_table :rates do
      primary_key :id

      column :rate, Integer, null: false, default: 1
      foreign_key :post_id, :posts, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
