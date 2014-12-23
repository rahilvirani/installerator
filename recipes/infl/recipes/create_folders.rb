directory "#{node['sprout']['home']}/Code" do
  owner node['current_user']
  action :create
end

directory "#{node['sprout']['home']}/.tmuxinator" do
  owner node['current_user']
  action :create
end
