# urls = [
#   "http://apple.com",
#   "https://apple.com",
#   "https://www.apple.com",
#   "http://developer.apple.com",
#   "http://en.wikipedia.org",
#   "http://opensource.org",
#   "http://example1.com",
#   "http://example2.com",
#   "http://example3.com",
#   "http://example4.com",
#   "http://example5.com",
#   "http://example6.com",
#   "http://example7.com",
#   "http://example8.com",
#   "http://example9.com",
#   "http://example10.com",
#   "http://example11.com",
#   "http://example12.com",
#   "http://example13.com",
#   "http://example14.com",
#   "http://example15.com",
#   "http://example16.com",
#   "http://example17.com",
#   "http://example18.com",
#   "http://example19.com",
#   "http://example20.com",
#   "http://example21.com",
#   "http://example22.com",
#   "http://example23.com",
#   "http://example24.com",
#   "http://example25.com",
#   "http://example26.com",
#   "http://example27.com",
#   "http://example28.com",
#   "http://example29.com",
#   "http://example30.com",
#   "http://example31.com",
#   "http://example32.com",
#   "http://example33.com",
#   "http://example34.com"
# ]
#
# referrers = [
#   "http://apple.com",
#   "https://apple.com",
#   "https://www.apple.com",
#   "http://developer.apple.com",
#   "http://example1.com",
#   "http://example2.com",
#   "http://example3.com",
#   "http://example4.com",
#   "http://example5.com",
#   "http://example6.com",
#   "http://example7.com",
#   "http://example8.com",
#   "http://example9.com",
#   "http://example10.com",
#   "http://example11.com",
#   "http://example12.com",
#   "http://example13.com",
#   "http://example14.com",
#   "http://example15.com",
#   "http://example16.com",
#   "http://example17.com",
#   "http://example18.com",
#   "http://example19.com",
#   "http://example20.com",
#   "http://example21.com",
#   "http://example22.com",
#   "http://example23.com",
#   "http://example24.com",
#   "http://example25.com",
#   "http://example26.com",
#   "http://example27.com",
#   "http://example28.com",
#   "http://example29.com",
#   "http://example30.com",
#   "http://example31.com",
#   "http://example32.com",
#   "http://example33.com",
#   "http://example34.com",
#   nil
# ]
#
# dates = (1..730).collect { |i| Time.current - i.days }
#
# 1000000.times do
#   PageVisit.create(
#     url: urls.sample,
#     referrer: referrers.sample,
#     created_at: dates.sample
#   )
# end
#

#
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
