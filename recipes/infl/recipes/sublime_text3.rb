# An override of the sublime_text user preferences...
# I would have thought (from the docs) that I could just create a
# templates/mac_os_x/sublime_text-Preferences.sublime-settings.erb
# and chef would use that instead but I couldn't get it to work

# include_recipe "sprout-osx-apps::sublime_text"

include_recipe "sprout-base::user_owns_usr_local"

execute "brew tap caskroom/versions" do
    command "brew tap caskroom/versions"
      user node['current_user']
end

homebrew_cask "sublime-text3"

link "/usr/local/bin/subl" do
  to "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
end

sublime_package_path = ["#{node['sprout']['home']}/Library/Application Support/Sublime Text 3", "Packages"]
sublime_user_path = sublime_package_path.dup << "User"

recursive_directories sublime_user_path do
  owner node['sprout']['user']
end

node["sublime_text_packages"].each do |package|
  sprout_osx_apps_sublime_package package["name"] do
    source package["source"]
    destination File.join(sublime_package_path)
    owner node['sprout']['user']
  end
end

template File.expand_path("Preferences.sublime-settings", File.join(sublime_user_path)) do
  source "sublime_text-Preferences.sublime-settings.erb"
  owner node['sprout']['user']
  action :create_if_missing
end

package_dir = "#{node['sprout']['home']}/Library/Application Support/Sublime Text 3/Installed Packages"
filename    = "Package Control.sublime-package"

recursive_directories(["#{node['sprout']['home']}/Library/Application Support", "Sublime Text 3", "Installed Packages"]) do
  owner node['sprout']['user']
end

remote_file "#{package_dir}/#{filename}" do
  source 'http://sublime.wbond.net/Package%20Control.sublime-package'
  owner node['sprout']['user']
  :create_if_missing
end

# end of content of https://github.com/pivotal-sprout/sprout-osx-apps/blob/master/recipes/sublime_text.rb

sublime_package_path = ["#{node['sprout']['home']}/Library/Application Support/Sublime Text 3", "Packages"]
sublime_user_path = sublime_package_path.dup << "User"

begin
  r = resources(:template => File.expand_path("Preferences.sublime-settings", File.join(sublime_user_path)))
  r.cookbook "infl"
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn "could not find template to override!"
end


# Have Sublime Linter use ruby 2.0 for it's syntax checking
linter_user_settings = File.expand_path("SublimeLinter.sublime-settings", File.join(sublime_user_path))

template linter_user_settings do
  source "sublime_linter-Preferences.sublime-settings.erb"
  owner node['current_user']
  mode "0644"
  not_if { File.exists?(linter_user_settings) }
end

# Have Sublime Key Bindings unless already set up
key_bindings = File.expand_path("Default (OSX).sublime-keymap", File.join(sublime_user_path))

template key_bindings do
  source "Default (OSX).sublime-keymap"
  owner node['current_user']
  mode "0644"
  not_if { File.exists?(key_bindings) }
end

# Set syntax to Ruby for all extensions listed in this template
ruby_syntax_extensions = File.expand_path("Ruby.sublime-settings", File.join(sublime_user_path))

template ruby_syntax_extensions do
  source "sublime_text-Ruby.sublime-settings.erb"
  owner node['current_user']
  mode "0644"
end

# License key
