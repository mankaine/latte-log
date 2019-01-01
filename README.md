# Latte Log
A personal site to record adventures in latte art. 

## Just...why?
Why not?

## Dependencies
* [Postgres](https://www.postgresql.org)
* [Redis](https://redis.io)
* [Ruby on Rails](https://rubyonrails.org) and Ruby 2.5.3

## Startup
Run `pg_ctl -D /usr/local/var/postgres start` (Assuming you saved Postgres to your `/usr/local/var` directory)
Run `redis-server`
Run `rails s`

You will need to update multiple environment variables to run the program
locally.
* `ENV['GOOGLE_AUTH_CLIENT_ID']`: An OAuth 2.0 Client ID required to run the app. Get this value from creating a project on the Google Developers Console. When adding Authorized redirect URIs, ensure that `https://latte-log.herokuapp.com/oauth2callback` is included.
* `ENV['GOOGLE_AUTH_CLIENT_SECRET']`: An OAuth 2.0 secret corresponding to the above client ID. It will be presented with the client ID.
* `ENV['REDIS_URL']`: The Redis instance location. Ensure that this URL is included as one of the Authorized redirect URIs on the Google Developers Console.

## Running Tests
Run `rspec spec` in the home directory.

## TODOS
* Add feature to post latte art and notes
* Restrict access using passwords
* Improve authorization flow (it shouldn't have to generate a page not found
error)
* Add cancel button before creating entries in the database
* Embed YouTube videos (style points!)

