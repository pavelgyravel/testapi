Hanami::Model.migration do
  change do
    create_table :posts do
      primary_key :id

      column :title, String, null: false
      column :content, String, null: false
      column :author_ip, :inet, null: false
      
      column :rate, Float, null: false, default: 0
      column :count_rate_need, FalseClass, null: false, default: false

      foreign_key :user_id, :users, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
