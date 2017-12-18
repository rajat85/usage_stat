Sequel.migration do
  change do

    create_table :page_visits do
      primary_key :id
      String :url, index: true
      String :referrer, index: true
      DateTime :created_at, index: true
      String :hash
    end

  end
end
