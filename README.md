# Set Up Infrastructure

## Installerator (one day Interstaller)

Try not to add manual tasks here. If the script is missing something, just add it to the script. Ask Enric how.


#### Install dev-tools
This will add git and other tools for compiling gem extensions

```
xcode-select --install
```

#### Get SSH keys set up

```
ssh-keygen -t rsa -q -f ~/.ssh/id_rsa -P ""
cat ~/.ssh/id_rsa.pub | pbcopy
```

copy that output and add it to Github as new SSH key
```
https://github.com/settings/ssh
```

Use your personal github if it's associated to Influitive or use influitive-server and ask for password

#### Install homebrew & deps
```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

And install dependencies:
```
brew tap homebrew/versions
brew install git postgresql node012 node4.2 memcached
```

#### Install homebrew cask
Homebrew cask lets you package manage your common OS X Applications
```
brew install caskroom/cask/brew-cask
brew cask install google-chrome sublime-text3 iterm
```

#### Install RVM
```
\curl -sSL https://get.rvm.io | bash -s stable --ruby
```

#### Install global NPM deps
```
npm install --global gulp babel-cli karma-cli webpack
````

#### Install Installerator (very meta)

```
mkdir -p ~/Code/infl/devops
cd ~/Code/infl/devops
git clone https://github.com/influitive/installerator.git
cd installerator
sudo gem install bundler
bundle
bundle exec soloist
```
Last two steps take a while; have some more coffee. You may have to re-enter password multiple times.

### Post Installation

To install pow, vim modules, and atom's rubocop linter run

```
./post-install.sh
```

If `pow` doesn't work make sure that the `~/.pow` folder is a symlink to

```
/Users/dev/.pow -> /Users/dev/Library/Application Support/Pow/Hosts
```

test it by going to http://app.hub.dev You should get an Proxy Error not an Application Error

TODO: move the script into chef/soloist

## Set up the App

```
cd ~/Code/infl
```

For each project of [ 'hub', 'narci-service', 'api', 'waldo', 'community' ]

```
cd <<project>>
gem install bundler # maybe?
bundle
rvm install ruby...  # maybe
rake db:create db:schema:load  # where applicable (will fail otherwise)
```

##### In Hub project,

Gulp Stuff
```
npm install gulp -g
npm install
```

Open Rails console:
```
bundle exec rails c

c = Company.new
c.subdomain = "app"
c.name = "My company"
c.save


c = Company.new
c.subdomain = "philsfish"
c.name = "Annoying Company used in Tests"
c.save

```

Turn on servers
```
./script/foremanify  # first time only
servers
```

Get Integrations working:

```
cd engines/integrations
npm install
gulp
```
## Problems

If you get Dalli::Server errors in your log, try...

```
brew info memcached
```

and follow the instructions to start up memcached

#### Nokigiri failed to install

Complaining about libxml2? Try this:

  brew install libxml2
  bundle config build.nokogiri "--use-system-libraries --with-xml2-include=/usr/local/opt/libxml2/include/libxml2"
  bundle install

#### pg failed to install

First make sure postgresql is installed:

  brew install postgresql
  bundle config build.pg "--with-pg-config=/usr/local/Cellar/postgresql/9.4.5/bin/pg_config"
  env ARCHFLAGS="-arch x86_64" bundle install

#### `You don't have write permissions for the /Library/Ruby/Gems/2.0.0 directory`

1. Make sure RVM is installed:
```
rvm -v
```
2. Make sure your folder has a `.rvm-version file`
```
ls -la | grep .ruby-version
```
3.
```
cd .
```

And try again.

#### Other Problems

sorry.

## Done!

Visit http://app.hub.dev in your browser (you may need to type in the "http://") and see if things work. If not, :(

### Optional for bonus points

#### Alfred

I prefer Alfred to Spotlight. Applications, double-click it. You will probably want to go to Preferences->Keyboard->Shortcuts and remove CMD-SPACE from Spotlight and assign that as the shortcut for Alfred.

#### ShiftIt

I really miss this when I don't have it. Saves lots of time. Applications->ShiftIt Check open at login.

-- congrats!

### TODO

cx toolbelt installation
  you can find it in the installerator recipes folder. copy it to /user/local/bin
