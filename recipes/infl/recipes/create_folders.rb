directory "#{node['sprout']['home']}/Code" do
  owner node['sprout']['user']
  action :create
end
