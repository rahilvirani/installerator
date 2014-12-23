# An override of the sublime_text user preferences...
# I would have thought (from the docs) that I could just create a
# templates/mac_os_x/sublime_text-Preferences.sublime-settings.erb
# and chef would use that instead but I couldn't get it to work

include_recipe "sprout-osx-apps::sublime_text"

sublime_package_path = ["#{node['sprout']['home']}/Library/Application Support/Sublime Text 2", "Packages"]
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
