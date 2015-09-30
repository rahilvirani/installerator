execute "adding settings to .bash_profile" do
  command "echo 'ulimit -S -n 2048'  >> #{node['sprout']['home']}/.bash_profile"
  command "echo 'export EDITOR=atom' >> #{node['sprout']['home']}/.bash_profile"

  not_if "grep EDITOR #{node['sprout']['home']}/.bash_profile"
end
