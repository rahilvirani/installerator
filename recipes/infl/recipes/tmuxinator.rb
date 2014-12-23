include_recipe "infl::create_folders"

['development.yml'].each do |file|
  link "#{node['sprout']['home']}/.tmuxinator/#{file}" do
    to "#{node['sprout']['home']}/Code/infl/devops/dotfiles/#{file}"
    owner node['current_user']
    not_if { File.symlink?("#{node['sprout']['home']}/.tmuxinator/#{file}") }
  end
end
