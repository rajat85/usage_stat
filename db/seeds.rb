def csv_file_path
  Rails.root.join('db/data/page_visits.csv').to_path
end

def db_name
  config = Rails.configuration.database_configuration[Rails.env]
  "postgresql://#{config['username']}:#{config['password']}@127.0.0.1:5432/#{config['database']}"
end

puts "Executing seed..."
puts "Executing commad: cat #{csv_file_path} | psql --dbname=#{db_name} -c 'COPY page_visits FROM STDIN WITH CSV HEADER'."
status = system "cat #{csv_file_path} | psql --dbname=#{db_name} -c 'COPY page_visits FROM STDIN WITH CSV HEADER'"
if (status)
  puts "Seed executed successfully."
else
  puts "Data already exisits."
end
