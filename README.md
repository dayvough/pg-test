

# pg-test

This is the shirt.ly API repository.


## Requirements before installing

1. Ruby `>= 2.1.3` must be installed
2. Postgres must be installed

## Installing

1. Create a directory where you want keep the local repo
2. Run `git clone https://github.com/dayvough/pg-test.git`
3. Run `cd pg-test`
4. Run `bundle install` to install all of the Ruby dependencies
5. Create a local Postgres DB called `sinatra` (`CREATE DATABASE sinatra;`)
6. Run `rake db:migrate`
7. Start the app with `foreman start`, and
8. Access the site at `localhost:5000`

## Branching

It's recommended that before launching a new feature to the repo, you first create a branch and deploy it to the github first.

### Creating a new branch

1. First run `git pull` to make sure you have the latest changes
2. Create a branch with `git branch BRANCH_NAME`
3. Switch to the new branch you made with `git checkout BRANCH_NAME`
4. Add new changes to your code

### Uploading changes to your branch

1. Run `git add -A` to add all the files in your directory
2. Run `git commit -m "CHECKOUT_MESSAGE"` with a description in `CHECKOUT_MESSAGE` about what you just added
3. Run `git push -u origin BRANCH_NAME`
4. CircleCI will automatically pickup the commit and run it on the integration servers
5. When all your tests pass and the build Succeeds in the #ci channel, message @dayvough for a pull request

## Deploying

This section is mainly for @dayvough who's in charge of uploading things from the master branch to the production server.

Once a successful pull has been requested and successfully merged to the master, here are the steps to upload to deploy to the staging and production server:

1. To push to staging, run `git push -u origin master`
2. On a successful build on #ci, run `git push production master` to push to production