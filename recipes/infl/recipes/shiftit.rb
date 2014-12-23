# This installs an old version 1.6, and 2.3 is much better

remote_directory "/Applications/ShiftIt.app" do
  source "ShiftIt"
  owner node['current_user']
  action :create_if_missing
end
