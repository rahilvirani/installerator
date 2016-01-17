dest = "#{node['sprout']['home']}/Library/Preferences/com.googlecode.iterm2.plist"

template dest do
  owner node['sprout']['user']
  source "com.googlecode.iterm2.plist"
end

execute 'killall cfprefsd' do
  not_if { node['sprout']['terminal']['default_profile'].nil? }
end
