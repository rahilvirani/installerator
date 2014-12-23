package "rabbitmq"

directory "/Users/#{node['current_user']}/Library/LaunchAgents" do
  owner node['current_user']
  action :create
end

execute "copy rabbitMQ plist to ~/Library/LaunchAgents" do
  command "cp `brew --prefix rabbitmq`/homebrew.mxcl.rabbitmq.plist #{node['sprout']['home']}/Library/LaunchAgents/  2>/dev/null || :"
  user node['current_user']
end

execute "load the rabbitmq plist into the mac daemon startup thing" do
  command "launchctl load -w #{node['sprout']['home']}/Library/LaunchAgents/homebrew.mxcl.rabbitmq.plist"
  user node['current_user']
end

