Sequel.migration do
  change do
    create_table(:page_visits) do
      primary_key :id
      column :url, "text"
      column :referrer, "text"
      column :created_at, "timestamp without time zone"
      column :hash, "text"
      
      index [:created_at]
      index [:referrer]
      index [:url]
    end
    
    create_table(:schema_migrations) do
      column :filename, "text", :null=>false
      
      primary_key [:filename]
    end
  end
end
Sequel.migration do
  change do
    self << "SET search_path TO \"$user\", public"
    self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20171218083259_create_page_visits.rb')"
  end
end
