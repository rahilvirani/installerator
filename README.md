# Set Up Infrastructure

## Installerator (formerly sprout-wrap)

Try not to add manual tasks here. If the script is missing something, just add it to the script. Ask Enric how. 


#### Install GIT
```
http://git-scm.com/download/mac
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
sudo gem install bundler
bundle
bundle exec soloist 
```
Last two steps take a while; have some more coffee. You may have to re-enter password multiple times.

### VIM

```
vim +PluginInstall +qall now
```

### POW

yeah, not working from script
```
curl get.pow.cx | sh
```

## Set up the App

``` 
cd ~/Code/infl
```

For each project of [ 'hub', 'narci-service', 'api', 'waldo', 'community' ]

```
cd <<project>>
bundle
rvm install ruby...  # maybe
rake db:create db:schema:load  # where applicable
```

##### In Hub project, 

Turn on servers
```
./script/foremanify  # first time only
servers
```

Open Rails console: 
```
bundle exec rails c

c = Company.new
c.subdomain = "app"
c.name = "My company"
c.save

exit
rake db:seed
```

Get custom colours working:
`npm install`

#### Done!

Visit http://app.hub.dev in your browser (you may need to type in the "http://") and see if things work. If not, :(

