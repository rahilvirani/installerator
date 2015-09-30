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
cat ~/.ssh/id_rsa.pub
```

copy that output and add it to Github as new SSH key
```
https://github.com/settings/ssh
```

Use your personal github if it's associated to Influitive or use influitive-server and ask for password


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

### POW

yeah, not working from script
```
curl get.pow.cx | sh
```

If POW doesn't work make sure that the ~/.pow folder is a symlink to
```
 /Users/dev/.pow -> /Users/dev/Library/Application Support/Pow/Hosts
```
test it by going to http://app.hub.dev
You should get an Proxy Error not an Application Error

### Vim

You'll get some package missing errors from vim, to fix that run from the command line:

```
vim +BundleInstall +qall
```

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
npm install -g gulp
gulp
```
## Problems

If you get Dalli::Server errors in your log, try...

```
brew info memcached
```

and follow the instructions to start up memcache

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
