# Developer Setup
Running Windows? See: http://railsinstaller.org/en

Otherwise, this guide will help you get up and running on Linux. I'd recommend
Ubuntu or Fedora, but if you already have a distro up and running, anything will
work!

**NOTE:** A `$` below represents the command is to be entered at the command line.

## Git
First things first, we'll install git! Create a GitHub account, then follow the instructions on
[GitHub's help page](https://help.github.com/articles/set-up-git#platform-linux)
for a detailed walkthrough on configuring your installation.

## RVM: Ruby Version Manager
[RVM](http://rvm.io/) helps manage multiple versions of Ruby, since your system may or may not
have come with an older version already. Installing rvm is as easy as
```
$ \curl -L https://get.rvm.io | bash
```

Then we want to run
```
$ rvm install 2.0.0
$ rvm use 2.0.0 --default
$ rvm reload
```

Verify that you are now running Ruby 2.0.0 with
```
$ ruby --version
ruby 2.0.0p247 (...) [...]
```

## RubyGems and Rails
Now that we have Ruby installed, we will update RubyGems, our ruby package manager, and install/update
Bundler, which manages our applications dependencies.
```
$ gem update --system
$ gem install bundler
```

Now we install Rails as a gem using
```
$ gem install rails
$ rails --version
Rails 4.0.0
```
