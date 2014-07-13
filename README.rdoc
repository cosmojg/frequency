## Frequency

Frequency is an online Nintendo community that has a discussion board, picture sharing, profiles and a chatroom system to connect gamers.

### Installation instructions

It's easy to get started, just run the following commands in your command line of choice. First we need to bundle install to get all of the application's dependencies:

```
bundle install
```

Next make sure you have a local instance of Postgres running. If you're on a Mac, the easiest way to do this is to have the [Postgres app](http://postgresapp.com/) running.

Then we need to create a new database:

```
rake db:create
```

Run all of the pending migrations:

```
rake db:migrate
```


Then install [ImageMagick](http://www.imagemagick.org/script/binary-releases.php) which will allow you to process avatars and images locally.

Create a new user account by signing up, then open the rails console with `rails c`. Then type in:

```
u = User.first
u.admin = 'true'
u.save
```

### Deployment Notes

We are using a Heroku labs user-env-compile (https://devcenter.heroku.com/articles/labs-user-env-compile) which fixes precompiling assets at deploy time. This means that changing environment variables on Heroku will NO LONGER RECOMPILE THE APP. Hence, the variables you imposed will not be visible in the app yet. This means you need to push separate code to force recompilation.

If asset precompilation ever fails and you have modified *any* of the assets, you can manually run

 heroku run rake assets:precompile

If you ever have to run migrations for a deploy, turn on maintenance mode *before* deploying:

 heroku maintenance:on

And then turn it off once deployment is done

 heroku maintenance:off

### Testing Memory

We use Oink which lets us test for memory leaks. In order to do this, run:

 oink --threshold=1 log/*

or for more detail

 oink --format verbose  --threshold=1 log/*

Mac users can run an Apache benchmarking tool which lets you force memory leaks to accrue memory usage:

 ab -kc 6 -t 30  http://127.0.0.1:3000/