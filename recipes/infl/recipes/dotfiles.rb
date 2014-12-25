node['infl']['symlinks'].each do |file|
  link "#{node['sprout']['home']}/.#{file}" do
    to "#{node['sprout']['home']}/Code/infl/devops/dotfiles/#{file}"
    owner node['current_user']
    not_if { File.symlink?("#{node['sprout']['home']}/.#{file}") }
  end
end

node['infl']['sources'].each do |file|
  execute "adding #{file} as a source to .bash_profile" do
    command "echo 'source ~/.#{file}' >> #{node['sprout']['home']}/.bash_profile"
    not_if "grep #{file} #{node['sprout']['home']}/.bash_profile"
  end
end
