execute "adding settings to .bash_profile" do
  command "echo 'export EDITOR=subl' >> #{node['sprout']['home']}/.bash_profile"
  not_if "grep EDITOR #{node['sprout']['home']}/.bash_profile"
end


