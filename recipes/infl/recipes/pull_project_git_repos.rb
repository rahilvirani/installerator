# Recipe to pull any git repositories marked with always_pull: true.
#
# This is written as a separate recibe because pivotal-sprout/sprout-git's
# projects recipe is not owned by us, and the post_clone_commands are run only
# if the repo is cloned.  This means that existing repos will not be refreshed
# with a pull if we try using post_clone_commands.

include_recipe 'sprout-base::workspace_directory'
require 'pathname'

node['sprout']['git']['projects'].each do |hash_or_array|
  # The always_pull key can't be represented in "legacy" Arrays in the list of
  # projects.
  next if hash_or_array.is_a? Array

  project_hash = hash_or_array

  repo_address = project_hash['url']
  repo_name = project_hash['name'] || %r{^.+\/([^\/\.]+)(?:\.git)?$}.match(repo_address)[1]
  repo_dir = project_hash['workspace_path']
  always_pull = project_hash['always_pull']

  repo_dir ||= "#{node['sprout']['home']}/#{node['sprout']['git']['workspace_directory']}"
  repo_dir = Pathname(repo_dir).expand_path

  execute 'git pull' do
    user node['sprout']['user']
    cwd (repo_dir + repo_name).to_s
    ignore_failure true
    only_if { always_pull && (repo_dir + repo_name + '.git').directory? }
  end
end
