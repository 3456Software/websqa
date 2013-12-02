# NOTES

## Make a user an admin
Run the following at the command line:

 - locally: run `rails console` at the command line, then execute
``` ruby
User.where(id: 5).first.toggle!(:admin)
```
at the Rails console.

 - likewise, for heroku: run `heroku run rails console` at the command line, then
execute
``` ruby
User.where(id: 5).first.toggle!(:admin)
```
at Heroku's Rails console.

 - note that `:id` can be replaced by `:name` or `:email`
