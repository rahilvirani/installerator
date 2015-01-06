execute "create-root-user" do
  code = <<-EOH
    psql -U postgres -c "select * from pg_user where usename='root'" | grep -c root
  EOH
  command "createuser -U postgres -s root"
  not_if code
end

execute "create-database-user" do
  code = <<-EOH
    psql -U postgres -c "select * from pg_user where usename='#{node[:dbuser]}'" | grep -c #{node[:dbuser]}
  EOH
  command "createuser -U postgres -sw #{node[:dbuser]}"
  not_if code
end

execute "create-database" do
  exists = <<-EOH
    psql -U postgres -c "select * from pg_database WHERE datname='#{node[:dbname]}'" | grep -c #{node[:dbname]}
  EOH
  command "createdb -U postgres -O #{node[:dbuser]} -E utf8 -T template0 #{node[:dbname]}"
  not_if exists
end

