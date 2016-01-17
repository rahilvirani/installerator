package "rabbitmq"

package_name = 'rabbitmq'
plist_name = "homebrew.mxcl.#{package_name}.plist"
launch_agents_path = File.expand_path(File.join(node.default['sprout']['home'] , 'Library/LaunchAgents'))

directory launch_agents_path do
  action :create
  recursive true
  owner node['sprout']['user']
end

execute "copy #{package_name} plist to ~/Library/LaunchAgents" do
  command "cp `brew --prefix mongodb`/#{plist_name} #{launch_agents_path} 2>/dev/null || :"
  user node['sprout']['user']
end

execute "load the #{package_name} plist into launchd" do
  command "launchctl load -w #{launch_agents_path}/#{plist_name}"
  user node['sprout']['user']
end
