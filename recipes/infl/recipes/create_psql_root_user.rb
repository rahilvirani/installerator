execute 'create a database for the current user' do
  command "/usr/local/bin/createdb -U postgres"
  user "root"
  not_if "psql -U postgres -c 'select 1' postgres &> /dev/null"
end

execute 'create the postgres superuser' do
  command "/usr/local/bin/createuser -U postgres --superuser root"
  user "root"
  not_if 'psql -U postgres -c "select 1" &> /dev/null'
end

