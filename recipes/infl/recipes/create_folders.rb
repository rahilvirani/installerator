directory "#{node['sprout']['home']}/Code" do
  owner node['sprout']['user']
  action :create
end

directory "#{node['sprout']['home']}/.tmuxinator" do
  owner node['sprout']['user']
  action :create
end

directory "#{node['sprout']['home']}/.pow" do
  owner node['sprout']['user']
  action :create
end
