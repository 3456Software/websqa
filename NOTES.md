# NOTES

## Make a user an admin
**locally:**
run `rails console` at the command line, then execute the following

**heroku:**
run `heroku run rails console` at the command line, then
execute the following

``` ruby
User.where(id: 5).first.toggle!(:admin)
````
or
``` ruby
User.where(email: 'email@example.com').first.toggel!(:admin)
```
at the Rails console.
