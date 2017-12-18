### Requirements
* Ruby version
	- Ruby v-2.4.3
* Rails version
	- Rails 5.1.4
* Datebase
	- psql (PostgreSQL) 10.1
* System dependencies
	- yarn (https://yarnpkg.com/en/)
	- siege (http://brewformulas.org/Siege)
* Database creation
	- postgres=> `CREATE DATABASE usage_stat_development`;
* cd to the designated directory of the downloaded application and run below mentioned commands in chronological order:
	- `bundle install`
	- `yarn`
	- `./bin/rails db:migrate`
	- `unzip ./db/data/page_visits.csv.zip -d ./db/data/`
	- `./bin/rails db:seed`
	- `./bin/rails s`

Application should be up and running now.

### Load Testing
I have done load/stress testing using `siege`.
To perform load testing, please run below commands from the terminal:

-	siege -r 10 -c 100 http://localhost:3000/top_urls.json
-	siege -r 10 -c 100 http://localhost:3000/top_referrers.json
