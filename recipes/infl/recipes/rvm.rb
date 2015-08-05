::RVM_HOME = "#{node['sprout']['home']}/.rvm"
::RVM_COMMAND = "#{::RVM_HOME}/bin/rvm"

run_unless_marker_file_exists(marker_version_string_for("rvm")) do
  recursive_directories [RVM_HOME, 'src', 'rvm'] do
    owner node['current_user']
    recursive true
  end

  [
    "curl -Lsf http://get.rvm.io | bash -s -- stable --autolibs=enable --auto-dotfiles",
    "#{RVM_COMMAND} --version | grep Wayne"
  ].each do |rvm_cmd|
    execute rvm_cmd do
      user node['current_user']
    end
  end
end

node["rvm"]["rubies"].each do |version, options|
  rvm_ruby_install version do
    options options
  end
end

execute "making #{node["rvm"]["default_ruby"]} with rvm the default" do
  not_if { node["rvm"]["default_ruby"].nil? }
  command "#{::RVM_COMMAND} alias create default #{node["rvm"]["default_ruby"]}"
  user node['current_user']
end

execute "adding RVM weird line to .bash_profile" do
  rvm_line = '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"'
  command "echo '#{rvm_line}' >> #{node['sprout']['home']}/.bash_profile"
  not_if "grep #{rvm_line} #{node['sprout']['home']}/.bash_profile"
end
